table 61736 "ACA-Exams Activites Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Semester Code"; Code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(4; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(5; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
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

