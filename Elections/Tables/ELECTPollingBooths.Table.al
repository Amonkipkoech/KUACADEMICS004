table 60009 "ELECT-Polling Booths"
{
    DrillDownPageID = 60017;
    LookupPageID = 60017;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Polling Center Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Polling Centers"."Polling Center Code" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(3; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce" WHERE("Election Code" = FIELD("Election Code"),
                                                                                        "Electral District Doce" = FIELD("Electral District"));
        }
        field(4; "Booth Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Login Acc. Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Login Password"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Polling Center Code", "Electral District", "Booth Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

