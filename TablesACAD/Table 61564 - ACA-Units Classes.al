table 61564 "ACA-Units Classes"
{
    // DrillDownPageID = 67095;
    // LookupPageID = 67095;

    fields
    {
        field(1; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; "Code"; Code[20])
        {
        }
        field(4; Description; Text[150])
        {
            NotBlank = true;
        }
        field(5; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Unit, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

