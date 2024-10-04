report 51487 "Receipts - Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts - Details.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("User ID");
            RequestFilterFields = "User ID", "Student No.", "Receipt No.", Date;
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
            column(Receipt__Transaction_Date_; "Transaction Date")
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
            {
            }
            column(SName; SName)
            {
            }
            column(Receipt_Entries___DetailedCaption; Receipt_Entries___DetailedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt_Items_CodeCaption; "ACA-Receipt Items".FIELDCAPTION(Code))
            {
            }
            column(Receipt_Items_DescriptionCaption; "ACA-Receipt Items".FIELDCAPTION(Description))
            {
            }
            column(Receipt_Items_AmountCaption; "ACA-Receipt Items".FIELDCAPTION(Amount))
            {
            }
            column(Receipt_Items_BalanceCaption; "ACA-Receipt Items".FIELDCAPTION(Balance))
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
            column(Receipt__Transaction_Date_Caption; FIELDCAPTION("Transaction Date"))
            {
            }
            column(Receipt__Transaction_Time_Caption; FIELDCAPTION("Transaction Time"))
            {
            }
            column(SNameCaption; SNameCaptionLbl)
            {
            }
            column(Receipt_User_ID; "User ID")
            {
            }
            dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
            {
                DataItemLink = "Receipt No" = FIELD("Receipt No.");
                column(Receipt_Items_Code; Code)
                {
                }
                column(Receipt_Items_Description; Description)
                {
                }
                column(Receipt_Items_Amount; Amount)
                {
                }
                column(Receipt_Items_Balance; Balance)
                {
                }
                column(Receipt_Items_Receipt_No; "Receipt No")
                {
                }
                column(Receipt_Items_Uniq_No_2; "Uniq No 2")
                {
                }
                column(Receipt_Items_Transaction_ID; "Transaction ID")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Receipt"."Student No.") THEN
                    SName := Cust.Name
                ELSE
                    SName := '';
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
        Receipt_Entries___DetailedCaptionLbl: Label 'Receipt Entries - Detailed';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        SNameCaptionLbl: Label 'Label1000000031';
}

