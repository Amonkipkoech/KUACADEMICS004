table 61364 "ACA-Applic. Setup Grade"
{
    LookupPageID = 68475;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the grade in the database';
        }
        field(2; Grade; Text[30])
        {
            Description = 'Stores the description of the grade in the database';
        }
        field(3; Points; Integer)
        {
            Description = 'Stores the points for the grade';
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

