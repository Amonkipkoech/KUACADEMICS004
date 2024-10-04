table 61650 "ACA-Online Application Users"
{

    fields
    {
        field(1; UserId; Integer)
        {
        }
        field(2; UserName; Text[20])
        {
        }
        field(3; Password; Text[20])
        {
        }
        field(4; Email; Text[30])
        {
        }
        field(5; "Created Date"; Date)
        {
        }
        field(6; "Last login Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; UserId)
        {
        }
    }

    fieldgroups
    {
    }
}

