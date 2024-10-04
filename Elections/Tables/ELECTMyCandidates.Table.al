table 60012 "ELECT-My Candidates"
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
        field(4; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Candidate Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Candidate No.")));
            FieldClass = FlowField;
        }
        field(6; "Has Candidate"; Boolean)
        {
            CalcFormula = Exist("ELECT-Candidates" WHERE("Election Code" = FIELD("Election Code"),
                                                        "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Position Code", "Voter No.", "Candidate No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

