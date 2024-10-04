report 51014 "Room Spaces"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Room Spaces.rdl';

    dataset
    {
        dataitem(AS; 61824)
        {
            column(host; AS."Hostel Code")
            {
            }
            column(room; AS."Room Code")
            {
            }
            column(spc; AS."Space Code")
            {
            }
            column(cost; AS."Room Cost")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AS."Room Cost" := 5500;
                MODIFY;
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

