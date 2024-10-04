table 61767 "CAT-Student Cafe Payments"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Editable = false;
            TableRelation = Vendor."No." WHERE("Vendor Posting Group" = FILTER('CAFE MEALS'));
        }
        field(2; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(3; "Cheque No"; Code[20])
        {
        }
        field(4; "Drawer's Name"; Text[50])
        {
        }
        field(5; "Drawer's Bank"; Option)
        {
            OptionMembers = " ",BBK,KCB,CBA,Standard,Stanbic;
        }
        field(6; "Drawer's Branch Code"; Code[20])
        {
        }
        field(7; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Student No.")));
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
        }
        field(8; "Amount to pay"; Decimal)
        {

            trigger OnValidate()
            begin
                TempBalance := "Amount to pay";
                "Unapplied Amount" := "Amount to pay";
                AmountToApply := "Amount to pay";

                CustLedgEn.RESET;
                // CustLedgEn.SETCURRENTKEY(CustLedgEn."Customer No.",CustLedgEn."Posting Date",CustLedgEn.Open,CustLedgEn."Recovery Priority");
                CustLedgEn.SETRANGE(CustLedgEn."Customer No.", "Student No.");
                CustLedgEn.SETRANGE(CustLedgEn.Open, TRUE);
                IF CustLedgEn.FIND('-') THEN BEGIN
                    REPEAT
                        CustLedgEn.CALCFIELDS(CustLedgEn."Remaining Amt. (LCY)", CustLedgEn."Remaining Amount");
                        IF Currency = '' THEN BEGIN
                            IF CustLedgEn."Remaining Amt. (LCY)" > 0 THEN BEGIN
                                IF AmountToApply > CustLedgEn."Remaining Amt. (LCY)" THEN BEGIN
                                    //CustLedgEn."Amount Applied":=CustLedgEn."Remaining Amt. (LCY)";
                                    // AmountToApply:=AmountToApply-CustLedgEn."Amount Applied";
                                    //CustLedgEn."Apply to":=TRUE;
                                END ELSE BEGIN
                                    IF AmountToApply > 0 THEN BEGIN
                                        //CustLedgEn."Amount Applied":=AmountToApply;
                                        //CustLedgEn."Apply to":=TRUE;
                                        AmountToApply := 0;
                                    END ELSE BEGIN
                                        //CustLedgEn."Amount Applied":=0;
                                        //CustLedgEn."Apply to":=FALSE;
                                    END;
                                END;
                                CustLedgEn.MODIFY;
                            END;

                        END ELSE BEGIN
                            IF CustLedgEn."Remaining Amount" > 0 THEN BEGIN
                                IF AmountToApply > CustLedgEn."Remaining Amount" THEN BEGIN
                                    //CustLedgEn."Amount Applied":=CustLedgEn."Remaining Amount";
                                    //AmountToApply:=AmountToApply-CustLedgEn."Amount Applied";
                                    //CustLedgEn."Apply to":=TRUE;
                                END ELSE BEGIN
                                    IF AmountToApply > 0 THEN BEGIN
                                        //CustLedgEn."Amount Applied":=AmountToApply;
                                        //CustLedgEn."Apply to":=TRUE;
                                        AmountToApply := 0;
                                    END ELSE BEGIN
                                        //CustLedgEn."Amount Applied":=0;
                                        //CustLedgEn."Apply to":=FALSE;
                                    END;
                                END;
                                CustLedgEn.MODIFY;
                            END;


                        END;

                    UNTIL CustLedgEn.NEXT = 0;

                END;
            end;
        }
        field(9; TempBalance; Decimal)
        {
        }
        field(10; "Payment Mode"; Option)
        {
            OptionCaption = ' ,Bank Slip,Cheque,Banker''s Cheque,Cash,Applies to Overpayment,PDQ,Unreferenced,Money Order,Direct Bank Deposit,Staff Invoice,Weiver';
            OptionMembers = " ","Bank Slip",Cheque,"Banker's Cheque",Cash,"Applies to Overpayment",PDQ,Unreferenced,"Money Order","Direct Bank Deposit","Staff Invoice",Weiver;
        }
        field(11; Programme; Code[20])
        {
        }
        field(12; "Applies to Doc No"; Code[20])
        {
        }
        field(13; "Apply to Overpayment"; Integer)
        {

            trigger OnLookup()
            begin
                CustLedger.SETRANGE("Customer No.", "Student No.");
                CustLedger.SETRANGE(Open, TRUE);
                //CustLedger.SETRANGE(CustLedger."Document Type",CustLedger."Document Type"::Payment);
                IF PAGE.RUNMODAL(25, CustLedger) = ACTION::LookupOK THEN BEGIN
                    CustLedger.CALCFIELDS("Remaining Amt. (LCY)");
                    "Over Paid Amount" := ABS(CustLedger."Remaining Amt. (LCY)");
                    "Applies to Doc No" := CustLedger."Document No.";
                    "Apply to Overpayment" := CustLedger."Entry No.";
                    "Amount to pay" := "Over Paid Amount";
                    VALIDATE("Amount to pay");
                    MODIFY;
                END;
            end;

            trigger OnValidate()
            begin
                IF "Apply to Overpayment" = 0 THEN BEGIN
                    "Over Paid Amount" := 0;
                    "Applies to Doc No" := '';
                END;
            end;
        }
        field(14; "Over Paid Amount"; Decimal)
        {
        }
        field(15; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(16; "Payment By"; Text[150])
        {
        }
        field(17; "Unapplied Amount"; Decimal)
        {
        }
        field(18; "Bank Slip Date"; Date)
        {
        }
        field(19; "Transaction Date"; Date)
        {
        }
        field(20; "KCA Receipt No"; Code[40])
        {
        }
        field(21; "Auto Post"; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Transaction Date");
                //IF COMPANYNAME = 'Kenya College of Accountancy 2' THEN
                //TESTFIELD("KCA Receipt No");


                //IF CONFIRM('Do you want to post the transaction?',TRUE) = FALSE THEN BEGIN
                //EXIT;
                //END;

                IF "Payment Mode" = "Payment Mode"::"Bank Slip" THEN
                    TESTFIELD("Bank Slip Date");

                CustLedg.RESET;
                CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                CustLedg.SETRANGE(CustLedg.Open, TRUE);
                CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                IF CustLedg.FIND('-') THEN BEGIN
                    REPEAT
                    //TotalApplied:=TotalApplied+CustLedg."Amount Applied";
                    UNTIL CustLedg.NEXT = 0;
                END;

                //("Amount to pay" - TotalApplied)
                //ERROR('%1',TotalApplied);
                IF "Amount to pay" <> TotalApplied THEN BEGIN

                END;


                IF Cust.GET("Student No.") THEN BEGIN
                    //Cust.Status:=Cust.Status::Current;
                    //Cust.MODIFY;
                END;


                GenJnl.RESET;
                GenJnl.SETRANGE("Journal Template Name", 'SALES');
                GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                GenJnl.DELETEALL;

                GenSetUp.GET();

                //Charge Student if not charged
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
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
                        GenJnl."Posting Date" := "Transaction Date";
                        GenJnl."Document No." := StudentCharges."Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        //
                        IF Cust.GET("Student No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "Student No.";
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
                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                Stages.TESTFIELD(Stages.Department);
                                GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                            END;

                        END ELSE
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                    Units.TESTFIELD(Units.Department);
                                    GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                END;
                            END;

                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Due Date" := DueDate;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF "Payment Mode" = "Payment Mode"::"Applies to Overpayment" THEN BEGIN
                            IF StudentCharges."Apply to" = TRUE THEN BEGIN
                                //GenJnl."Applies-to Doc. Type":=GenJnl."Applies-to Doc. Type"::Payment;
                                GenJnl."Applies-to Doc. No." := "Applies to Doc No";
                                GenJnl.VALIDATE(GenJnl."Applies-to Doc. No.")
                            END;
                        END;
                        GenJnl.INSERT;

                        //Distribute Money
                        IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                    Stages.TESTFIELD(Stages."Distribution Account");
                                    StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                    IF Cust.GET("Student No.") THEN BEGIN
                                        CustPostGroup.GET(Cust."Customer Posting Group");

                                        GenJnl.INIT;
                                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                                        GenJnl."Posting Date" := "Transaction Date";
                                        GenJnl."Document No." := StudentCharges."Transacton ID";
                                        //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                        GenJnl.VALIDATE(GenJnl."Document No.");
                                        GenJnl."Journal Template Name" := 'SALES';
                                        GenJnl."Journal Batch Name" := 'STUD PAY';
                                        GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                        GenJnl."Account No." := GenSetUp."Pre-Payment Account";
                                        GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                        GenJnl.VALIDATE(GenJnl."Account No.");
                                        GenJnl.VALIDATE(GenJnl.Amount);
                                        GenJnl.Description := 'Fee Distribution';
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        GenJnl."Bal. Account No." := Stages."Distribution Account";
                                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                                Stages.TESTFIELD(Stages.Department);
                                                GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                            END;

                                        END ELSE
                                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                                IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                                    Units.TESTFIELD(Units.Department);
                                                    GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                                END;
                                            END;
                                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");

                                        GenJnl.INSERT;

                                    END;
                                END;
                            END;
                        END;
                        //End Distribution


                        StudentCharges.Recognized := TRUE;
                        IF "Payment Mode" = "Payment Mode"::"Applies to Overpayment" THEN BEGIN
                            IF StudentCharges."Apply to" = TRUE THEN BEGIN
                                StudentCharges."Apply to" := FALSE;
                                StudentCharges."Amount Paid" := StudentCharges."Amount Paid" + StudentCharges."Applied Amount";
                                StudentCharges."Applied Amount" := 0;
                                IF StudentCharges."Amount Paid" >= StudentCharges.Amount THEN
                                    StudentCharges."Fully Paid" := TRUE;
                            END;
                        END;
                        StudentCharges.MODIFY;

                    UNTIL StudentCharges.NEXT = 0;



                    /*
                    //Post
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnl);
                    MODIFY;
                    END;
                    */


                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        REPEAT
                            //window.OPEN('Posting:,#1######################');
                            //window.UPDATE(1,GenJnl."Line No.");
                            GLPosting.RUN(GenJnl);
                        UNTIL GenJnl.NEXT = 0;
                        //window.CLOSE;
                    END;




                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    Cust.Status := Cust.Status::Current;
                    Cust.MODIFY;

                END ELSE BEGIN
                    IF "Payment Mode" = "Payment Mode"::"Applies to Overpayment" THEN
                        ERROR('Overpayment must be applied manualy.');
                END;

                /////////////////////////////////////////////////////////////////////////////////
                //Receive payments
                IF "Payment Mode" <> "Payment Mode"::"Applies to Overpayment" THEN BEGIN

                    //Over Payment
                    TotalApplied := 0;

                    CustLedg.RESET;
                    CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                    //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                    CustLedg.SETRANGE(CustLedg.Open, TRUE);
                    CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                    IF CustLedg.FIND('-') THEN BEGIN
                        REPEAT
                        //TotalApplied:=TotalApplied+CustLedg."Amount Applied";
                        UNTIL CustLedg.NEXT = 0;
                    END;


                    Receipt.INIT;
                    Receipt."Receipt No." := '';
                    Receipt.VALIDATE(Receipt."Receipt No.");
                    Receipt."Student No." := "Student No.";
                    Receipt.Date := "Transaction Date";
                    Receipt."KCA Rcpt No" := "KCA Receipt No";
                    Receipt."Payment Mode" := "Payment Mode";
                    Receipt.Amount := "Amount to pay";
                    Receipt."Payment By" := "Payment By";
                    Receipt."Transaction Date" := TODAY;
                    Receipt."Transaction Time" := TIME;
                    Receipt."User ID" := USERID;
                    Receipt."Auto  Receipt Date" := TODAY;
                    Receipt."Auto  Receipted" := TRUE;
                    Receipt.INSERT;

                    Receipt.RESET;
                    IF Receipt.FIND('+') THEN BEGIN


                        CustLedg.RESET;
                        CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                        //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                        CustLedg.SETRANGE(CustLedg.Open, TRUE);
                        CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                        IF CustLedg.FIND('-') THEN BEGIN

                            GenSetUp.GET();

                            REPEAT
                                CustLedg.CALCFIELDS(CustLedg."Remaining Amount");

                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := "Transaction Date";
                                GenJnl."Document No." := Receipt."Receipt No.";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                                IF Cust.GET("Student No.") THEN BEGIN
                                    IF Cust."Bill-to Customer No." <> '' THEN
                                        GenJnl."Account No." := Cust."Bill-to Customer No."
                                    ELSE
                                        GenJnl."Account No." := "Student No.";
                                END;
                                //GenJnl.Amount:=CustLedg."Amount Applied" * -1;
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := CustLedg.Description;
                                GenJnl."Shortcut Dimension 2 Code" := CustLedg."Global Dimension 2 Code";
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                //PKK
                                GenJnl."Applies-to Doc. Type" := CustLedg."Document Type";
                                GenJnl."Applies-to Doc. No." := CustLedg."Document No.";
                                GenJnl.VALIDATE(GenJnl."Applies-to Doc. No.");
                                GenJnl.INSERT;


                                ReceiptItems.INIT;
                                ReceiptItems."Receipt No" := Receipt."Receipt No.";
                                ReceiptItems."Transaction ID" := CustLedg."Document No.";
                                //ERROR('Test Test');

                                StudentCharges.RESET;
                                StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                                IF StudentCharges.GET(CustLedg."Document No.", "Student No.") THEN BEGIN
                                    ReceiptItems.Code := StudentCharges.Code;
                                    ReceiptItems."Reg. No" := StudentCharges."Reg. Transacton ID";
                                END;
                                ReceiptItems."Student No." := "Student No.";
                                ReceiptItems.Description := CustLedg.Description;
                                //ReceiptItems.Amount:=CustLedg."Amount Applied";
                                //ReceiptItems.Balance:=CustLedg."Remaining Amount" - CustLedg."Amount Applied";
                                ReceiptItems.INSERT;

                                //CustLedg."Apply to":=FALSE;
                                //CustLedg."Amount Applied":=0;
                                CustLedg.MODIFY;


                            UNTIL CustLedg.NEXT = 0;


                        END;

                        //Over Payment
                        IF "Amount to pay" <> TotalApplied THEN BEGIN
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := "Transaction Date";
                            GenJnl."Document No." := Receipt."Receipt No.";
                            //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := "Student No.";
                            GenJnl.Amount := ("Amount to pay" - TotalApplied) * -1;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'Pre Payment';
                            GenJnl.INSERT;




                            ReceiptItems.INIT;
                            ReceiptItems."Receipt No" := Receipt."Receipt No.";
                            ReceiptItems.Code := 'OP';
                            ReceiptItems.Description := 'Pre Payment';
                            ReceiptItems.Amount := "Amount to pay" - TotalApplied;
                            ReceiptItems.INSERT;


                        END;
                    END;

                    //Bank Entry

                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := "Transaction Date";
                    GenJnl."Document No." := Receipt."Receipt No.";
                    GenJnl."External Document No." := "Cheque No";
                    //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    //GenJnl."Account Type":=GenJnl."Account Type"::"Bank Account";
                    //GenJnl."Account No.":="Bank No.";
                    IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                        GenJnl."Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                        GenJnl."Account No." := 'BFS';
                    END ELSE
                        IF "Payment Mode" = "Payment Mode"::"Bank Slip" THEN BEGIN
                            GenJnl."Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                            GenJnl."Account No." := '300020';
                        END ELSE
                            IF "Payment Mode" = "Payment Mode"::Cash THEN BEGIN
                                GenJnl."Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                GenJnl."Account No." := '300021';
                            END ELSE
                                IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                                    GenJnl."Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    GenJnl."Account No." := '300022';
                                END;

                    GenJnl.Amount := "Amount to pay";
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description := Cust.Name;
                    GenJnl.INSERT;



                    //Post
                    /*
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name",'SALES');
                    GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnl);
                    MODIFY;
                    END;
                    */


                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        REPEAT
                            //window.OPEN('Posting:,#1######################');
                            //window.UPDATE(1,GenJnl."Line No.");
                            GLPosting.RUN(GenJnl);
                        UNTIL GenJnl.NEXT = 0;
                        //window.CLOSE;
                    END;




                    //MESSAGE('Transaction posted successfully.');
                    /*
                    //IF COMPANYNAME <> 'Kenya College of Accountancy 2' THEN BEGIN
                    Receipts.RESET;
                    Receipts.SETCURRENTKEY(Receipts."Receipt No.");
                    Receipts.SETRANGE(Receipts."Receipt No.",Receipt."Receipt No.");
                    IF Receipts.FIND('-') THEN
                    REPORT.RUN(39005847,True,False,Receipts);
                    */

                END;


                //END;

            end;
        }
        field(22; "Auto Receipt Entry"; Boolean)
        {
        }
        field(23; "Auto Bill"; Boolean)
        {

            trigger OnValidate()
            begin
                //Billing


                GenJnl.RESET;
                GenJnl.SETRANGE("Journal Template Name", 'SALES');
                GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                GenJnl.DELETEALL;

                GenSetUp.GET();
                GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

                //Charge Student if not charged
                StudentCharges.RESET;
                StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
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
                        GenJnl."Document No." := StudentCharges."Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        IF Cust.GET("Student No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "Student No.";
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
                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                Stages.TESTFIELD(Stages.Department);
                                GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                            END;

                        END ELSE
                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                    Units.TESTFIELD(Units.Department);
                                    GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                END;
                            END;

                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Due Date" := DueDate;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF StudentCharges."Recovery Priority" <> 0 THEN
                            //GenJnl."Recovery Priority":=StudentCharges."Recovery Priority"
                            //ELSE
                            //GenJnl."Recovery Priority":=25;
                            GenJnl.INSERT;

                        //Distribute Money
                        IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
                                    Stages.TESTFIELD(Stages."Distribution Account");
                                    StudentCharges.TESTFIELD(StudentCharges.Distribution);
                                    IF Cust.GET("Student No.") THEN BEGIN
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
                                        GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                        GenJnl."Account No." := GenSetUp."Pre-Payment Account";
                                        GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                        GenJnl.VALIDATE(GenJnl."Account No.");
                                        GenJnl.VALIDATE(GenJnl.Amount);
                                        GenJnl.Description := 'Fee Distribution';
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        GenJnl."Bal. Account No." := Stages."Distribution Account";
                                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                        IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees" THEN BEGIN
                                            IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                                GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                            END;

                                        END ELSE
                                            IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees" THEN BEGIN
                                                IF Units.GET(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Unit) THEN BEGIN
                                                    Units.TESTFIELD(Units.Department);
                                                    GenJnl."Shortcut Dimension 2 Code" := Units.Department;
                                                END;
                                            END;
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
                                    IF Stages.GET(StudentCharges.Programme, StudentCharges.Stage) THEN BEGIN
                                        Stages.TESTFIELD(Stages.Department);
                                        GenJnl."Shortcut Dimension 2 Code" := Stages.Department;
                                    END;
                                    GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                    GenJnl.INSERT;

                                END;
                            END;
                        END;
                        //End Distribution


                        StudentCharges.Recognized := TRUE;
                        StudentCharges.MODIFY;

                    UNTIL StudentCharges.NEXT = 0;



                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        REPEAT
                            GLPosting.RUN(GenJnl);
                        UNTIL GenJnl.NEXT = 0;
                    END;

                    //Billing


                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;

                    Cust.Status := Cust.Status::Current;
                    Cust.MODIFY;

                END;


                //BILLING
            end;
        }
        field(24; "Unref. Entry No."; Integer)
        {
            TableRelation = "Cust. Ledger Entry"."Entry No." WHERE("Customer No." = CONST('UNREF'),
                                                                    Open = CONST(true));

            trigger OnValidate()
            begin
                "Unref Document No." := '';
                "Amount to pay" := 0;
                IF CustL.GET("Unref. Entry No.") THEN BEGIN
                    CustL.CALCFIELDS(CustL."Remaining Amount");
                    "Unref Document No." := CustL."Document No.";
                    "Amount to pay" := CustL."Remaining Amount" * -1;
                    VALIDATE("Amount to pay");
                END;
            end;
        }
        field(25; "Unref Document No."; Code[20])
        {
        }
        field(26; "Auto Post 2"; Boolean)
        {

            trigger OnValidate()
            begin

                TESTFIELD("Transaction Date");

                IF "Payment Mode" = "Payment Mode"::"Bank Slip" THEN
                    TESTFIELD("Bank Slip Date");

                CustLedg.RESET;
                //CustLedg.SETCURRENTKEY(CustLedg."Customer No.",CustLedg."Apply to",CustLedg.Open,CustLedg.Reversed);
                CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                CustLedg.SETRANGE(CustLedg.Open, TRUE);
                CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                IF CustLedg.FIND('-') THEN BEGIN
                    REPEAT
                    //TotalApplied:=TotalApplied+CustLedg."Amount Applied";
                    UNTIL CustLedg.NEXT = 0;
                END;

                //("Amount to pay" - TotalApplied)
                //ERROR('%1',TotalApplied);
                IF "Amount to pay" <> TotalApplied THEN BEGIN

                END;


                IF Cust.GET("Student No.") THEN BEGIN
                    //Cust.Status:=Cust.Status::Current;
                    //Cust.MODIFY;
                END;


                GenJnl.RESET;
                GenJnl.SETRANGE("Journal Template Name", 'SALES');
                GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                GenJnl.DELETEALL;

                GenSetUp.GET();




                /////////////////////////////////////////////////////////////////////////////////
                //Receive payments
                IF "Payment Mode" <> "Payment Mode"::"Applies to Overpayment" THEN BEGIN

                    //Over Payment
                    TotalApplied := 0;

                    CustLedg.RESET;
                    //CustLedg.SETCURRENTKEY(CustLedg."Customer No.",CustLedg."Apply to",CustLedg.Open,CustLedg.Reversed);
                    CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                    // CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                    CustLedg.SETRANGE(CustLedg.Open, TRUE);
                    CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                    IF CustLedg.FIND('-') THEN BEGIN
                        REPEAT
                        //TotalApplied:=TotalApplied+CustLedg."Amount Applied";
                        UNTIL CustLedg.NEXT = 0;
                    END;

                    /*
                    Receipt.INIT;
                    Receipt."Receipt No.":='';
                    Receipt.VALIDATE(Receipt."Receipt No.");
                    Receipt."Student No.":="Student No.";
                    Receipt.Date:="Transaction Date";
                    Receipt."KCA Rcpt No":="KCA Receipt No";
                    Receipt."Payment Mode":="Payment Mode";
                    Receipt.Amount:="Amount to pay";
                    Receipt."Payment By":="Payment By";
                    Receipt."Transaction Date":=TODAY;
                    Receipt."Transaction Time":=TIME;
                    Receipt."User ID":=USERID;
                    Receipt."Auto  Receipt Date":=TODAY;
                    Receipt."Auto  Receipted":=TRUE;
                    Receipt.INSERT;
                    */


                    Receipt.RESET;
                    Receipt.SETRANGE(Receipt."Receipt No.", "Rcpt No.");
                    IF Receipt.FIND('-') THEN BEGIN


                        CustLedg.RESET;
                        //CustLedg.SETCURRENTKEY(CustLedg."Customer No.",CustLedg."Apply to",CustLedg.Open,CustLedg.Reversed);
                        CustLedg.SETRANGE(CustLedg."Customer No.", "Student No.");
                        //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                        CustLedg.SETRANGE(CustLedg.Open, TRUE);
                        CustLedg.SETRANGE(CustLedg.Reversed, FALSE);
                        IF CustLedg.FIND('-') THEN BEGIN

                            GenSetUp.GET();


                            REPEAT
                                CustLedg.CALCFIELDS(CustLedg."Remaining Amount");

                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := "Transaction Date";
                                GenJnl."Document No." := "Rcpt No.";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                                IF Cust.GET("Student No.") THEN BEGIN
                                    IF Cust."Bill-to Customer No." <> '' THEN
                                        GenJnl."Account No." := Cust."Bill-to Customer No."
                                    ELSE
                                        GenJnl."Account No." := "Student No.";
                                END;
                                //GenJnl.Amount:=CustLedg."Amount Applied" * -1;
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := CustLedg.Description;
                                GenJnl."Shortcut Dimension 2 Code" := CustLedg."Global Dimension 2 Code";
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                //PKK
                                GenJnl."Applies-to Doc. Type" := CustLedg."Document Type";
                                GenJnl."Applies-to Doc. No." := CustLedg."Document No.";
                                GenJnl.VALIDATE(GenJnl."Applies-to Doc. No.");
                                GenJnl.INSERT;


                                ReceiptItems.INIT;
                                ReceiptItems."Receipt No" := Receipt."Receipt No.";
                                ReceiptItems."Transaction ID" := CustLedg."Document No.";
                                //ERROR('Test Test');

                                StudentCharges.RESET;
                                StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                                IF StudentCharges.GET(CustLedg."Document No.", "Student No.") THEN BEGIN
                                    ReceiptItems.Code := StudentCharges.Code;
                                    ReceiptItems."Reg. No" := StudentCharges."Reg. Transacton ID";
                                END;
                                ReceiptItems."Student No." := "Student No.";
                                ReceiptItems.Description := CustLedg.Description;
                                //ReceiptItems.Amount:=CustLedg."Amount Applied";
                                //ReceiptItems.Balance:=CustLedg."Remaining Amount" - CustLedg."Amount Applied";
                                ReceiptItems.INSERT;

                                //CustLedg."Apply to":=FALSE;
                                //CustLedg."Amount Applied":=0;
                                CustLedg.MODIFY;


                            UNTIL CustLedg.NEXT = 0;


                        END;

                        //Over Payment
                        IF "Amount to pay" <> TotalApplied THEN BEGIN
                            GenJnl.INIT;
                            GenJnl."Line No." := GenJnl."Line No." + 10000;
                            GenJnl."Posting Date" := "Transaction Date";
                            GenJnl."Document No." := "Rcpt No.";
                            //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                            GenJnl.VALIDATE(GenJnl."Document No.");
                            GenJnl."Journal Template Name" := 'SALES';
                            GenJnl."Journal Batch Name" := 'STUD PAY';
                            GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                            GenJnl."Account No." := "Student No.";
                            GenJnl.Amount := ("Amount to pay" - TotalApplied) * -1;
                            GenJnl.VALIDATE(GenJnl."Account No.");
                            GenJnl.VALIDATE(GenJnl.Amount);
                            GenJnl.Description := 'Pre Payment';
                            GenJnl.INSERT;




                            ReceiptItems.INIT;
                            ReceiptItems."Receipt No" := Receipt."Receipt No.";
                            ReceiptItems.Code := 'OP';
                            ReceiptItems.Description := 'Pre Payment';
                            ReceiptItems.Amount := "Amount to pay" - TotalApplied;
                            ReceiptItems.INSERT;


                        END;
                    END;

                    //Bank Entry
                    /*
                    GenJnl.INIT;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date":="Transaction Date";
                    GenJnl."Document No.":=Receipt."Receipt No.";
                    GenJnl."External Document No.":="Cheque No";
                    //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                    GenJnl.VALIDATE(GenJnl."Document No.");
                    GenJnl."Journal Template Name":='SALES';
                    GenJnl."Journal Batch Name":='STUD PAY';
                    GenJnl."Account Type":=GenJnl."Account Type"::"Bank Account";
                    GenJnl."Account No.":="Bank No.";
                    GenJnl.Amount:="Amount to pay";
                    GenJnl.VALIDATE(GenJnl."Account No.");
                    GenJnl.VALIDATE(GenJnl.Amount);
                    GenJnl.Description:=Cust.Name;
                    GenJnl.INSERT;
                    */

                    IF "Payment Mode" <> "Payment Mode"::Unreferenced THEN BEGIN

                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        GenJnl."Posting Date" := "Transaction Date";
                        GenJnl."Document No." := Receipt."Receipt No.";
                        GenJnl."External Document No." := "Cheque No";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::"Bank Account";
                        GenJnl."Account No." := "Bank No.";
                        GenJnl.Amount := "Amount to pay";
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := Cust.Name;
                        GenJnl.INSERT;

                    END ELSE BEGIN


                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        GenJnl."Posting Date" := "Transaction Date";
                        GenJnl."Document No." := Receipt."Receipt No.";
                        GenJnl."External Document No." := "Cheque No";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl."Account No." := 'UNREF';
                        GenJnl.Amount := "Amount to pay";
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := Cust.Name;
                        GenJnl."Applies-to Doc. No." := "Unref Document No.";
                        GenJnl.VALIDATE(GenJnl."Applies-to Doc. No.");
                        GenJnl.INSERT;


                    END;



                    //Post

                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    IF GenJnl.FIND('-') THEN BEGIN
                        REPEAT
                            //window.OPEN('Posting:,#1######################');
                            //window.UPDATE(1,GenJnl."Line No.");
                            GLPosting.RUN(GenJnl);
                        UNTIL GenJnl.NEXT = 0;
                        //window.CLOSE;
                    END;


                END;

            end;
        }
        field(27; "Rcpt No."; Code[20])
        {
        }
        field(28; Currency; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                VALIDATE("Amount to pay");
            end;
        }
        field(29; "Auto Post Final"; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Transaction Date");

                IF "Payment Mode" = "Payment Mode"::"Bank Slip" THEN
                    TESTFIELD("Bank Slip Date");



                ///////////////////////////////////////////
                //Receive payments
                IF "Payment Mode" <> "Payment Mode"::"Applies to Overpayment" THEN BEGIN

                    Receipt.INIT;
                    Receipt."Receipt No." := '';
                    Receipt.VALIDATE(Receipt."Receipt No.");
                    Receipt."Student No." := "Student No.";
                    Receipt.Date := "Transaction Date";
                    Receipt."KCA Rcpt No" := "KCA Receipt No";
                    Receipt."Payment Mode" := "Payment Mode";
                    Receipt.Amount := "Amount to pay";
                    Receipt."Payment By" := "Payment By";
                    Receipt."Transaction Date" := TODAY;
                    Receipt."Transaction Time" := TIME;
                    Receipt."User ID" := USERID;
                    Receipt."Auto  Receipt Date" := TODAY;
                    Receipt."Auto  Receipted" := TRUE;
                    Receipt.INSERT;

                    Receipt.RESET;
                    IF Receipt.FIND('+') THEN BEGIN


                        GenSetUp.GET();

                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        GenJnl."Posting Date" := "Transaction Date";
                        GenJnl."Document No." := Receipt."Receipt No.";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        IF Cust.GET("Student No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "Student No.";
                        END;
                        GenJnl.Amount := "Amount to pay" * -1;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := "Payment By";
                        IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                            GenJnl."Bal. Account No." := 'BFS';
                        END ELSE
                            IF "Payment Mode" = "Payment Mode"::"Bank Slip" THEN BEGIN
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                GenJnl."Bal. Account No." := '300020';
                            END ELSE
                                IF "Payment Mode" = "Payment Mode"::Cheque THEN BEGIN
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    GenJnl."Bal. Account No." := '300021';
                                END ELSE
                                    IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        GenJnl."Bal. Account No." := '300022';
                                    END;

                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                        GenJnl.INSERT;


                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            REPEAT
                                GLPosting.RUN(GenJnl);
                            UNTIL GenJnl.NEXT = 0;
                        END;


                        /*
                        DetailedCLedg.RESET;
                        DetailedCLedg.SETCURRENTKEY(DetailedCLedg."Document No.",DetailedCLedg."Entry Type");
                        DetailedCLedg.SETRANGE(DetailedCLedg."Document No.",Receipt."Receipt No.");
                        DetailedCLedg.SETRANGE(DetailedCLedg."Entry Type",DetailedCLedg."Entry Type"::Application);
                        IF DetailedCLedg.FIND('-') THEN BEGIN
                        REPEAT
                        CustLedg2.SETCURRENTKEY(CustLedg2."Entry No.");
                        IF CustLedg2.GET(DetailedCLedg."Cust. Ledger Entry No.") THEN BEGIN
                        ReceiptItems.INIT;
                        ReceiptItems."Receipt No":=Receipt."Receipt No.";
                        ReceiptItems."Transaction ID":=CustLedg2."Document No.";
                        StudentCharges.RESET;
                        StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
                        IF StudentCharges.GET(CustLedg2."Document No.","Student No.") THEN BEGIN
                        ReceiptItems.Code:=StudentCharges.Code;
                        ReceiptItems."Reg. No":=StudentCharges."Reg. Transacton ID";
                        END;
                        ReceiptItems."Student No.":="Student No.";
                        ReceiptItems.Description:=CustLedg2.Description;
                        ReceiptItems.Amount:=DetailedCLedg."Credit Amount";
                        ReceiptItems.Balance:=CustLedg2."Remaining Amount";
                        ReceiptItems.INSERT;

                        END;

                        UNTIL DetailedCLedg.NEXT = 0;
                        END;
                        */


                    END;


                END;

            end;
        }
        field(30; "Staff Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." WHERE("Customer Posting Group" = CONST('SUNDRY'));

            trigger OnValidate()
            begin
                InvoiceHeader.SETRANGE(InvoiceHeader."No.", "Staff Invoice No.");
                IF InvoiceHeader.FIND('-') THEN BEGIN
                    "Staff Description" := InvoiceHeader."Bill-to Customer No." + ' ' + InvoiceHeader."Bill-to Name";
                END;
                "Transaction Date" := InvoiceHeader."Posting Date";
                // Get The Invoice Amount
                InvoiceLine.SETRANGE(InvoiceLine."Document No.", "Staff Invoice No.");
                IF InvoiceLine.FIND('-') THEN BEGIN
                    REPEAT
                        InvAmount := InvAmount + InvoiceLine.Amount
                    UNTIL InvoiceLine.NEXT = 0;
                END;
                "Amount to pay" := InvAmount;
            end;
        }
        field(31; "Staff Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
        IF StudentCharges.FIND('-') THEN BEGIN
            StudentCharges.MODIFYALL(StudentCharges."Applied Amount", 0);
            StudentCharges.MODIFYALL(StudentCharges."Apply to", FALSE);
        END;

        "Transaction Date" := TODAY;
    end;

    var
        CustLedger: Record 21;
        StudentCharges: Record 61535;
        CustLedgEn: Record 21;
        AmountToApply: Decimal;
        GenJnl: Record 81;
        Stages: Record 61516;
        Units: Record 61517;
        ExamsByStage: Record 61526;
        ExamsByUnit: Record 61527;
        Charges: Record 61515;
        Receipt: Record 61538;
        ReceiptItems: Record 61539;
        GenSetUp: Record 61534;
        TotalApplied: Decimal;
        Sems: Record 61518;
        DueDate: Date;
        Cust: Record 18;
        CustPostGroup: Record 92;
        window: Dialog;
        GLPosting: Codeunit 12;
        Receipts: Record 61538;
        CReg: Record 61532;
        CustLedg: Record 21;
        CustL: Record 21;
        DetailedCLedg: Record 379;
        CustLedg2: Record 21;
        InvoiceHeader: Record 112;
        InvoiceLine: Record 113;
        InvAmount: Decimal;
}

