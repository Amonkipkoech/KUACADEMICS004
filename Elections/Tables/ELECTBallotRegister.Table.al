/// <summary>
/// Table ELECT-Ballot Register (ID 60007).
/// </summary>
table 60007 "ELECT-Ballot Register"
{

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ballot ID"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ELECTVoterRegister.RESET;
                ELECTVoterRegister.SETRANGE("Ballot ID", Rec."Ballot ID");
                IF ELECTVoterRegister.FIND('-') THEN BEGIN
                    "Voting Time" := TIME;
                    "Votting Date" := TODAY;
                    "Electral District" := ELECTVoterRegister."Electral District";
                    "Department Code" := ELECTVoterRegister."Department Code";
                    "School Code" := ELECTVoterRegister."School Code";
                    "Campus Code" := ELECTVoterRegister."Campus Code";
                    "Polling Center" := ELECTVoterRegister."Polling Center Code";
                END;
            end;
        }
        field(4; "Position Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Positions"."Position Code" WHERE("Election Code" = FIELD("Election Code"));

            trigger OnValidate()
            begin
                ELECTPositions.RESET;
                ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                ELECTPositions.SETRANGE("Position Code", Rec."Position Code");
                IF ELECTPositions.FIND('-') THEN BEGIN
                    "Electral District" := ELECTPositions."Electral District";
                    "Campus Code" := ELECTPositions."Campus Code";
                    "Department Code" := ELECTPositions."Department Code";
                    "School Code" := ELECTPositions."School Code";
                    "Voting Time" := TIME;
                    "Votting Date" := TODAY;
                END;
            end;
        }
        field(5; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Votting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Voting Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce";
        }
        field(9; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Polling Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Polling Booth"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Ballot ID", "Position Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ELECTVoterRegister: Record 60002;
        ELECTPositions: Record 60001;
}

