report 60018 "Aca-Hostel Allocations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Aca-Hostel Allocations.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = Semester, "Hostel No";
            column(SNo; "ACA-Students Hostel Rooms".Student)
            {
            }
            column(HNo; "ACA-Students Hostel Rooms"."Hostel No")
            {
            }
            column(RNo; "ACA-Students Hostel Rooms"."Room No")
            {
            }
            column(Sem; "ACA-Students Hostel Rooms".Semester)
            {
            }
            column(AYear; "ACA-Students Hostel Rooms"."Academic Year")
            {
            }
            column(Scharges; "ACA-Students Hostel Rooms".Charges)
            {
            }
            column(BDate; FORMAT("ACA-Students Hostel Rooms"."Billed Date"))
            {
            }
            column(SpaceNo; "ACA-Students Hostel Rooms"."Space No")
            {
            }
            column(seq; seq)
            {
            }
            column(name; "ACA-Students Hostel Rooms"."Student Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(seq);
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
        seq: Integer;
}

