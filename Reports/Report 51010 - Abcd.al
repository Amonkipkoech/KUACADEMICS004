report 51010 Abcd
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Abcd.rdl';

    dataset
    {
        dataitem(AC; 61533)
        {
            column(a; AC."Programme Code")
            {
            }
            column(b; AC."Stage Code")
            {
            }
            column(c; AC."Settlement Type")
            {
            }
            column(d; AC."Student Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AC."Student Type" := AC."Student Type"::"Full Time";
                AC.MODIFY;
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
}

