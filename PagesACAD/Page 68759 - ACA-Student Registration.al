/// <summary>
/// Page ACA-Student Registration (ID 68759).
/// </summary>
page 68759 "ACA-Student Registration"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("UNISA No"; Rec."UNISA No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'County';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payments By"; Rec."Payments By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Membership No"; Rec."Membership No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("No. Of Receipts"; Rec."No. Of Receipts")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Old Student Code"; Rec."Old Student Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field(CurrentBill; CurrentBill)
                {
                    Caption = 'Current Bill';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("<Phone >"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
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
                    Caption = 'Tremester registration';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "ACA-Course Registration 3";
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
                    RunObject = Page 68778;
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
                action(Picture)
                {
                    Caption = 'Photo';
                    Ellipsis = false;
                    Image = Picture;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 68855;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Registration Details")
                {
                    Caption = 'Registration Details';
                    Image = Info;
                    RunObject = Page 68759;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Register)
                {
                    Caption = 'Register';
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CALCFIELDS("Balance (LCY)");
                        IF Rec."Balance (LCY)" > 0 THEN
                            //ERROR('You cannot register a student with a balance.');



                            CourseReg.RESET;
                        CourseReg.SETRANGE(CourseReg."Student No.", Rec."No.");
                        IF CourseReg.FIND('+') THEN BEGIN
                            CourseReg.Registered := TRUE;
                            CourseReg.MODIFY;
                        END;
                    end;
                }
                action("De-Register")
                {
                    Caption = 'De-Register';
                    Image = ChangeStatus;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CourseReg.RESET;
                        CourseReg.SETRANGE(CourseReg."Student No.", Rec."No.");
                        IF CourseReg.FIND('+') THEN BEGIN
                            CourseReg.Registered := FALSE;
                            CourseReg.MODIFY;
                        END;
                    end;
                }
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
        area(processing)
        {
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
            action(IDChecklist)
            {
                Caption = 'ID Checklist';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // // stud.RESET;
                    // // stud.SETRANGE(stud."No.","No.");
                    // // IF stud.FIND('+') THEN
                    REPORT.RUN(77700, TRUE, FALSE);
                end;
            }
            action("Transfer Student Accounts 22")
            {
                Caption = 'Transfer Student Accounts 22';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //TESTFIELD("Transfer to No.");
                    //TESTFIELD("Transfer to");
                    Rec.CALCFIELDS("Balance (LCY)");
                    IF NOT Cust.GET(Rec."Transfer to No.") THEN BEGIN
                        Cust.INIT;
                        Cust."No." := Rec."Transfer to No.";
                        Cust.Name := Rec.Name;
                        Cust.VALIDATE(Cust.Name);
                        Cust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        Cust."Customer Posting Group" := Rec."Customer Posting Group";
                        Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                        Cust.Status := Cust.Status::Current;
                        Cust."Customer Type" := Cust."Customer Type"::Student;
                        Cust."Date Registered" := Rec."Date Registered";
                        Cust.INSERT(TRUE);
                    END;



                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    CustL.RESET;
                    CustL.SETRANGE(CustL."Customer No.", Rec."No.");
                    IF CustL.FIND('-') THEN BEGIN
                        REPEAT
                            CustL.CALCFIELDS(CustL.Amount);
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := CustL."Posting Date";
                            GenJnl."Document No." := CustL."Document No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."No.";
                            GenJnl.Amount := CustL.Amount * -1;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := CustL.Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                            //GenJnl."Bal. Account No.":="Transfer to No.";
                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            /*
                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.","No.");
                            IF CReg.FIND('+') THEN BEGIN
                            */
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;


                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := CustL."Posting Date";
                            GenJnl."Document No." := CustL."Document No.";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."Transfer to No.";
                            GenJnl.Amount := CustL.Amount;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := CustL.Description;
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                            //GenJnl."Bal. Account No.":="Transfer to No.";
                            //GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                            //GenJnl."Shortcut Dimension 2 Code":="Transfer to";
                            //GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            IF GenJnl.Amount <> 0 THEN
                                GenJnl.INSERT;

                        UNTIL CustL.NEXT = 0;
                    END;

                    Receipts.RESET;
                    Receipts.SETRANGE(Receipts."Student No.", Rec."No.");
                    Receipts.SETRANGE(Receipts.Reversed, FALSE);
                    IF Receipts.FIND('-') THEN BEGIN
                        REPEAT
                            Receipts."Student No." := Rec."Transfer to No.";
                            Receipts.MODIFY;
                        UNTIL Receipts.NEXT = 0;
                    END;



                    //Post
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);
                    END;



                    Rec.Status := Rec.Status::Transferred;
                    Rec.Blocked := Rec.Blocked::All;
                    Rec.MODIFY;



                    MESSAGE('%1', 'Student transferred successfully.');

                end;
            }
            action("Transfer Student Accounts")
            {
                Caption = 'Transfer Student Accounts';
                Image = TransferFunds;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 69033;
                RunPageLink = "Student No" = FIELD("No.");
                Visible = true;
                ApplicationArea = All;
            }
            action("Student Kin")
            {
                Image = CustomerContact;
                Promoted = true;
                RunObject = Page 68752;
                RunPageLink = "Student No" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Sponsors)
            {
                Image = CustomerCode;
                Promoted = true;
                RunObject = Page 68754;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Student Education History")
            {
                Image = History;
                Promoted = true;
                RunObject = Page 68753;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Student Disciplinary Details")
            {
                Image = Addresses;
                Promoted = true;
                RunObject = Page 68755;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Students Units Booking")
            {
                Image = ReceivableBill;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                //RunObject = Page 68818;
                //RunPageLink = Cleared = FIELD("No.");
            }
            action("Student Units Exemptions")
            {
                Image = Reserve;
                Promoted = true;
                RunObject = Page 68791;
                RunPageLink = "Student No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Total Billed", "Total Paid");
        CurrentBill := Rec."Total Billed" - Rec."Total Paid";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Customer Type" := Rec."Customer Type"::Student;
        Rec."Date Registered" := TODAY;
    end;

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

}

