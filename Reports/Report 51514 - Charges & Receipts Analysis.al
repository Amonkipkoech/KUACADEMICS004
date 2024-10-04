report 51514 "Charges & Receipts Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Charges & Receipts Analysis.rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));

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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__No__Of_Receipts_; "No. Of Receipts")
            {
            }
            column(Customer__No_Of_Charges_; "No Of Charges")
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__No__Of_Receipts_Caption; FIELDCAPTION("No. Of Receipts"))
            {
            }
            column(Customer__No_Of_Charges_Caption; FIELDCAPTION("No Of Charges"))
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
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

