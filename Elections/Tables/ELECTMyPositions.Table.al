/// <summary>
/// Table ELECT-My Positions (ID 60011).
/// </summary>
table 60011 "ELECT-My Positions"
{

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Position Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Positions"."Position Code";
        }
        field(3; "Voter No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Has Candidate"; Boolean)
        {
            CalcFormula = Exist("ELECT-Candidates" WHERE("Election Code" = FIELD("Election Code"),
                                                        "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Position Code", "Voter No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

