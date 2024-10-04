codeunit 84532 "Post Stud Receipt Buff"
{

    Access = Public;

    trigger OnRun()
    begin

    end;

    var
        LastReceiptNo: Code[20];
        "No. Series Line": Record "No. Series Line";
        BankRec: Record "Bank Account";

        "Last No": Code[20];
        StudPay: Record 61536;
        Cust: Record 18;
        GenJnl: Record 81;
        GenSetup: Record 61534;
        GLPosting: Codeunit 12;
        Stud: Record 18;
        StudentNo: Code[20];
        CReg: Record 61532;
        LineNo: Integer;
        //TransType: Option " ","M-pesa",Cheque,"Direct Bank Deposit",HELB,Bursary,CDF,Scholarship;
        Imported_Receipts_BufferCaptionLbl: Label 'Imported Receipts Buffer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        TransBank: Code[20];
        receiptsBuffer: Record "ACA-Imp. Receipts Buffer";

    procedure PostReceiptBuffer(var receiptBuffer: Record "Receipts Buffer")
    begin

        receiptBuffer.Find();
        receiptBuffer.TestField("No.");

        GenSetup.GET();

        //delete exisiting gen journal lines before re inserting
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        if not GenJnl.IsEmpty then GenJnl.DeleteAll();

        //find receipts buffer lines
        receiptsBuffer.Reset();
        receiptsBuffer.SetRange("Transaction Code", receiptBuffer."No.");
        //receiptsBuffer.SetRange("Batch No.", receiptBuffer."Batch No.");
        receiptsBuffer.SetRange(Posted, false);
        receiptsBuffer.SetFilter(Amount, '>%1', 0);
        if receiptsBuffer.Find('-') then
            repeat
                IF Stud.GET(receiptsBuffer."Student No.") THEN BEGIN
                    StudentNo := Stud."No.";
                END ELSE
                    EXIT;
                StudPay.RESET;
                StudPay.SETRANGE(StudPay."Student No.", StudentNo);
                //StudPay.SetRange("User ID", UserId);
                IF not StudPay.IsEmpty THEN
                    StudPay.DELETEALL;


                StudPay.INIT;
                StudPay."Student No." := receiptsbuffer."Student No.";
                StudPay."User ID" := USERID;
                //StudPay."Payment Mode":=StudPay."Payment Mode"::"Direct Bank Deposit";
                IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::Cheque THEN BEGIN
                    StudPay."Payment Mode" := StudPay."Payment Mode"::Cheque;
                end else
                    IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"M-pesa" THEN BEGIN
                        StudPay."Payment Mode" := StudPay."Payment Mode"::"M-Pesa";
                    end else
                        IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"Direct Bank Deposit" THEN BEGIN
                            StudPay."Payment Mode" := StudPay."Payment Mode"::"Direct Bank Deposit";
                        END ELSE
                            StudPay."Cheque No" := receiptsBuffer."Cheque No";
                StudPay."Drawer Name" := receiptsBuffer.Description;
                StudPay."Payment By" := receiptsBuffer.Description;
                StudPay."Bank No." := receiptBuffer."Bank Code";
                StudPay."Amount to pay" := receiptsBuffer.Amount;
                //StudPay."Cheque No" := "ACA-Imp. Receipts Buffer"."Cheque No";
                StudPay.VALIDATE(StudPay."Amount to pay");
                StudPay."Transaction Date" := receiptsBuffer.Date;
                //StudPay.VALIDATE(StudPay."Auto Bill");
                StudPay.VALIDATE(StudPay."Auto Post Final");

                StudPay.INSERT;

                //gl entry
                // GenJnl.INIT;
                // GenJnl."Line No." := GenJnl."Line No." + 110000;
                // GenJnl."Posting Date" := receiptsBuffer.Date;
                // GenJnl."Document No." := receiptsBuffer."Transaction Code";
                // GenJnl.VALIDATE(GenJnl."Document No.");
                // GenJnl."Journal Template Name" := 'SALES';
                // GenJnl."Journal Batch Name" := 'STUD PAY';
                // GenJnl."Document Type" := GenJnl."Document Type"::Payment;
                // GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                // GenJnl."External Document No." := receiptsBuffer."Receipt No";
                // GenJnl."Account No." := receiptsBuffer."Student No.";


                // GenJnl.Amount := receiptsBuffer.Amount * -1;
                // GenJnl.VALIDATE(GenJnl."Account No.");
                // GenJnl.VALIDATE(GenJnl.Amount);
                // //scholarshipHeader.TestField("G/L Account");
                // //GenJnl."Bal. Account No." := scholarshipHeader."G/L Account";
                // GenJnl.Description := receiptsBuffer.Description + '-' + receiptBuffer."Batch No.";
                // IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::Cheque THEN BEGIN
                //     GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                //     GenJnl."Bal. Account No." := receiptBuffer."Bank Code";
                // end else
                //     IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"M-pesa" THEN BEGIN
                //         GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                //         GenJnl."Bal. Account No." := receiptBuffer."Bank Code";
                //     END ELSE
                //         IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::"Direct Bank Deposit" THEN BEGIN
                //             GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"Bank Account";
                //             GenJnl."Bal. Account No." := receiptBuffer."Bank Code";
                //         END ELSE
                //             // IF TransType = TransType::HELB THEN BEGIN
                //             //     GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                //             //     GenSetup.TESTFIELD(GenSetup."Helb Account");
                //             //     GenJnl."Bal. Account No." := GenSetup."Helb Account";
                //             // END ELSE
                //             IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::Bursary THEN BEGIN
                //                 GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                //                 GenSetup.TESTFIELD(GenSetup."CDF Account");
                //                 GenJnl."Bal. Account No." := GenSetup."CDF Account";
                //             END ELSE
                //                 IF receiptBuffer."Transaction Type" = receiptBuffer."Transaction Type"::CDF THEN BEGIN
                //                     GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                //                     GenSetup.TESTFIELD(GenSetup."CDF Account");
                //                     GenJnl."Bal. Account No." := GenSetup."CDF Account";
                //                 END;

                // GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                // GenJnl.INSERT;

                receiptsBuffer.Unallocated := TRUE;
                receiptsBuffer.Posted := TRUE;
                receiptBuffer.Posted := True;
                receiptsBuffer.MODIFY;

            until receiptsBuffer.Next() = 0;

        // GenJnl.Reset();
        // GenJnl.SETRANGE("Journal Template Name", 'SALES');
        // GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        // IF GenJnl.FIND('-') THEN BEGIN
        //     CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);

        // end;


    end;

}