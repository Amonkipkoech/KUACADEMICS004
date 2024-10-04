page 68972 "ACA-Student Clearance (Active)"
{
    Caption = 'Student Clearance (Active)';
    CardPageID = "ACA-Clearance View Card Unedit";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            "Clearance Status" = FILTER(= Active));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Clearance Semester"; Rec."Clearance Semester")
                {
                    ApplicationArea = All;
                }
                field("Clearance Academic Year"; Rec."Clearance Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Programme End Date"; Rec."Programme End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action(revClearance)
                {
                    Caption = 'Reverse Clearance';
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ClearLevela: Record "ACA-Clearance Level Codes";
                        ClearTemplates: Record "ACA-Clearance templates";
                        ClearDepTemplates: Record "ACA-Clearance Dept. Approvers";
                        ClearStandardApp: Record "ACA-Clearance Std Approvers";
                        cust: Record Customer;
                        ClearEntries: Record "ACA-Clearance Approval Entries";
                    begin
                        IF CONFIRM('Reverse the clearance process?', FALSE) = FALSE THEN ERROR('Cancelled!');
                        // Delete Clearance entries
                        clearEnt.RESET;
                        clearEnt.SETRANGE(clearEnt."Student ID", Rec."No.");
                        IF clearEnt.FIND('-') THEN clearEnt.DELETEALL;
                        IF cust.GET(Rec."No.") THEN BEGIN
                            cust."Clearance Status" := cust."Clearance Status"::open;
                            cust.MODIFY;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                action(printForm)
                {
                    Caption = 'Print Clearance Form';
                    Image = PrintVoucher;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        stud.RESET;
                        stud.SETRANGE(stud."No.", Rec."No.");
                        IF stud.FIND('+') THEN
                            REPORT.RUN(51675, TRUE, FALSE, stud);
                    end;
                }
                action("Clearance Entries")
                {
                    Caption = 'Clearance Entries';
                    Image = Entries;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 69073;
                    RunPageLink = "Student ID" = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Student ID Card")
                {
                    Caption = 'Student ID Card';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        stud.RESET;
                        stud.SETRANGE(stud."No.", Rec."No.");
                        IF stud.FIND('+') THEN
                            REPORT.RUN(51729, TRUE, FALSE, stud);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Mark As Alluminae")
            {
                Caption = 'Mark As Alluminae';
                Image = Status;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to mark this students as an alluminae?', TRUE) = TRUE THEN BEGIN
                        Rec.Status := Rec.Status::Alluminae;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    var
        clearEnt: Record "ACA-Clearance Approval Entries";
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        AccPayment: Boolean;
        SettlementType: Code[20];
        CustL: Record "Cust. Ledger Entry";
        Stages3: Record "ACA-Programme Stages";
        Units3: Record "ACA-Units/Subjects";
        ExamsByStage3: Record "ACA-Exams";
        ExamsByUnit3: Record "ACA-Exams By Units";
        Charges3: Record "ACA-Charge";
        Receipt3: Record "ACA-Receipt";

        stud: Record Customer;

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

