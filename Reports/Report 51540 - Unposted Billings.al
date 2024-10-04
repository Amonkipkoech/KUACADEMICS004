report 51540 "Unposted Billings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Unposted Billings.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Unbilled Charged" = FILTER(> 0));
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
            column(Customer__Unbilled_Charged_; "Unbilled Charged")
            {
            }
            column(Billings_Pending_PostingCaption; Billings_Pending_PostingCaptionLbl)
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
            column(Customer__Unbilled_Charged_Caption; FIELDCAPTION("Unbilled Charged"))
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
        Billings_Pending_PostingCaptionLbl: Label 'Billings Pending Posting';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

