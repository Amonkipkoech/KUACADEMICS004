report 51490 "Receipts List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts List.rdl';

    dataset
    {
        dataitem(DataItem5672; 61538)
        {
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
            column(Receipt_Date; Date)
            {
            }
            column(Receipt__Payment_Mode_; "Payment Mode")
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Receipt__Transaction_Date_; "Transaction Date")
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
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
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt__Payment_Mode_Caption; FIELDCAPTION("Payment Mode"))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt__Transaction_Date_Caption; FIELDCAPTION("Transaction Date"))
            {
            }
            column(Receipt__Transaction_Time_Caption; FIELDCAPTION("Transaction Time"))
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

