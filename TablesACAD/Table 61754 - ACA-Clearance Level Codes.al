table 61754 "ACA-Clearance Level Codes"
{

    fields
    {
        field(1; Sequence; Integer)
        {
        }
        field(2; "Clearance Level Code"; Code[50])
        {
        }
        field(3; Status; Option)
        {
            OptionCaption = 'Active,In-Active';
            OptionMembers = Active,"In-Active";
        }
        field(4; Standard; Boolean)
        {
        }
        field(5; "Priority Level"; Option)
        {
            OptionCaption = 'Normal,1st Level,Final level';
            OptionMembers = Normal,"1st Level","Final level";
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code")
        {
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }
}

