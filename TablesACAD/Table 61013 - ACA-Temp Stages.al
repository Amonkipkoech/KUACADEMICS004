table 61013 "ACA-Temp Stages"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Stage; Code[20])
        {
        }
        field(3; Remarks; Code[20])
        {
        }
        field(4; "Exist In Creg"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD(Code), Stage = FIELD(Stage)));
            FieldClass = FlowField;
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

