table 61655 "ACA-Online Application Notes"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2; "Application Notes"; Text[250])
        {
        }
        field(3; "Order"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Application Notes")
        {
        }
    }

    fieldgroups
    {
    }
}

