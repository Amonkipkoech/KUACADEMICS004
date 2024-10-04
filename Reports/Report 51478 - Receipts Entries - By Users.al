report 51478 "Receipts Entries - By Users"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Entries - By Users.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("User ID");
            RequestFilterFields = "User ID", Date;
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
            column(SName; SName)
            {
            }
            column(No; No)
            {
            }
            column(Receipt_Amount_Control1000000007; Amount)
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
            column(NameCaption; NameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Receipt"."Student No.") THEN
                    SName := Cust.Name
                ELSE
                    SName := '';
                No := No + 1
            end;

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
        Cust: Record 18;
        SName: Text[200];
        No: Integer;
        Receipt_EntriesCaptionLbl: Label 'Receipt Entries';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
}

