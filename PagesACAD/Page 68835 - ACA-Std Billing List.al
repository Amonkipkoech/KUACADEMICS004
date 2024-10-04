/// <summary>
/// Page ACA-Std Billing List (ID 68835).
/// </summary>
page 68835 "ACA-Std Billing List"
{
    Caption = 'All Students List';
    CardPageID = "ACA-Student Billing";
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
                field("ID No"; Rec."ID No")
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
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Catering Amount"; Rec."Catering Amount")
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Registratin)
            {
                Caption = 'Registration';
                action("Trimester registration")
                {
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
                action("Posted Charges")
                {
                    Caption = 'Posted Charges';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = false;
                    RunObject = Page "ACA-Student Posted Charges";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = Receipt;
                    Promoted = true;
                    RunObject = Page 68765;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Post Batch Billing")
                {
                    Caption = 'Post Batch Billing';
                    Image = Report2;
                    Promoted = true;
                    RunObject = Report 51539;
                    ApplicationArea = All;
                }
            }
            group(Registration)
            {
                Caption = 'Registration';
                action(Prerequisite)
                {
                    Caption = 'Prerequisite';
                    Image = Approval;
                    RunObject = Page 68777;
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("&Student")
            {
                Caption = '&Student';
                action("Edit Details")
                {
                    Caption = 'Edit Details';
                    Image = EditCustomer;
                    RunObject = Page "ACA-Students Card";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = LedgerEntries;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                    action("Issued &Reminders")
                    {
                        Caption = 'Issued &Reminders';
                        RunObject = Page 438;
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        Caption = 'Issued &Finance Charge Memos';
                        RunObject = Page 450;
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(18),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page 423;
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ship-&to Addresses")
                {
                    Caption = 'Ship-&to Addresses';
                    RunObject = Page 300;
                    RunPageLink = "Customer No." = FIELD("No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("C&ontact")
                {
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                separator(____)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 151;
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }

                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page 302;
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    Visible = false;
                    ApplicationArea = All;
                }

                separator(________________)
                {
                    Caption = '';
                }
                action("Ser&vice Contracts")
                {
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page 6065;
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Service &Items")
                {
                    Caption = 'Service &Items';
                    RunObject = Page 5988;
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                    Visible = false;
                    ApplicationArea = All;
                }

                action("&Jobs")
                {
                    Caption = '&Jobs';
                    RunObject = Page 88;
                    RunPageLink = "Bill-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Bill-to Customer No.");
                    Visible = false;
                    ApplicationArea = All;
                }

            }
            group("&Transact")
            {
                Caption = '&Transact';
                action(Receipting)
                {
                    Caption = 'Receipting';
                    Image = Receipt;
                    RunObject = Page 68788;
                    RunPageLink = "Student No." = FIELD("No.");
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
                action(Billing)
                {
                    Caption = 'Billing';
                    Image = VendorBill;
                    RunObject = Page "ACA-Students Card";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("Catering Funds Transfers")
            {
                Caption = 'Catering Funds Transfers';
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "ACA-Catering Funds Transfer";
                RunPageLink = "Student No" = FIELD("No.");
                ApplicationArea = All;
            }
            action("Make Payment")
            {
                Caption = 'Make Payment';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /////////**************************************************************************************************************************
                    //BILLING
                    AccPayment := FALSE;
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", Rec."No.");
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    StudentCharges.SETFILTER(StudentCharges.Code, '<>%1', '');
                    IF StudentCharges.FIND('-') THEN BEGIN
                        IF NOT CONFIRM('Un-billed charges will be posted. Do you wish to continue?', FALSE) = TRUE THEN
                            ERROR('You have selected to Abort Student Billing');


                        SettlementType := '';
                        CReg.RESET;
                        CReg.SETFILTER(CReg."Settlement Type", '<>%1', '');
                        CReg.SETRANGE(CReg."Student No.", Rec."No.");
                        IF CReg.FIND('-') THEN
                            SettlementType := CReg."Settlement Type"
                        ELSE
                            ERROR('The Settlement Type Does not Exists in the Course Registration');

                        SettlementTypes.GET(SettlementType);
                        SettlementTypes.TESTFIELD(SettlementTypes."Tuition G/L Account");




                        // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS//
                        IF StudentCharges.COUNT = 1 THEN BEGIN
                            Rec.CALCFIELDS(Balance);
                            IF Rec.Balance < 0 THEN BEGIN
                                IF ABS(Rec.Balance) > StudentCharges.Amount THEN BEGIN
                                    Rec."Application Method" := Rec."Application Method"::Manual;
                                    AccPayment := TRUE;
                                    Rec.MODIFY;
                                END;
                            END;
                        END;

                    END;


                    //ERROR('TESTING '+FORMAT("Application Method"));

                    IF Cust.GET(Rec."No.") THEN;

                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    GenSetUp.GET();
                    //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

                    //Charge Student if not charged
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", Rec."No.");
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                    IF StudentCharges.FIND('-') THEN BEGIN

                        REPEAT
                            IF StudentCharges.Amount <> 0 THEN BEGIN
                                DueDate := StudentCharges.Date;
                                IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                                    IF Sems.From <> 0D THEN BEGIN
                                        IF Sems.From > DueDate THEN
                                            DueDate := Sems.From;
                                    END;
                                END;


                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := TODAY;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                                //
                                IF Cust.GET(Rec."No.") THEN BEGIN
                                    IF Cust."Bill-to Customer No." <> '' THEN
                                        GenJnl."Account No." := Cust."Bill-to Customer No."
                                    ELSE
                                        GenJnl."Account No." := Rec."No.";
                                END;

                                GenJnl.Amount := StudentCharges.Amount;
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := StudentCharges.Description;
                                GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                                   (StudentCharges.Charge = FALSE) THEN BEGIN
                                    GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                                    CReg.RESET;
                                    CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                    CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                    CReg.SETRANGE(CReg."Student No.", StudentCharges."Student No.");
                                    IF CReg.FIND('-') THEN BEGIN
                                        IF CReg."Register for" = CReg."Register for"::Stage THEN BEGIN
                                            Stages.RESET;
                                            Stages.SETRANGE(Stages."Programme Code", CReg.Programmes);
                                            Stages.SETRANGE(Stages.Code, CReg.Stage);
                                            IF Stages.FIND('-') THEN BEGIN
                                                IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units" = FALSE) THEN BEGIN
                                                    CReg.CALCFIELDS(CReg."Units Taken");
                                                    IF CReg.Modules <> CReg."Units Taken" THEN
                                                        ERROR('Units Taken must be equal to the no of modules registered for.');

                                                END;
                                            END;
                                        END;

                                        CReg.Posted := TRUE;
                                        CReg.MODIFY;
                                    END;


                                END ELSE
                                    IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                                       (StudentCharges.Charge = FALSE) THEN BEGIN
                                        //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                                        StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                        GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";


                                        CReg.RESET;
                                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                                        CReg.SETRANGE(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                                        IF CReg.FIND('-') THEN BEGIN
                                            CReg.Posted := TRUE;
                                            CReg.MODIFY;
                                        END;



                                    END ELSE
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                            IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                                GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                                        END ELSE
                                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                                IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                                StudentCharges.Code) THEN
                                                    GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                                            END ELSE
                                                IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                                                   (StudentCharges.Charge = TRUE) THEN BEGIN
                                                    IF Charges.GET(StudentCharges.Code) THEN
                                                        GenJnl."Bal. Account No." := Charges."G/L Account";
                                                END;


                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                    Prog.TESTFIELD(Prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                END;



                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                GenJnl."Due Date" := DueDate;
                                GenJnl.VALIDATE(GenJnl."Due Date");
                                IF StudentCharges."Recovery Priority" <> 0 THEN
                                    GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                                ELSE
                                    GenJnl."Recovery Priority" := 25;
                                GenJnl.INSERT;

                                //Distribute Money
                                IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                        IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                            Stages.TESTFIELD(Stages."Distribution Account");
                                            StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                            IF Cust.GET(Rec."No.") THEN BEGIN
                                                CustPostGroup.GET(Cust."Customer Posting Group");

                                                GenJnl.INIT;
                                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                                GenJnl."Posting Date" := TODAY;
                                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                                //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                                GenJnl.VALIDATE(GenJnl."Document No.");
                                                GenJnl."Journal Template Name" := 'SALES';
                                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                                //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                                GenJnl."Account No." := SettlementTypes."Tuition G/L Account";
                                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                                GenJnl.VALIDATE(GenJnl."Account No.");
                                                GenJnl.VALIDATE(GenJnl.Amount);
                                                GenJnl.Description := 'Fee Distribution';
                                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                                //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                                StudentCharges.CALCFIELDS(StudentCharges."Settlement Type");
                                                SettlementTypes.GET(StudentCharges."Settlement Type");
                                                GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                                GenJnl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                                IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                                    Prog.TESTFIELD(Prog."Department Code");
                                                    GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                                END;

                                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                                GenJnl.INSERT;

                                            END;
                                        END;
                                    END;
                                END ELSE BEGIN
                                    //Distribute Charges
                                    IF StudentCharges.Distribution > 0 THEN BEGIN
                                        StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
                                        IF Charges.GET(StudentCharges.Code) THEN BEGIN
                                            Charges.TESTFIELD(Charges."G/L Account");
                                            GenJnl.INIT;
                                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                                            GenJnl."Posting Date" := TODAY;
                                            GenJnl."Document No." := StudentCharges."Transacton ID";
                                            GenJnl.VALIDATE(GenJnl."Document No.");
                                            GenJnl."Journal Template Name" := 'SALES';
                                            GenJnl."Journal Batch Name" := 'STUD PAY';
                                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                            GenJnl."Account No." := StudentCharges."Distribution Account";
                                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                            GenJnl.VALIDATE(GenJnl."Account No.");
                                            GenJnl.VALIDATE(GenJnl.Amount);
                                            GenJnl.Description := 'Fee Distribution';
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenJnl."Bal. Account No." := Charges."G/L Account";
                                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                            GenJnl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";

                                            IF Prog.GET(StudentCharges.Programme) THEN BEGIN
                                                Prog.TESTFIELD(Prog."Department Code");
                                                GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                            END;
                                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                            GenJnl.INSERT;

                                        END;
                                    END;
                                END;
                                //End Distribution


                                StudentCharges.Recognized := TRUE;
                                StudentCharges.MODIFY;
                                //.......BY BKK
                                StudentCharges.Posted := TRUE;
                                StudentCharges.MODIFY;

                                CReg.Posted := TRUE;
                                CReg.MODIFY;


                                //.....END BKK
                            END;
                        UNTIL StudentCharges.NEXT = 0;


                        /*
                        GenJnl.SETRANGE("Journal Template Name",'SALES');
                        GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                        REPEAT
                        GLPosting.RUN(GenJnl);
                        UNTIL GenJnl.NEXT = 0;
                        END;


                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name",'SALES');
                        GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                        GenJnl.DELETEALL;
                        */

                        //Post New
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
                        END;

                        //Post New


                        Rec."Application Method" := Rec."Application Method"::"Apply to Oldest";
                        Cust.Status := Cust.Status::Current;
                        Cust.MODIFY;

                    END;


                    //BILLING

                    StudentPayments.RESET;
                    StudentPayments.SETRANGE(StudentPayments."Student No.", Rec."No.");
                    IF StudentPayments.FIND('-') THEN
                        StudentPayments.DELETEALL;


                    StudentPayments.RESET;
                    StudentPayments.SETRANGE(StudentPayments."Student No.", Rec."No.");
                    IF AccPayment = TRUE THEN BEGIN
                        IF Cust.GET(Rec."No.") THEN
                            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                        Cust.MODIFY;
                    END;
                    PAGE.RUN(68788, StudentPayments);
                    /////////**************************************************************************************************************************

                end;
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
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report 111;
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        Image = "Report";
                        RunObject = Report 119;
                        ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Statistics';
                        Image = "Report";
                        //RunObject = Report 10047;
                        ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action(Statement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement';
                        Image = "Report";
                        RunObject = Codeunit 8810;
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action("Customer - Balance to Date")
                    {
                        Caption = 'Customer - Balance to Date';
                        Image = "Report";
                        RunObject = Report 121;
                        ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                        ApplicationArea = All;
                    }
                    action("Customer - Trial Balance")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Trial Balance';
                        Image = "Report";
                        RunObject = Report 129;
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report 104;
                        ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action("Customer - Summary Aging")
                    {
                        Caption = 'Customer - Summary Aging';
                        Image = "Report";
                        RunObject = Report 109;
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                        ApplicationArea = All;
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        //RunObject = Report 10040;
                        ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action("Customer - Payment Receipt")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Payment Receipt';
                        Image = "Report";
                        RunObject = Report 211;
                        ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                    }
                }
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
        SettlementTypes: Record "ACA-Settlement Type";
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

    procedure RunReport(ReportNumber: Integer; CustomerNumber: Code[20])
    var
        Customer: Record Customer;
    begin
        Customer.SETRANGE("No.", CustomerNumber);
        REPORT.RUNMODAL(ReportNumber, TRUE, TRUE, Customer);
    end;
}

