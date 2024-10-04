/// <summary>
/// Table ACA-Lecturers Eval. Sum. Count (ID 77771).
/// </summary>
table 77771 "ACA-Lecturers Eval. Sum. Count"
{

    fields
    {
        field(2; "Semester Code"; Code[20])
        {
        }
        field(4; "User ID"; Code[20])
        {
        }
        field(5; Sequence; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Semester Code", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

