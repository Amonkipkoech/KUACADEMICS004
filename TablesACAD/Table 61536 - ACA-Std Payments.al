table 61536 "ACA-Std Payments"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Editable = false;
        }
        field(2; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(3; "Cheque No"; Code[20])
        {

            trigger OnValidate()
            begin
                StudPay.RESET;
                StudPay.SETRANGE(StudPay."Student No.", "Student No.");
                StudPay.SETRANGE(StudPay."Cheque No", "Cheque No");
                StudPay.SETRANGE(StudPay.Posted, TRUE);
                IF StudPay.FIND('-') THEN
                    IF CONFIRM('******Receipt Number Exists. Continue?', FALSE) = FALSE THEN
                        ERROR('Duplicate Receipt number');
            end;
        }
        field(4; "Drawer Name"; Text[150])
        {
        }
        field(5; "Drawer Bank"; Option)
        {
            OptionMembers = " ",BBK,KCB,CBA,Standard,Stanbic;
        }
        field(6; "Drawer' Branch Code"; Code[20])
        {
        }
        field(7; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Student No.")));
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
                CustLedgEn.SETCURRENTKEY(CustLedgEn."Customer No.", CustLedgEn."Posting Date", CustLedgEn.Open, CustLedgEn."Recovery Priority");
                CustLedgEn.SETRANGE(CustLedgEn."Customer No.", "Student No.");
                CustLedgEn.SETRANGE(CustLedgEn.Open, TRUE);
                IF CustLedgEn.FIND('-') THEN BEGIN
                    REPEAT
                        CustLedgEn.CALCFIELDS(CustLedgEn."Remaining Amt. (LCY)", CustLedgEn."Remaining Amount");
                        IF Currency = '' THEN BEGIN
                            IF CustLedgEn."Remaining Amt. (LCY)" > 0 THEN BEGIN
                                IF AmountToApply > CustLedgEn."Remaining Amt. (LCY)" THEN BEGIN
                                    CustLedgEn."Amount Applied" := CustLedgEn."Remaining Amt. (LCY)";
                                    AmountToApply := AmountToApply - CustLedgEn."Amount Applied";
                                    CustLedgEn."Apply to" := TRUE;
                                END ELSE BEGIN
                                    IF AmountToApply > 0 THEN BEGIN
                                        CustLedgEn."Amount Applied" := AmountToApply;
                                        CustLedgEn."Apply to" := TRUE;
                                        AmountToApply := 0;
                                    END ELSE BEGIN
                                        CustLedgEn."Amount Applied" := 0;
                                        CustLedgEn."Apply to" := FALSE;
                                    END;
                                END;
                                //CustLedgEn.MODIFY;
                            END;

                        END ELSE BEGIN
                            IF CustLedgEn."Remaining Amount" > 0 THEN BEGIN
                                IF AmountToApply > CustLedgEn."Remaining Amount" THEN BEGIN
                                    CustLedgEn."Amount Applied" := CustLedgEn."Remaining Amount";
                                    AmountToApply := AmountToApply - CustLedgEn."Amount Applied";
                                    CustLedgEn."Apply to" := TRUE;
                                END ELSE BEGIN
                                    IF AmountToApply > 0 THEN BEGIN
                                        CustLedgEn."Amount Applied" := AmountToApply;
                                        CustLedgEn."Apply to" := TRUE;
                                        AmountToApply := 0;
                                    END ELSE BEGIN
                                        CustLedgEn."Amount Applied" := 0;
                                        CustLedgEn."Apply to" := FALSE;
                                    END;
                                END;
                                //CustLedgEn.MODIFY;
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
            //OptionCaption = ' ,Bank Slip,Cheque,Banker''s Cheque,Cash,Applies to Overpayment,PDQ,Unreferenced,Money Order,Direct Bank Deposit,Staff Invoice,Weiver,HELB,CDF,Scholarship';
            OptionMembers = " ","Bank Slip",Cheque,"Banker's Cheque","M-Pesa",Cash,"Applies to Overpayment",PDQ,Unreferenced,"Money Order","Direct Bank Deposit","Staff Invoice",Weiver,HELB,CDF,Scholarship;
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
        }
        field(22; "Auto Receipt Entry"; Boolean)
        {
        }
        field(23; "Auto Bill"; Boolean)
        {


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
                GenSetUp.GET();
                if "Payment Mode" = "Payment Mode"::"M-Pesa" then begin
                    LastReceipt := '';
                    BankRec.Reset;
                    IF BankRec.GET("Bank No.") THEN BEGIN
                        //BankRec.TESTFIELD(BankRec."Bank Type");
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", BankRec."Receipt No. Series");
                        //  NoSeries.SETRANGE(NoSeries."Series Code", 'REC');
                        IF NoSeries.FIND('-') THEN BEGIN
                            LastReceipt := INCSTR(NoSeries."Last No. Used");
                            NoSeries."Last No. Used" := LastReceipt;
                            NoSeries.MODIFY;


                        END;
                    END;

                end;
                IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                    //TESTFIELD("Bank Slip Date");
                    LastReceipt := '';
                    BankRec.RESET;
                    IF BankRec.GET("Bank No.") THEN BEGIN
                        //BankRec.TESTFIELD(BankRec."Bank Type");
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", BankRec."Receipt No. Series");
                        //  NoSeries.SETRANGE(NoSeries."Series Code", 'REC');
                        IF NoSeries.FIND('-') THEN BEGIN
                            LastReceipt := INCSTR(NoSeries."Last No. Used");
                            NoSeries."Last No. Used" := LastReceipt;
                            NoSeries.MODIFY;


                        END;
                    END;
                END;
                if "Payment Mode" = "Payment Mode"::Cheque then begin
                    LastReceipt := '';
                    BankRec.Reset;
                    IF BankRec.GET("Bank No.") THEN BEGIN
                        //BankRec.TESTFIELD(BankRec."Bank Type");
                        NoSeries.RESET;
                        NoSeries.SETRANGE(NoSeries."Series Code", BankRec."Receipt No. Series");
                        //  NoSeries.SETRANGE(NoSeries."Series Code", 'REC');
                        IF NoSeries.FIND('-') THEN BEGIN
                            LastReceipt := INCSTR(NoSeries."Last No. Used");
                            NoSeries."Last No. Used" := LastReceipt;
                            NoSeries.MODIFY;


                        END;
                    END;

                end;
                IF "Payment Mode" = "Payment Mode"::CDF THEN BEGIN
                    //ELSE
                    NoSeries.RESET;
                    NoSeries.SETRANGE(NoSeries."Series Code", GenSetUp."Receipt Nos.");
                    IF NoSeries.FIND('-') THEN BEGIN
                        LastReceipt := INCSTR(NoSeries."Last No. Used");
                        NoSeries."Last No. Used" := LastReceipt;
                        NoSeries.MODIFY;
                    END;
                END;
                IF "Payment Mode" = "Payment Mode"::HELB THEN BEGIN
                    //ELSE
                    NoSeries.RESET;
                    NoSeries.SETRANGE(NoSeries."Series Code", 'HELB');
                    IF NoSeries.FIND('-') THEN BEGIN
                        LastReceipt := INCSTR(NoSeries."Last No. Used");
                        NoSeries."Last No. Used" := LastReceipt;
                        NoSeries.MODIFY;
                    END;
                END;
                IF "Payment Mode" = "Payment Mode"::Scholarship THEN BEGIN

                    NoSeries.RESET;
                    NoSeries.SETRANGE(NoSeries."Series Code", 'HELB');
                    IF NoSeries.FIND('-') THEN BEGIN
                        LastReceipt := INCSTR(NoSeries."Last No. Used");
                        NoSeries."Last No. Used" := LastReceipt;
                        NoSeries.MODIFY;
                    END;
                END;
                ///////////////////////////////////////////
                //Receive payments
                IF "Payment Mode" <> "Payment Mode"::"Applies to Overpayment" THEN BEGIN

                    Receipt.INIT;
                    Receipt."Receipt No." := LastReceipt;
                    //Receipt.VALIDATE(Receipt."Receipt No.");
                    Receipt."Student No." := "Student No.";
                    Receipt.Date := "Transaction Date";
                    Receipt."Bank Slip/Cheque No" := "Cheque No";
                    Receipt."KCA Rcpt No" := "KCA Receipt No";
                    Receipt."Payment Mode" := "Payment Mode"::"Direct Bank Deposit";
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

                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN GenJnl.DELETEALL;

                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 110000;
                        GenJnl."Posting Date" := "Transaction Date";
                        GenJnl."Document No." := LastReceipt;
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Document Type" := GenJnl."Document Type"::Payment;
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl."External Document No." := "Cheque No";
                        IF Cust.GET("Student No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "Student No.";
                        END;


                        GenJnl.Amount := "Amount to pay" * -1;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        IF "Payment Mode" = "Payment Mode"::Cheque THEN BEGIN
                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                            GenJnl."Bal. Account No." := "Bank No.";
                            GenJnl.Description := "Payment By" + '-' + 'Cheque';
                        END ELSE
                            IF "Payment Mode" = "Payment Mode"::"M-Pesa" THEN BEGIN
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                GenJnl."Bal. Account No." := "Bank No.";
                                GenJnl.Description := "Payment By" + '-' + 'M-pesa';
                            END ELSE
                                IF "Payment Mode" = "Payment Mode"::"Direct Bank Deposit" THEN BEGIN
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                                    GenJnl."Bal. Account No." := "Bank No.";
                                    GenJnl.Description := "Payment By" + '-' + 'Bank Deposit';
                                END ELSE
                                    IF "Payment Mode" = "Payment Mode"::HELB THEN BEGIN
                                        GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                        GenSetUp.TESTFIELD(GenSetUp."Helb Account");
                                        //GenJnl.Description:='Tuition-'+Semester+'-Helb';
                                        GenJnl.Description := "Payment By";
                                        GenJnl."Bal. Account No." := GenSetUp."Helb Account";
                                    END ELSE
                                        IF "Payment Mode" = "Payment Mode"::CDF THEN BEGIN
                                            GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                            GenSetUp.TESTFIELD(GenSetUp."CDF Account");
                                            GenJnl."Bal. Account No." := GenSetUp."CDF Account";//300021
                                            GenJnl.Description := "Payment By" + '-' + 'CDF';
                                        END ELSE
                                            IF "Payment Mode" = "Payment Mode"::Scholarship THEN BEGIN
                                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                                GenSetUp.TESTFIELD(GenSetUp."CDF Account");
                                                GenJnl."Bal. Account No." := GenSetUp."CDF Account";//300021
                                                GenJnl.Description := "Payment By" + '-' + 'CDF';
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


                        DetailedCLedg.RESET;
                        DetailedCLedg.SETCURRENTKEY(DetailedCLedg."Document No.", DetailedCLedg."Entry Type");
                        DetailedCLedg.SETRANGE(DetailedCLedg."Document No.", Receipt."Receipt No.");
                        DetailedCLedg.SETRANGE(DetailedCLedg."Entry Type", DetailedCLedg."Entry Type"::Application);
                        IF DetailedCLedg.FIND('-') THEN BEGIN
                            REPEAT
                                CustLedg2.SETCURRENTKEY(CustLedg2."Entry No.");
                                IF CustLedg2.GET(DetailedCLedg."Cust. Ledger Entry No.") THEN BEGIN
                                    ReceiptItems.INIT;
                                    ReceiptItems."Receipt No" := Receipt."Receipt No.";
                                    ReceiptItems."Transaction ID" := CustLedg2."Document No.";
                                    StudentCharges.RESET;
                                    StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
                                    IF StudentCharges.GET(CustLedg2."Document No.", "Student No.") THEN BEGIN
                                        ReceiptItems.Code := StudentCharges.Code;
                                        ReceiptItems."Reg. No" := StudentCharges."Reg. Transacton ID";
                                    END;
                                    ReceiptItems."Student No." := "Student No.";
                                    ReceiptItems.Description := CustLedg2.Description;
                                    ReceiptItems.Amount := DetailedCLedg."Credit Amount";
                                    ReceiptItems.Balance := CustLedg2."Remaining Amount";
                                    ReceiptItems.INSERT;

                                END;

                            UNTIL DetailedCLedg.NEXT = 0;
                        END;


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
        field(32; "CDF Account"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Customer));

            trigger OnValidate()
            begin
                IF Cust.GET("CDF Account") THEN
                    "CDF Description" := Cust.Name;
            end;
        }
        field(33; "CDF Description"; Text[100])
        {
        }
        field(34; Semester; Code[20])
        {
        }
        field(35; Posted; Boolean)
        {
        }
        //(36; "Unref Document No.")
    }

    keys
    {
        key(Key1; "Student No.", "Cheque No", Semester)
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
        CustLedger: Record "Cust. Ledger Entry";
        StudentCharges: Record "ACA-Std Charges";
        CustLedgEn: Record "Cust. Ledger Entry";
        AmountToApply: Decimal;
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
        TotalApplied: Decimal;
        Sems: Record "ACA-Semesters";
        DueDate: Date;
        Cust: Record "Customer";
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit 12;
        Receipts: Record "ACA-Receipt";
        CReg: Record "ACA-Course Registration";
        CustLedg: Record "Cust. Ledger Entry";
        CustL: Record "Cust. Ledger Entry";
        DetailedCLedg: Record "Detailed Cust. Ledg. Entry";
        CustLedg2: Record "Cust. Ledger Entry";
        InvoiceHeader: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        InvAmount: Decimal;
        StudPay: Record "ACA-Std Payments";
        BankRec: Record "Bank Account";
        NoSeries: Record "No. Series Line";
        LastReceipt: Code[20];
}

