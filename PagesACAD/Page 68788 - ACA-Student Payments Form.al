page 68788 "ACA-Student Payments Form"
{
    PageType = Card;
    SourceTable = "ACA-Std Payments";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Transaction Date" := TODAY;
                        ApplicationEnable := TRUE;

                        IF Rec."Payment Mode" <> Rec."Payment Mode"::Cash THEN
                            "Amount to payEnable" := FALSE;

                        IF ((Rec."Payment Mode" = Rec."Payment Mode"::"Banker's Cheque") OR (Rec."Payment Mode" = Rec."Payment Mode"::"Bank Slip") OR
                        (Rec."Payment Mode" = Rec."Payment Mode"::Cheque) OR (Rec."Payment Mode" = Rec."Payment Mode"::"Money Order") OR
                        (Rec."Payment Mode" = Rec."Payment Mode"::Cash)) OR (Rec."Payment Mode" = Rec."Payment Mode"::"Direct Bank Deposit") THEN BEGIN
                            "Cheque NoEnable" := TRUE;
                            "Drawer NameEnable" := TRUE;
                            //CurrForm."Drawer's Bank".ENABLED:=TRUE;
                            //CurrForm."Drawer's Branch Code".ENABLED:=TRUE;
                            "Bank No.Enable" := TRUE;
                            "Amount to payEnable" := TRUE;
                            "Bank Slip DateEnable" := TRUE;
                            "Unref. Entry No.Enable" := FALSE;

                            IF BankRec.GET(Rec."Bank No.") THEN
                                Rec."Drawer Name" := BankRec.Contact;

                        END ELSE BEGIN

                            "Cheque NoEnable" := FALSE;
                            "Drawer NameEnable" := FALSE;
                            //CurrForm."Drawer's Bank".ENABLED:=FALSE;
                            //CurrForm."Drawer's Branch Code".ENABLED:=FALSE;
                            //CurrForm."Bank No.".ENABLED:=FALSE;
                            "Amount to payEnable" := FALSE;
                            "Bank Slip DateEnable" := FALSE;
                            "Unref. Entry No.Enable" := FALSE;
                            "Staff Invoice No.Enable" := FALSE;
                            "Staff DescriptionEnable" := FALSE;


                        END;
                        if Rec."Payment Mode" = Rec."Payment Mode"::"M-Pesa" then begin
                            "Bank No.Enable" := FALSE;
                            "Unref. Entry No.Enable" := TRUE;
                            Rec."Bank No." := '';
                            ApplicationEnable := FALSE;
                        end;



                        IF Rec."Payment Mode" = Rec."Payment Mode"::Unreferenced THEN BEGIN
                            "Bank No.Enable" := FALSE;
                            "Unref. Entry No.Enable" := TRUE;
                            Rec."Bank No." := '';
                            ApplicationEnable := FALSE;

                        END;


                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Staff Invoice" THEN
                            "Amount to payEnable" := TRUE;

                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Money Order" THEN
                            Rec."Bank No." := 'BFS';



                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Applies to Overpayment" THEN BEGIN
                            "Applies to Doc NoEnable" := FALSE;
                            "Apply to OverpaymentEnable" := TRUE;
                        END ELSE
                            "Apply to OverpaymentEnable" := FALSE;

                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Staff Invoice" THEN BEGIN
                            "Staff Invoice No.Enable" := TRUE;
                            "Staff DescriptionEnable" := TRUE;
                            "Bank No.Enable" := FALSE;
                            "Bank No.Enable" := FALSE;
                            "Amount to payEnable" := FALSE;
                        END ELSE BEGIN
                            "Bank No.Enable" := TRUE;
                            "Bank No.Enable" := TRUE;
                            "Amount to payEnable" := TRUE;

                        END;

                        IF Rec."Payment Mode" = Rec."Payment Mode"::Weiver THEN BEGIN
                            "Bank No.Enable" := FALSE;
                            "Bank No.Enable" := FALSE;
                            "Amount to payEnable" := TRUE;
                            "Payment ByEnable" := TRUE;
                        END;
                        IF ((Rec."Payment Mode" = Rec."Payment Mode"::CDF) OR (Rec."Payment Mode" = Rec."Payment Mode"::HELB)) THEN BEGIN
                            "Bank No.Enable" := FALSE;
                            "Bank No.Enable" := FALSE;
                            "Amount to payEnable" := TRUE;
                            "Payment ByEnable" := TRUE;
                            "CDF AccountEnable" := TRUE;
                            "CDF DescriptionEnable" := TRUE;
                        END;
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Bank Slip/Cheque No.';
                    Enabled = "Cheque NoEnable";
                    ApplicationArea = All;
                }
                field("Amount to pay"; Rec."Amount to pay")
                {
                    ApplicationArea = All;
                }
                field("Bank Slip Date"; Rec."Bank Slip Date")
                {
                    Enabled = "Bank Slip DateEnable";
                    ApplicationArea = All;
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ApplicationArea = All;
                }
                field("Payment By"; Rec."Payment By")
                {
                    Enabled = "Payment ByEnable";
                    ApplicationArea = All;
                }
                field("Drawer Name"; Rec."Drawer Name")
                {
                    Enabled = "Drawer NameEnable";
                    ApplicationArea = All;
                }
                field("CDF Account"; Rec."CDF Account")
                {
                    Enabled = "CDF AccountEnable";
                    ApplicationArea = All;
                }
                field("CDF Description"; Rec."CDF Description")
                {
                    Enabled = "CDF DescriptionEnable";
                    ApplicationArea = All;
                }
                field("Staff Invoice No."; Rec."Staff Invoice No.")
                {
                    Editable = true;
                    Enabled = "Staff Invoice No.Enable";
                    ApplicationArea = All;
                }
                field("Staff Description"; Rec."Staff Description")
                {
                    Editable = true;
                    Enabled = "Staff DescriptionEnable";
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Over Paid Amount"; Rec."Over Paid Amount")
                {
                    Caption = 'Pre-paid Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TempBalance; Rec.TempBalance)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applies to Doc No"; Rec."Applies to Doc No")
                {
                    Enabled = "Applies to Doc NoEnable";
                    ApplicationArea = All;
                }
                field("Apply to Overpayment"; Rec."Apply to Overpayment")
                {
                    Enabled = "Apply to OverpaymentEnable";
                    ApplicationArea = All;
                }
                //  field("Unref. Entry No."; Rec."Unref. Entry No.")
                // {
                //    Enabled = "Unref. Entry No.Enable";
                //    ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action(PostTrans)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F2';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.VALIDATE("Cheque No");
                    IF Rec.Posted THEN ERROR('Already Posted');
                    Rec.TESTFIELD("Transaction Date");

                    IF CONFIRM('Do you want to post the transaction?', TRUE) = FALSE THEN BEGIN
                        EXIT;
                    END;

                    IF ((Rec."Payment Mode" = Rec."Payment Mode"::"Bank Slip") OR (Rec."Payment Mode" = Rec."Payment Mode"::Cheque)) THEN BEGIN
                        Rec.TESTFIELD("Bank Slip Date");
                        Rec.TESTFIELD("Bank No.");
                    END;
                    CustLedg.RESET;
                    CustLedg.SETRANGE(CustLedg."Customer No.", Rec."Student No.");
                    //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                    CustLedg.SETRANGE(CustLedg.Open, TRUE);
                    CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                    IF CustLedg.FIND('-') THEN BEGIN
                        REPEAT
                            TotalApplied := TotalApplied + CustLedg."Amount Applied";
                        UNTIL CustLedg.NEXT = 0;
                    END;

                    IF Rec."Amount to pay" > TotalApplied THEN BEGIN
                        IF CONFIRM('There is an overpayment. Do you want to continue?', FALSE) = FALSE THEN BEGIN
                            EXIT;
                        END;

                    END;


                    IF Cust.GET(Rec."Student No.") THEN BEGIN
                        Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                        Cust.Status := Cust.Status::Current;
                        Cust.MODIFY;
                    END;

                    IF Cust.GET(Rec."Student No.") THEN
                        GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    GenSetUp.GET();


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");



                    //Charge Student if not charged
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Student No.", Rec."Student No.");
                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
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
                            GenJnl."Document No." := Rec."Cheque No";//StudentCharges."Transacton ID";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            //
                            IF Cust.GET(Rec."Student No.") THEN BEGIN
                                IF Cust."Bill-to Customer No." <> '' THEN
                                    GenJnl."Account No." := Cust."Bill-to Customer No."
                                ELSE
                                    GenJnl."Account No." := Rec."Student No.";
                            END;

                            GenJnl.Amount := StudentCharges.Amount;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := StudentCharges.Description;
                            GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                            IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
                               (StudentCharges.Charge = FALSE) THEN BEGIN
                                GenJnl."Bal. Account No." := GenSetUp."Pre-Payment Account";

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
                                    GenJnl."Bal. Account No." := GenSetUp."Pre-Payment Account";

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

                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    IF cust2.GET() THEN
                                        IF cust2."Global Dimension 2 Code" <> '' THEN
                                            GenJnl."Shortcut Dimension 2 Code" := cust2."Global Dimension 2 Code"
                                        ELSE
                                            ERROR('Department missing!')
                                    //else
                                    //GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
                                END;
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
                                        IF Cust.GET(Rec."Student No.") THEN BEGIN
                                            CustPostGroup.GET(Cust."Customer Posting Group");

                                            GenJnl.INIT;
                                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                                            GenJnl."Posting Date" := TODAY;
                                            GenJnl."Document No." := Rec."Cheque No";//StudentCharges."Transacton ID";
                                                                                     //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                            GenJnl.VALIDATE(GenJnl."Document No.");
                                            GenJnl."Journal Template Name" := 'SALES';
                                            GenJnl."Journal Batch Name" := 'STUD PAY';
                                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                            GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                            GenJnl."Account No." := GenSetUp."Pre-Payment Account";
                                            GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                            GenJnl.VALIDATE(GenJnl."Account No.");
                                            GenJnl.VALIDATE(GenJnl.Amount);
                                            GenJnl.Description := 'Fee Distribution';
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenJnl."Bal. Account No." := Stages."Distribution Account";
                                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                                            CReg.RESET;
                                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                                            CReg.SETRANGE(CReg.Reversed, FALSE);
                                            IF CReg.FIND('+') THEN BEGIN
                                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                                END;
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
                                        GenJnl."Document No." := Rec."Cheque No";//StudentCharges."Transacton ID";
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

                                        //Stages.TESTFIELD(Stages.Department);
                                        CReg.RESET;
                                        CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                                        CReg.SETRANGE(CReg.Reversed, FALSE);
                                        IF CReg.FIND('+') THEN BEGIN
                                            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                                ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                                //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                                GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                            END;
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

                        UNTIL StudentCharges.NEXT = 0;



                        //Post New
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2", GenJnl);
                        END;

                        //Post New



                    END;


                    //BILLING

                    "Last No" := '';
                    "No. Series Line".RESET;
                    BankRec.GET(Rec."Bank No.");
                    BankRec.TESTFIELD(BankRec."Receipt No. Series");
                    "No. Series Line".SETRANGE("No. Series Line"."Series Code", BankRec."Receipt No. Series");
                    IF "No. Series Line".FIND('-') THEN BEGIN

                        "Last No" := INCSTR("No. Series Line"."Last No. Used");
                        "No. Series Line"."Last No. Used" := INCSTR("No. Series Line"."Last No. Used");
                        "No. Series Line".MODIFY;
                    END;


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    Cust.Status := Cust.Status::Current;
                    //Cust.MODIFY;


                    IF Rec."Payment Mode" = Rec."Payment Mode"::"Applies to Overpayment" THEN
                        ERROR('Overpayment must be applied manualy.');


                    /////////////////////////////////////////////////////////////////////////////////
                    //Receive payments
                    IF Rec."Payment Mode" <> Rec."Payment Mode"::"Applies to Overpayment" THEN BEGIN

                        //Over Payment
                        TotalApplied := 0;

                        CustLedg.RESET;
                        CustLedg.SETRANGE(CustLedg."Customer No.", Rec."Student No.");
                        //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                        CustLedg.SETRANGE(CustLedg.Open, TRUE);
                        CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                        IF CustLedg.FIND('-') THEN BEGIN
                            REPEAT
                                TotalApplied := TotalApplied + CustLedg."Amount Applied";
                            UNTIL CustLedg.NEXT = 0;
                        END;

                        CReg.RESET;
                        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
                        //CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
                        CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                        IF CReg.FIND('+') THEN
                            CourseReg := CReg."Reg. Transacton ID";





                        Receipt.INIT;
                        Receipt."Receipt No." := "Last No";
                        //Receipt.VALIDATE(Receipt."Receipt No.");
                        Receipt."Student No." := Rec."Student No.";
                        Receipt.Date := Rec."Transaction Date";
                        Receipt."KCA Rcpt No" := Rec."KCA Receipt No";
                        Receipt."Bank Slip Date" := Rec."Bank Slip Date";
                        Receipt."Bank Slip/Cheque No" := Rec."Cheque No";
                        Receipt.VALIDATE("Bank Slip/Cheque No");
                        Receipt."Bank Account" := Rec."Bank No.";
                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Bank Slip" THEN
                            Receipt."Payment Mode" := Receipt."Payment Mode"::"Bank Slip" ELSE
                            IF Rec."Payment Mode" = Rec."Payment Mode"::Cheque THEN
                                Receipt."Payment Mode" := Receipt."Payment Mode"::Cheque ELSE
                                IF Rec."Payment Mode" = Rec."Payment Mode"::Cash THEN
                                    Receipt."Payment Mode" := Receipt."Payment Mode"::Cash ELSE
                                    Receipt."Payment Mode" := Rec."Payment Mode";
                        Receipt.Amount := Rec."Amount to pay";
                        Receipt."Payment By" := Rec."Payment By";
                        Receipt."Transaction Date" := TODAY;
                        Receipt."Transaction Time" := TIME;
                        Receipt."User ID" := USERID;
                        Receipt."Reg ID" := CourseReg;
                        Receipt.INSERT;

                        Receipt.RESET;
                        IF Receipt.FIND('+') THEN BEGIN


                            CustLedg.RESET;
                            CustLedg.SETRANGE(CustLedg."Customer No.", Rec."Student No.");
                            //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                            CustLedg.SETRANGE(CustLedg.Open, TRUE);
                            CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                            IF CustLedg.FIND('-') THEN BEGIN

                                GenSetUp.GET();


                            END;

                        END;

                        //Bank Entry
                        IF BankRec.GET(Rec."Bank No.") THEN
                            BankName := BankRec.Name;

                        IF (Rec."Payment Mode" <> Rec."Payment Mode"::Unreferenced) AND (Rec."Payment Mode" <> Rec."Payment Mode"::"Staff Invoice")
                        AND (Rec."Payment Mode" <> Rec."Payment Mode"::Weiver) AND (Rec."Payment Mode" <> Rec."Payment Mode"::CDF)
                        AND (Rec."Payment Mode" <> Rec."Payment Mode"::HELB) THEN BEGIN

                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := Rec."Cheque No";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"Bank Account";
                            GenJnl."Account No." := Rec."Bank No.";
                            GenJnl.Amount := Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := FORMAT(Rec."Payment Mode") + '-' + FORMAT(Rec."Bank Slip Date") + '-' + BankName;
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::Customer;
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Bal. Account No." := Rec."Student No.";


                            GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                            GenJnl.INSERT;
                        END;
                        IF Rec."Payment Mode" = Rec."Payment Mode"::Unreferenced THEN BEGIN
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := Rec."Drawer Name";
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := 'UNREF';
                            GenJnl.Amount := Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := Cust.Name;
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::Customer;
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Bal. Account No." := Rec."Student No.";

                            // GenJnl."Applies-to Doc. No." := Rec."Unref Document No.";
                            GenJnl.VALIDATE(GenJnl."Applies-to Doc. No.");
                            GenJnl.INSERT;

                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");


                        END;
                        // BKK...Staff Invoice
                        IF Rec."Payment Mode" = Rec."Payment Mode"::"Staff Invoice" THEN BEGIN
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := '';
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."Student No.";
                            GenJnl.Amount := -Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'Staff Invoice No. ' + Rec."Staff Invoice No.";
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                            GenJnl."Bal. Account No." := '200012';

                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                            GenJnl.INSERT;


                        END;
                        // BKK...CDF
                        IF Rec."Payment Mode" = Rec."Payment Mode"::CDF THEN BEGIN
                            GenSetUp.TESTFIELD(GenSetUp."CDF Account");
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := 'CDF';
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."Student No.";
                            GenJnl.Amount := -Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := Rec."CDF Description";
                            //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                            //GenJnl."Bal. Account No.":=;
                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl.INSERT;

                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := 'CDF';
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                            GenJnl."Account No." := GenSetUp."CDF Account";
                            GenJnl.Amount := Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := Rec."Student No.";

                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                    //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                            GenJnl.INSERT;


                        END;

                        // Post Weiver Fees 400455 ...BKK
                        IF Rec."Payment Mode" = Rec."Payment Mode"::HELB THEN BEGIN
                            GenSetUp.TESTFIELD(GenSetUp."Helb Account");
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := Rec."Bank Slip Date";
                            GenJnl."Document No." := "Last No";
                            GenJnl."External Document No." := '';
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := Rec."Student No.";
                            GenJnl.Amount := -Rec."Amount to pay";
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'HELB';
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                            GenJnl."Bal. Account No." := GenSetUp."Helb Account";
                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", Rec."Student No.");
                            CReg.SETRANGE(CReg.Reversed, FALSE);
                            IF CReg.FIND('+') THEN BEGIN
                                IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                    GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                END;
                            END;

                            GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            GenJnl.INSERT;


                        END;

                        //Post

                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN

                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2", GenJnl);
                            Rec.MODIFY;
                        END;

                        // Hostel Allocations
                        StudHostel.RESET;
                        StudHostel.SETRANGE(StudHostel.Student, Rec."Student No.");
                        StudHostel.SETRANGE(StudHostel.Billed, FALSE);
                        IF StudHostel.FIND('-') THEN BEGIN
                            StudHostel.Billed := TRUE;
                            StudHostel.MODIFY;
                            Receipts.RESET;
                            IF Receipts.GET("Last No") THEN BEGIN
                                Receipts."Room No" := StudHostel."Space No";
                                Receipts.MODIFY;
                            END;

                            HostLedg.RESET;
                            HostLedg.SETRANGE(HostLedg."Space No", StudHostel."Space No");
                            HostLedg.SETRANGE(HostLedg."Hostel No", StudHostel."Hostel No");
                            IF HostLedg.FIND('-') THEN BEGIN
                                HostLedg.Status := HostLedg.Status::"Partially Occupied";
                                HostLedg.MODIFY;
                            END;
                        END;


                        CurrPage.CLOSE;
                        Receipts.RESET;
                        Receipts.SETCURRENTKEY(Receipts."Receipt No.");
                        Receipts.SETRANGE(Receipts."Receipt No.", "Last No");
                        //IF Receipts.FIND('-') THEN
                        //REPORT.RUN(51524,FALSE,FALSE,Receipts);


                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //"Bank No.":='';

        IF Rec."Payment Mode" <> Rec."Payment Mode"::Cash THEN
            "Amount to payEnable" := FALSE;

        IF ((Rec."Payment Mode" = Rec."Payment Mode"::"Banker's Cheque") OR (Rec."Payment Mode" = Rec."Payment Mode"::"Bank Slip") OR
        (Rec."Payment Mode" = Rec."Payment Mode"::Cheque)) THEN BEGIN
            "Cheque NoEnable" := TRUE;
            "Drawer NameEnable" := TRUE;
            //CurrForm."Drawer's Bank".ENABLED:=TRUE;
            //CurrForm."Drawer's Branch Code".ENABLED:=TRUE;
            "Bank No.Enable" := TRUE;
            "Amount to payEnable" := TRUE;
            "Bank Slip DateEnable" := TRUE;

        END ELSE BEGIN

            "Cheque NoEnable" := FALSE;
            "Drawer NameEnable" := FALSE;
            //CurrForm."Drawer's Bank".ENABLED:=FALSE;
            //CurrForm."Drawer's Branch Code".ENABLED:=FALSE;
            //CurrForm."Bank No.".ENABLED:=FALSE;
            "Amount to payEnable" := FALSE;

        END;


        IF Rec."Payment Mode" = Rec."Payment Mode"::Cash THEN
            "Amount to payEnable" := TRUE;

        IF Rec."Payment Mode" = Rec."Payment Mode"::"Applies to Overpayment" THEN BEGIN
            "Applies to Doc NoEnable" := FALSE;
            "Apply to OverpaymentEnable" := TRUE;
        END ELSE
            "Apply to OverpaymentEnable" := FALSE;

        //"Payment Mode":="Payment Mode"::"Bank Slip";
        //VALIDATE("Payment Mode");
        //"Bank No.":='CONS SAVNG';
        Rec."Transaction Date" := TODAY;

        "Cheque NoEnable" := TRUE;
        "Drawer NameEnable" := TRUE;
        "Bank No.Enable" := TRUE;
        "Amount to payEnable" := TRUE;
        "Bank Slip DateEnable" := TRUE;

        IF Rec."Payment Mode" = Rec."Payment Mode"::Weiver THEN BEGIN
            "Bank No.Enable" := FALSE;
            "Amount to payEnable" := TRUE;
            "Bank Slip DateEnable" := TRUE;

        END;

        IF Rec."Payment Mode" = Rec."Payment Mode"::CDF THEN BEGIN
            "Bank No.Enable" := FALSE;
            "Amount to payEnable" := TRUE;
            "Bank Slip DateEnable" := TRUE;
            "CDF AccountEnable" := TRUE;
            "CDF DescriptionEnable" := TRUE;
        END;
    end;

    trigger OnInit()
    begin
        "Payment ByEnable" := TRUE;
        "Staff DescriptionEnable" := TRUE;
        "Staff Invoice No.Enable" := TRUE;
        "Unref. Entry No.Enable" := TRUE;
        ApplicationEnable := TRUE;
        "CDF DescriptionEnable" := TRUE;
        "CDF AccountEnable" := TRUE;
        "Apply to OverpaymentEnable" := TRUE;
        "Applies to Doc NoEnable" := TRUE;
        "Bank Slip DateEnable" := TRUE;
        "Bank No.Enable" := TRUE;
        "Drawer NameEnable" := TRUE;
        "Cheque NoEnable" := TRUE;
        "Amount to payEnable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        "Cheque NoEnable" := FALSE;
        "Drawer NameEnable" := FALSE;
        //CurrForm."Drawer's Bank".ENABLED:=FALSE;
        //CurrForm."Drawer's Branch Code".ENABLED:=FALSE;
        "Amount to payEnable" := FALSE;
        "Applies to Doc NoEnable" := FALSE;
        "Apply to OverpaymentEnable" := FALSE;
        "Bank Slip DateEnable" := FALSE;
        "Bank No.Enable" := FALSE;
        "Unref. Entry No.Enable" := FALSE;
        "Staff Invoice No.Enable" := FALSE;
        "Staff DescriptionEnable" := FALSE;
        "CDF AccountEnable" := FALSE;
        "CDF DescriptionEnable" := FALSE;
    end;

    var
        cust2: Record Customer;
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";

        Charges: Record "ACA-Charge";

        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        "GenSetUp.": Record "ACA-General Set-Up";
        TotalApplied: Decimal;
        Sems: Record "ACA-Semesters";
        DueDate: Date;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CReg: Record "ACA-Course Registration";
        CustLedg: Record "Cust. Ledger Entry";
        StudentPay: Record "ACA-Std Payments";
        ProgrammeSetUp: Record "ACA-Programme";
        CourseReg: Code[20];
        LastReceiptNo: Code[20];
        GenSetUp: Record "ACA-General Set-Up";
        "No. Series Line": Record "No. Series Line";
        "Last No": Code[20];
        Prog: Record "ACA-Programme";
        BankRec: Record "Bank Account";
        [InDataSet]
        "Amount to payEnable": Boolean;
        [InDataSet]
        "Cheque NoEnable": Boolean;
        [InDataSet]
        "Drawer NameEnable": Boolean;
        [InDataSet]
        "Bank No.Enable": Boolean;
        [InDataSet]
        "Bank Slip DateEnable": Boolean;
        [InDataSet]
        "Applies to Doc NoEnable": Boolean;
        [InDataSet]
        "Apply to OverpaymentEnable": Boolean;
        [InDataSet]
        "CDF AccountEnable": Boolean;
        [InDataSet]
        "CDF DescriptionEnable": Boolean;
        [InDataSet]
        ApplicationEnable: Boolean;
        [InDataSet]
        "Unref. Entry No.Enable": Boolean;
        [InDataSet]
        "Staff Invoice No.Enable": Boolean;
        [InDataSet]
        "Staff DescriptionEnable": Boolean;
        [InDataSet]
        "Payment ByEnable": Boolean;
        StudHostel: Record "ACA-Students Hostel Rooms";
        HostLedg: Record "ACA-Hostel Ledger";
        BankName: Text[100];
}

