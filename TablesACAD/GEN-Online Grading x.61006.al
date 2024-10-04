/// <summary>
/// Table GEN-Online Grading x (ID 61006).
/// </summary>
table 61006 "GEN-Online Grading x"
{

    fields
    {
        field(1; "Student No"; Code[20])
        {
        }
        field(2; "Unit Code"; Code[10])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Assignment 1"; Text[30])
        {
        }
        field(5; "Assignment 2"; Text[30])
        {
        }
        field(6; "CAT 1"; Text[30])
        {
        }
        field(7; "CAT 2"; Text[30])
        {
        }
        field(8; "CAT 3"; Text[30])
        {
        }
        field(9; Exam; Text[30])
        {
        }
        field(10; Grade; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Student No", "Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

