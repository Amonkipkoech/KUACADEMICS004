/// <summary>
/// Page ACA-Student Billing (ID 68786).
/// </summary>
page 68786 "ACA-Student Billing"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Document;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            Blocked = CONST(" "));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payments By"; Rec."Payments By")
                {
                    ApplicationArea = All;
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("No Of Creidts"; Rec."No Of Creidts")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Caption = 'Posting Group';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
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

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        /*
                        DtldCustLedgEntry.SETRANGE("Customer No.","No.");
                        COPYFILTER("Global Dimension 1 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        COPYFILTER("Global Dimension 2 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        */
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);

                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                }
                field("In Current Sem"; Rec."In Current Sem")
                {
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
                field("Post Code"; Rec."Post Code")
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
            }
            group(Sponsor)
            {
                Caption = 'Sponsor';
                Editable = false;
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Application Method1"; Rec."Application Method")
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
            group(Registration)
            {
                Caption = 'Registration';
                action("Tremester registration")
                {
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
                    RunObject = Page "ACA-Course Reg. Reservour";
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
                    RunObject = Page "ACA-Receipts";
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Registrations)
            {
                Caption = 'Registration';
                action(Prerequisite)
                {
                    Caption = 'Prerequisite';
                    Image = Approval;
                    RunObject = Page "ACA-Prerequisite Approval";
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
                    RunObject = Page 68768;
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
                        RunObject = Page "Issued Reminder";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        Caption = 'Issued &Finance Charge Memos';
                        RunObject = Page "Issued Finance Charge Memo";
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
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(18), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ship-&to Addresses")
                {
                    Caption = 'Ship-&to Addresses';
                    RunObject = Page "Ship-to Address";
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
                separator(stats)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                /* action("Statistics by C&urrencies")
                {
                    Caption = 'Statistics by C&urrencies';
                    Enabled = false;
                    RunObject = Page "Dimension Set ID Filter";
                    RunPageLink = Code = FIELD("No."),
                                  Field56 = FIELD("Global Dimension 1 Filter"),
                                  Field57 = FIELD("Global Dimension 2 Filter"),
                                  Field55 = FIELD("Date Filter");
                } */
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    Visible = false;
                    ApplicationArea = All;
                }

                action("Ser&vice Contracts")
                {
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Service &Items")
                {
                    Caption = 'Service &Items';
                    RunObject = Page "Service Items";
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
                    RunObject = Page 68768;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("Post Transfers")
            {
                Caption = 'Post Transfers';
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", Rec."No.");
                    StudentCharges.SETRANGE(StudentCharges.Transfered, FALSE);
                    StudentCharges.SETRANGE(StudentCharges.Transfer, TRUE);
                    IF StudentCharges.FIND('-') THEN BEGIN
                        StudentCharges.TESTFIELD(StudentCharges."Transfer Amount");
                        StudentCharges.TESTFIELD(StudentCharges."Reg. Transacton ID");
                        IF StudentCharges."Transfer Amount" > StudentCharges."Amount Paid" THEN
                            ERROR('Transfer amount cannot be greater than the amount paid.');

                        GenSetUp.GET();

                        Receipt.INIT;
                        Receipt."Receipt No." := '';
                        Receipt.VALIDATE(Receipt."Receipt No.");
                        Receipt."Student No." := Rec."No.";
                        Receipt.Date := TODAY;
                        Receipt."Payment Mode" := Receipt."Payment Mode"::PDQ;
                        Receipt.Amount := StudentCharges."Transfer Amount";
                        Receipt."Payment By" := '';
                        Receipt.INSERT;

                        Receipt.RESET;
                        Receipt.SETRANGE(Receipt."Student No.", Rec."No.");
                        IF Receipt.FIND('+') THEN BEGIN

                            REPEAT

                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := TODAY;
                                GenJnl."Document No." := Receipt."Receipt No.";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";

                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN
                                        GenJnl."Account No." := Stages."G/L Account";

                                END ELSE
                                    IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                        IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN
                                            GenJnl."Account No." := Units."G/L Account";

                                    END ELSE
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
                                            IF ExamsByStage.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) THEN
                                                GenJnl."Account No." := ExamsByStage."G/L Account";

                                        END ELSE
                                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
                                                IF ExamsByUnit.GET(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                                StudentCharges.Code) THEN
                                                    GenJnl."Account No." := ExamsByUnit."G/L Account";

                                            END ELSE
                                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges THEN BEGIN
                                                    IF Charges.GET(StudentCharges.Code) THEN
                                                        GenJnl."Account No." := Charges."G/L Account";

                                                END;

                                GenJnl.Amount := StudentCharges."Transfer Amount";
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := StudentCharges.Description + '-' + 'Transfer';
                                GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                                GenJnl."Bal. Account No." := GenSetUp."Defered Account";
                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                                IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                        GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                    END;

                                END ELSE
                                    IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                        IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                            GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                        END;
                                    END;

                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");


                                GenJnl.INSERT;



                                /*
                                //Transfer to new course
                                CourseReg.RESET;
                                CourseReg.SETRANGE(CourseReg."Reg. Transacton ID",StudentCharges."Reg. Transaction ID");
                                IF CourseReg.FIND('-') THEN BEGIN
                                */
                                StudentCharges2.RESET;
                                StudentCharges2.SETRANGE(StudentCharges2."Transacton ID", StudentCharges."Reg. Transacton ID");
                                IF StudentCharges2.FIND('-') THEN BEGIN

                                    GenJnl.INIT;
                                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                                    GenJnl."Posting Date" := TODAY;
                                    GenJnl."Document No." := Receipt."Receipt No.";
                                    GenJnl.VALIDATE(GenJnl."Document No.");
                                    GenJnl."Journal Template Name" := 'SALES';
                                    GenJnl."Journal Batch Name" := 'STUD PAY';
                                    GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                    GenJnl."Account No." := GenSetUp."Defered Account";

                                    GenJnl.Amount := StudentCharges."Transfer Amount";
                                    GenJnl.VALIDATE(GenJnl."Account No.");
                                    GenJnl.VALIDATE(GenJnl.Amount);
                                    GenJnl.Description := StudentCharges.Description + '-' + 'Transfer';
                                    GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                                    /*
                                    IF CourseReg."Register for" = CourseReg."Register for"::Stage THEN BEGIN
                                    IF Stages.GET(CourseReg.Programme,CourseReg.Stage) THEN
                                    GenJnl."Bal. Account No.":=Stages."G/L Account";

                                    END ELSE IF CourseReg."Register for" = CourseReg."Register for"::"Unit/Subject" THEN BEGIN
                                    IF Units.GET(CourseReg.Programme,CourseReg.Stage,CourseReg.Unit) THEN
                                    GenJnl."Bal. Account No.":=Units."G/L Account";

                                    END;
                                    */

                                    IF StudentCharges2."Transaction Type" = StudentCharges2."Transaction Type"::"Stage Fees" THEN BEGIN
                                        IF Stages.GET(StudentCharges2.Programme, StudentCharges2.Stage) THEN
                                            GenJnl."Bal. Account No." := Stages."G/L Account";

                                    END ELSE
                                        IF StudentCharges2."Transaction Type" = StudentCharges2."Transaction Type"::"Unit Fees" THEN BEGIN
                                            IF Units.GET(StudentCharges2.Programme, StudentCharges2.Stage, StudentCharges2.Unit) THEN
                                                GenJnl."Bal. Account No." := Units."G/L Account";

                                        END;


                                    GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                    IF StudentCharges2."Transaction Type" = StudentCharges2."Transaction Type"::"Stage Fees" THEN BEGIN
                                        IF Stages.GET(StudentCharges2.Programme, StudentCharges2.Stage) THEN BEGIN
                                            GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                        END;

                                    END ELSE
                                        IF StudentCharges2."Transaction Type" = StudentCharges2."Transaction Type"::"Unit Fees" THEN BEGIN
                                            IF Units.GET(StudentCharges2.Programme, StudentCharges2.Stage, StudentCharges2.Unit) THEN BEGIN
                                                GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                            END;
                                        END;

                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");


                                    GenJnl.INSERT;

                                END;


                                StudentCharges.Transfered := TRUE;
                                StudentCharges.MODIFY;

                                StudentCharges2.RESET;
                                StudentCharges2.SETRANGE(StudentCharges2."Transacton ID", StudentCharges."Reg. Transacton ID");
                                IF StudentCharges2.FIND('-') THEN BEGIN
                                    StudentCharges2."Amount Paid" := StudentCharges2."Amount Paid" + StudentCharges."Transfer Amount";
                                    StudentCharges2.MODIFY;
                                END;

                            UNTIL StudentCharges.NEXT = 0;

                        END;

                        //Post
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);
                        END;


                    END;

                end;
            }
            action("Make Payment")
            {
                Caption = 'Make Payment';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SettlementTypes: Record "ACA-Settlement Type";
                begin
                    //BILLING
                    AccPayment := FALSE;
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", Rec."No.");
                    StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
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




                        // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS BY BKK...//
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
                    StudentCharges.SETRANGE(StudentCharges.Posted, FALSE);
                    IF StudentCharges.FIND('-') THEN BEGIN

                        REPEAT

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
            action("Aged Accounts Receivable")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Aged Accounts Receivable';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                ToolTip = 'View, print, or save an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';

                trigger OnAction()
                begin
                    //   RunReport(REPORT::"Aged Accounts Receivable2", Rec."No.");
                end;
            }

            action("Report Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Statement';
                Image = "Report";
                RunObject = Codeunit 8810;
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
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

    // SettlementType: Record "ACA-Settlement Type";

    procedure RunReport(ReportNumber: Integer; CustomerNumber: Code[20])
    var
        Customer: Record Customer;
    begin
        Customer.SETRANGE("No.", CustomerNumber);
        REPORT.RUNMODAL(ReportNumber, TRUE, TRUE, Customer);
    end;
}

