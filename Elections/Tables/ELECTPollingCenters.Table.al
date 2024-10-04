table 60008 "ELECT-Polling Centers"
{
    DrillDownPageID = 60018;
    LookupPageID = 60018;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Polling Center Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(4; "No. of Registered Voters"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              "Electral District" = FIELD("Electral District"),
                                                              "Polling Center Code" = FIELD("Polling Center Code")));
            FieldClass = FlowField;
        }
        field(5; "No. of Votes Cast"; Integer)
        {
            CalcFormula = Count("ELECT-Voter Register" WHERE("Election Code" = FIELD("Election Code"),
                                                              "Electral District" = FIELD("Electral District"),
                                                              "Polling Center Code" = FIELD("Polling Center Code"),
                                                              Voted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(6; "Returning Officer ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Returning Officer Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Polling Center Code", "Electral District")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

