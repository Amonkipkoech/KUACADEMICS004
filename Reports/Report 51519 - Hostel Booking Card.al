report 51519 "Hostel Booking Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Booking Card.rdl';

    dataset
    {
        dataitem("ACA-Students Hostel Rooms"; "ACA-Students Hostel Rooms")
        {
            column(LineNo_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Line No")
            {
            }
            column(SpaceNo_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Space No")
            {
            }
            column(RoomNo_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Room No")
            {
            }
            column(HostelNo_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Hostel No")
            {
            }
            column(AccomodationFee_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Accomodation Fee")
            {
            }
            column(AllocationDate_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Allocation Date")
            {
            }
            column(ClearanceDate_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Clearance Date")
            {
            }
            column(Charges_StudentsHostelRooms; "ACA-Students Hostel Rooms".Charges)
            {
            }
            column(Student_StudentsHostelRooms; "ACA-Students Hostel Rooms".Student)
            {
            }
            column(Billed_StudentsHostelRooms; "ACA-Students Hostel Rooms".Billed)
            {
            }
            column(BilledDate_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Billed Date")
            {
            }
            column(Semester_StudentsHostelRooms; "ACA-Students Hostel Rooms".Semester)
            {
            }
            column(Cleared_StudentsHostelRooms; "ACA-Students Hostel Rooms".Cleared)
            {
            }
            column(OverPaid_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Over Paid")
            {
            }
            column(OverPaidAmt_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Over Paid Amt")
            {
            }
            column(EvictionCode_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Eviction Code")
            {
            }
            column(Gender_StudentsHostelRooms; "ACA-Students Hostel Rooms".Gender)
            {
            }
            column(HostelAssigned_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Hostel Assigned")
            {
            }
            column(HostelName_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Hostel Name")
            {
            }
            column(StudentName_StudentsHostelRooms; "ACA-Students Hostel Rooms"."Student Name")
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

