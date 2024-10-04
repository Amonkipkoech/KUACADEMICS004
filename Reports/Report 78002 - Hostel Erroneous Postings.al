report 78002 "Hostel Erroneous Postings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Erroneous Postings.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61155)
        {
            RequestFilterFields = "Hostel No", "Room No", "Space No", Student, Semester;
            column(studNo; hostel.Student)
            {
            }
            column(HostelNo; hostel."Hostel No")
            {
            }
            column(RoomNo; hostel."Room No")
            {
            }
            column(SpaceNo; hostel."Space No")
            {
            }
            column(Charges; hostel.Charges)
            {
            }
            column(Allocated; hostel.Allocated)
            {
            }
            column(Billed; hostel.Billed)
            {
            }
            column(Cleared; hostel.Cleared)
            {
            }
            column(stdName; Customer.Name)
            {
            }
            column(Valid; hostel.Valid)
            {
            }
            column(sem; hostel.Semester)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Customer.GET(hostel.Student) THEN BEGIN
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
        Customer: Record 18;
        hostel: Record "ACA-Students Hostel Rooms";
}

