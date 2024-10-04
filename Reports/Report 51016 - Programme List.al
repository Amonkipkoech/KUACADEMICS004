report 51016 "Programme List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme List.rdl';

    dataset
    {
        dataitem(PL; 61511)
        {
            column(Schl; PL."School Code")
            {
            }
            column("code"; PL.Code)
            {
            }
            column(Description; PL.Description)
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

