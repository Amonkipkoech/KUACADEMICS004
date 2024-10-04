table 61513 "ACA-Student Types"
{
    // DrillDownPageID = 68739;
    // LookupPageID = 68739;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Remarks; Text[150])
        {
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

