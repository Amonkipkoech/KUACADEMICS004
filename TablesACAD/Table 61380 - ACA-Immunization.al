table 61380 "ACA-Immunization"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of immunization in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the description of the medical condition in the database';
        }
        field(3; Mandatory; Boolean)
        {
            Description = 'Stores the state of the immunization in the database';
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

