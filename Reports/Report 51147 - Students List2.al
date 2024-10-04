report 51147 "Students List2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students List2.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Settlement Type Filter";
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
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

