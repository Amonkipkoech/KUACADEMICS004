/// <summary>
/// Report ACA-Marketing Strategy (ID 50049).
/// </summary>
report 50049 "ACA-Marketing Strategy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACAMarketingStrategy.rdl';

    dataset
    {
        dataitem("ACA-Marketing Strategies"; 61648)
        {
            column(mktDesc_desc; "ACA-Marketing Strategies".Code + ': ' + "ACA-Marketing Strategies".Description)
            {
            }
            dataitem("ACA-Enquiry Header"; 61348)
            {
                DataItemLink = "How You knew about us" = FIELD(Code);
                column(No; "ACA-Enquiry Header"."Enquiry No.")
                {
                }
                column(Date; "ACA-Enquiry Header"."Enquiry Date")
                {
                }
                column(SName; "ACA-Enquiry Header".Surname)
                {
                }
                column(ONames; "ACA-Enquiry Header"."Other Names")
                {
                }
                column(Programme; "ACA-Enquiry Header".Programmes)
                {
                }
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
}

