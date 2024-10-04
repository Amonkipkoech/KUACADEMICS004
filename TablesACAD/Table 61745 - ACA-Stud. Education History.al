table 61745 "ACA-Stud. Education History"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(2; "School/College Attended"; Text[150])
        {
        }
        field(4; "School/College Grade"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", "School/College Attended")
        {
        }
    }

    fieldgroups
    {
    }
}

