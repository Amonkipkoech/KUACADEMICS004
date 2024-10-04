table 61759 "ACA-Clearance Conditions list"
{

    fields
    {
        field(1; "Clearance Level Code"; Code[50])
        {
            TableRelation = "ACA-Clearance Level Codes"."Clearance Level Code";
        }
        field(2; Sequence; Integer)
        {
        }
        field(3; "Condition to Check"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code", Sequence)
        {
        }
    }

    fieldgroups
    {
    }
}

