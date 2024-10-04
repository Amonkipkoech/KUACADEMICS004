table 60006 "ELECT-Candidates"
{

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Candidate Names"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Candidate No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Position Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "ELECT-Positions"."Position Code" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(5; "Votes Count"; Integer)
        {
            CalcFormula = Count("ELECT-Ballot Register" WHERE("Election Code" = FIELD("Election Code"),
                                                               "Candidate No." = FIELD("Candidate No."),
                                                               "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(6; "Position Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Electral District Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(8; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Campaign Slogan"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Campaign Statement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Photo/Potrait"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Candidate No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

