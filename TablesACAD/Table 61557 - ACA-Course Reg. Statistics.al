table 61557 "ACA-Course Reg. Statistics"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Less Units"; Integer)
        {
        }
        field(3; "Required Min"; Integer)
        {
        }
        field(4; "Programme Total"; Integer)
        {
        }
        field(5; "Zero Units"; Integer)
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

