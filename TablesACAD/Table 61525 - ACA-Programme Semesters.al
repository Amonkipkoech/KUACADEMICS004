table 61525 "ACA-Programme Semesters"
{
    DrillDownPageID = 68750;
    LookupPageID = 68750;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; Remarks; Text[150])
        {
        }
        field(4; Budget; Integer)
        {
        }
        field(5; Current; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Programme Code", Semester)
        {
        }
    }

    fieldgroups
    {
    }
}

