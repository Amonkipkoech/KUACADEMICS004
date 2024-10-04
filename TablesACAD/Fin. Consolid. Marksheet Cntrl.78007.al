/// <summary>
/// Table Fin. Consolid. Marksheet Cntrl (ID 78007).
/// </summary>
table 78007 "Fin. Consolid. Marksheet Cntrl"
{

    fields
    {
        field(1; "Grad. Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(4; "Programme Code"; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(5; "Programme Option"; Code[20])
        {
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(6; "Prog. Option Name"; Text[150])
        {
            CalcFormula = Lookup("ACA-Programme Options".Desription WHERE("Programme Code" = FIELD("Programme Code"),
                                                                           Code = FIELD("Programme Option")));
            FieldClass = FlowField;
        }
        field(7; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(8; "Year of Study"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Grad. Academic Year", "Programme Code", "Programme Option", "Academic Year", "Year of Study")
        {
            Clustered = true;
        }
        key(Key2; "Grad. Academic Year", "Programme Code", "Year of Study")
        {
        }
    }

    fieldgroups
    {
    }
}

