table 61012 "ACA-Old Programmes"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Desc; Text[100])
        {
        }
        field(3; "New Code FK"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme".Code WHERE(Description = FIELD(Desc)));
            FieldClass = FlowField;
        }
        field(4; "New Code"; Code[20])
        {
            TableRelation = "ACA-Programme";
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

