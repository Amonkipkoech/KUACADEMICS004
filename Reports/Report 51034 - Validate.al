report 51034 Validate
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Validate.rdl';

    dataset
    {
        dataitem(cust; 18)
        {
            column(no; Cust."No.")
            {
            }
            column(name; Cust.Name)
            {
            }
            column(Gender; Cust.Gender)
            {
            }
            column(Dept; Cust."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Gender > 1 THEN BEGIN
                    Gender := Gender - 1;
                    MODIFY;
                END;
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
        unitofNeasure: Record 5404;
}

