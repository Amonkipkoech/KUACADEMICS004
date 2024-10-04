report 51005 "Jab Billing Correction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Jab Billing Correction.rdl';

    dataset
    {
        dataitem(CR; 61532)
        {
            RequestFilterFields = Stage, "Settlement Type";
            column(No; CR."Student No.")
            {
            }
            column(Prog; CR.Programmes)
            {
            }
            column(Stage; CR.Stage)
            {
            }
            column(SettlementType; CR."Settlement Type")
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

