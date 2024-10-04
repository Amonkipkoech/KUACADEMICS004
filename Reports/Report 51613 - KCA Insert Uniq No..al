report 51613 "KCA Insert Uniq No."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA Insert Uniq No..rdl';

    dataset
    {
        dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
        {
            RequestFilterFields = "Receipt No", "Uniq No.";
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
            column(Receipt_Items__Receipt_No_; "Receipt No")
            {
            }
            column(Receipt_Items_Code; Code)
            {
            }
            column(Receipt_Items_Description; Description)
            {
            }
            column(Receipt_Items_Amount; Amount)
            {
            }
            column(Receipt_Items__Uniq_No__; "Uniq No.")
            {
            }
            column(Receipt_ItemsCaption; Receipt_ItemsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt_Items__Receipt_No_Caption; FIELDCAPTION("Receipt No"))
            {
            }
            column(Receipt_Items_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Receipt_Items_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Receipt_Items_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt_Items__Uniq_No__Caption; FIELDCAPTION("Uniq No."))
            {
            }
            column(Receipt_Items_Uniq_No_2; "Uniq No 2")
            {
            }
            column(Receipt_Items_Transaction_ID; "Transaction ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                UniqNo := UniqNo + 1;
                "ACA-Receipt Items"."Uniq No 2" := UniqNo;
                "ACA-Receipt Items".MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                UniqNo := 7000;
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
        UniqNo: Integer;
        Receipt_ItemsCaptionLbl: Label 'Receipt Items';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

