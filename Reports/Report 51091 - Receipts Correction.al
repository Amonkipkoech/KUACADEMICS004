report 51091 "Receipts Correction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Correction.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Student No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt_Date; Date)
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(ReceiptCaption; ReceiptCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }

            trigger OnAfterGetRecord()
            begin
                DetL.RESET;
                DetL.SETRANGE(DetL."Customer No.", "ACA-Receipt"."Student No.");
                DetL.SETRANGE(DetL."Posting Date", "ACA-Receipt"."Transaction Date");
                DetL.SETRANGE(DetL."Document No.", 'REC-07044');
                IF DetL.FIND('-') THEN BEGIN
                    REPEAT
                        // if DetL."Document No."<>Receipt."Receipt No." then begin
                        // if (DetL.Amount=Receipt.Amount) or (DetL.Amount=-Receipt.Amount) then begin
                        DetL."Document No." := "ACA-Receipt"."Receipt No.";
                        DetL.MODIFY;
                    // end;
                    // end;
                    UNTIL DetL.NEXT = 0;
                END;

                CustL.RESET;
                CustL.SETRANGE(CustL."Customer No.", "ACA-Receipt"."Student No.");
                CustL.SETRANGE(CustL."Posting Date", "ACA-Receipt"."Transaction Date");
                CustL.SETFILTER(CustL."Document No.", 'REC-07044');
                IF CustL.FIND('-') THEN BEGIN
                    //if CustL."Document No."<>Receipt."Receipt No." then begin
                    CustL."Document No." := "ACA-Receipt"."Receipt No.";
                    CustL.MODIFY;
                    // end;
                END;

                BankL.RESET;
                BankL.SETRANGE(BankL."Bal. Account No.", "ACA-Receipt"."Student No.");
                BankL.SETRANGE(BankL."Posting Date", "ACA-Receipt"."Transaction Date");
                BankL.SETRANGE(BankL."Document No.", 'REC-07044');
                IF BankL.FIND('-') THEN BEGIN
                    BankL."Document No." := "ACA-Receipt"."Receipt No.";
                    BankL.MODIFY;
                END;

                GLE.RESET;
                GLE.SETRANGE(GLE."Bal. Account No.", "ACA-Receipt"."Student No.");
                GLE.SETRANGE(GLE."Posting Date", "ACA-Receipt"."Transaction Date");
                GLE.SETRANGE(GLE."Document No.", 'REC-07044');
                IF GLE.FIND('-') THEN BEGIN
                    GLE."Document No." := "ACA-Receipt"."Receipt No.";
                    GLE.MODIFY;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustL: Record 21;
        DetL: Record 379;
        BankL: Record 271;
        GLE: Record 17;
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

