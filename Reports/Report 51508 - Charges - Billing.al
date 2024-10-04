report 51508 "Charges - Billing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Charges - Billing.rdl';

    dataset
    {
        dataitem(DataItem9183; 61515)
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Date Filter";
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
            column(Charge__Date_Filter_; "Date Filter")
            {
            }
            column(Charge_Code; Code)
            {
            }
            column(Charge_Description; Description)
            {
            }
            column(Charge__G_L_Account_; "G/L Account")
            {
            }
            column(Charge__Total_Billing_; "Total Billing")
            {
            }
            column(Charge__Total_Billing__Control1000000016; "Total Billing")
            {
            }
            column(Charges___Amount_ReceiptedCaption; Charges___Amount_ReceiptedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Charge__Date_Filter_Caption; FIELDCAPTION("Date Filter"))
            {
            }
            column(Charge_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Charge_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Charge__G_L_Account_Caption; FIELDCAPTION("G/L Account"))
            {
            }
            column(Charge__Total_Billing_Caption; FIELDCAPTION("Total Billing"))
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
        Charges___Amount_ReceiptedCaptionLbl: Label 'Charges - Amount Receipted';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

