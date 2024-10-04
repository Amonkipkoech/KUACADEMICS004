table 61626 "ACA-Hostel Reservation Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(4; "Reservation Code"; Code[20])
        {
            TableRelation = "ACA-Host Reservation Reasons".Code;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

