table 61554 "ACA-Programme Options"
{
    DrillDownPageID = 68140;
    LookupPageID = 68140;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(3; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(4; Desription; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

