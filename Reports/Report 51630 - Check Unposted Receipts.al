report 51630 "Check Unposted Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Check Unposted Receipts.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Un Posted";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
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
            column(Receipt__Payment_Mode_; "Payment Mode")
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Receipt__KCA_Rcpt_No_; "KCA Rcpt No")
            {
            }
            column(Receipt__Un_Posted_; "Un Posted")
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
            column(Receipt__Payment_Mode_Caption; FIELDCAPTION("Payment Mode"))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt__KCA_Rcpt_No_Caption; FIELDCAPTION("KCA Rcpt No"))
            {
            }
            column(Receipt__Un_Posted_Caption; FIELDCAPTION("Un Posted"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                BankLedg.RESET;
                BankLedg.SETCURRENTKEY(BankLedg."Document No.");
                BankLedg.SETRANGE(BankLedg."Document No.", "ACA-Receipt"."Receipt No.");
                IF BankLedg.FIND('-') = FALSE THEN BEGIN
                    "ACA-Receipt"."Un Posted" := TRUE;
                    "ACA-Receipt".MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                "ACA-Receipt".MODIFYALL("ACA-Receipt"."Un Posted", FALSE);
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
        BankLedg: Record 271;
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

