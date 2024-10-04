table 60010 "ELECT-Results Rankings"
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
        field(3; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Votes Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Ranking; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Winner; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "% Votes"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Position Code", "Candidate No.")
        {
            Clustered = true;
        }
        key(Key2; "Election Code", "Position Code", "Votes Count")
        {
        }
        key(Key3; "Election Code", "Position Code", Ranking)
        {
        }
    }

    fieldgroups
    {
    }
}

