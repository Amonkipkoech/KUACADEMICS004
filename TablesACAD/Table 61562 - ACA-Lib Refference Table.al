table 61562 "ACA-Lib Refference Table"
{

    fields
    {
        field(1; Course; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; LibCode; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Course)
        {
        }
    }

    fieldgroups
    {
    }
}

