/// <summary>
/// Table ACA-Lecturers Evaluation Count (ID 77770).
/// </summary>
table 77770 "ACA-Lecturers Evaluation Count"
{

    fields
    {
        field(1; "Lecturer No."; Code[20])
        {
        }
        field(2; "Semester Code"; Code[20])
        {
        }
        field(3; "Course Code"; Code[20])
        {
        }
        field(4; "User ID"; Code[30])
        {
        }
        field(5; Sequence; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Lecturer No.", "Semester Code", "Course Code", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

