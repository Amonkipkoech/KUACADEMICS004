table 61568 "ACA-Exam Category"
{
    DrillDownPageID = 68799;
    LookupPageID = 68799;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Series; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Series, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

