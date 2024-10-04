table 61546 "ACA-Course Prerequisite"
{

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
        field(3; Requirement; Text[150])
        {
            NotBlank = true;
        }
        field(4; Mandatory; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Requirement)
        {
        }
    }

    fieldgroups
    {
    }
}

