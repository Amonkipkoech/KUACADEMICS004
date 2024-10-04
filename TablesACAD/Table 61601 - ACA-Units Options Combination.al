table 61601 "ACA-Units Options Combination"
{

    fields
    {
        field(1; Programme; Code[20])
        {
        }
        field(2; Stage; Code[20])
        {
        }
        field(3; Unit; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(4; Option; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programme));
        }
    }

    keys
    {
        key(Key1; Programme, Stage, Unit, Option)
        {
        }
    }

    fieldgroups
    {
    }
}

