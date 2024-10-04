report 51479 "Receipts Entries - Count"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Entries - Count.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("User ID");
            RequestFilterFields = "User ID";
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
            column(Receipt__User_ID_; "User ID")
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
            column(Receipt__Transaction_Date_; "Transaction Date")
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
            {
            }
            column(Receipt_Amount_Control1000000000; Amount)
            {
            }
            column(Receipt_EntriesCaption; Receipt_EntriesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__User_ID_Caption; FIELDCAPTION("User ID"))
            {
            }
            column(Receipt__Transaction_Time_Caption; FIELDCAPTION("Transaction Time"))
            {
            }
            column(Receipt__Transaction_Date_Caption; FIELDCAPTION("Transaction Date"))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt__Payment_Mode_Caption; FIELDCAPTION("Payment Mode"))
            {
            }
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("User ID");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        RecCount: Integer;
        Receipt_EntriesCaptionLbl: Label 'Receipt Entries';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

