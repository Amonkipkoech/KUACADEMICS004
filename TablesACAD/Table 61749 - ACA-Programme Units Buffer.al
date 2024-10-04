table 61749 "ACA-Programme Units Buffer"
{

    fields
    {
        field(1; "Prog. Code"; Code[50])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Unit Code"; Code[50])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Credit Hours"; Integer)
        {
        }
        field(5; Posted; Boolean)
        {
        }
        field(6; Stage; Code[10])
        {
        }
        field(7; Counted; Integer)
        {
        }
        field(8; "Failure Reason"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Counted, "Prog. Code", "Unit Code", Stage)
        {
        }
    }

    fieldgroups
    {
    }
}

