table 60004 "ELECT-Electoral Districts"
{
    DrillDownPageID = 60020;
    LookupPageID = 60020;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Electral District Doce"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No. of Registered Voters"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              "Electral District" = FIELD("Electral District Doce")));
            FieldClass = FlowField;
        }
        field(5; "No. of Votes Cast"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              "Electral District" = FIELD("Electral District Doce"),
                                                              Voted = FILTER(true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Electral District Doce")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

