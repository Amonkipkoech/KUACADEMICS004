table 61379 "ACA-Medical Condition"
{
    //LookupPageID = 68504;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the medical condition in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the name of the medical condition in the database';
        }
        field(3; Mandatory; Boolean)
        {
            Description = 'Stores the state of the medical condition';
        }
        field(4; Family; Boolean)
        {
            Description = 'Stores the state of the medical condition whether it is also based on family in the database';
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

