page 69024 "ACA-Examination Stds List"
{
    Caption = 'All Students List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student));

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
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Town';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Tagged as Graduating"; Rec."Tagged as Graduating")
                {
                    ApplicationArea = All;
                }
                field("Graduating Academic Year"; Rec."Graduating Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Cumm. Failed Courses"; Rec."Cumm. Failed Courses")
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
                action("Semester registration")
                {
                    Caption = 'Trimester registration';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 68756;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(StoppedReg)
                {
                    Caption = 'Stopped Registrations';
                    Image = StopPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 77721;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Student Units")
                {
                    Caption = 'Student Units';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Student Units";
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Print Statement")
                {
                    Caption = 'Print Statement';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Cust.RESET;
                        Cust.SETFILTER(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            REPORT.RUN(51072, TRUE, TRUE, Cust);
                    end;
                }
            }
        }
        area(processing)
        {
            action(Irregularities)
            {
                Caption = 'Irregularities Register';
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 77737;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;

                trigger OnAction()
                var
                    ACAIrregularitiesRegister: Record "ACA-Irregularities Register";
                begin
                end;
            }
        }
    }

    var
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
