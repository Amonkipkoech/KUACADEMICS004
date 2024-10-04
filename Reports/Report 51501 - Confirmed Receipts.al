report 51501 "Confirmed Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Confirmed Receipts.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Student No.", "Receipt No.", Date, "KCA Rcpt No";
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
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Student_Name_; "Student Name")
            {
            }
            column(Receipt__KCA_Rcpt_No_; "KCA Rcpt No")
            {
            }
            column(Receipt_Date; Date)
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Receipt__Payment_By_; "Payment By")
            {
            }
            column(ReceiptCaption; ReceiptCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Receipt__Student_Name_Caption; FIELDCAPTION("Student Name"))
            {
            }
            column(Receipt__KCA_Rcpt_No_Caption; FIELDCAPTION("KCA Rcpt No"))
            {
            }
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt__Payment_By_Caption; FIELDCAPTION("Payment By"))
            {
            }
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
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

