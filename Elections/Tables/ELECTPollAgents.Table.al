table 60014 "ELECT-Poll Agents"
{

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(3; "Polling Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Polling Centers"."Polling Center Code" WHERE("Election Code" = FIELD("Election Code"),
                                                                                 "Electral District" = FIELD("Electral District"));
        }
        field(4; "National ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Names; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Candidates"."Candidate No." WHERE("Election Code" = FIELD("Election Code"));
        }
        field(7; "Candidate Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Candidate No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Electral District", "Polling Center", "National ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

