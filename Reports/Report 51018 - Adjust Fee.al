report 51018 "Adjust Fee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Adjust Fee.rdl';

    dataset
    {
        dataitem(AFS; 61523)
        {
            DataItemTableView = WHERE("Stage Code" = FILTER('Y1S1'),
                                      "Settlemet Type" = FILTER('JAB'));
            column(prog; AFS."Programme Code")
            {
            }
            column(stage; AFS."Stage Code")
            {
            }
            column(type; AFS."Settlemet Type")
            {
            }
            column(Amount; AFS."Break Down")
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
}

