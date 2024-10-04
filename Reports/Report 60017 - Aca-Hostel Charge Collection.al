report 60017 "Aca-Hostel Charge Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Aca-Hostel Charge Collection.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            DataItemTableView = WHERE(Billed = FILTER(true));
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

