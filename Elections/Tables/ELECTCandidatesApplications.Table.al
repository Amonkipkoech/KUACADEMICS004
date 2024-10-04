/// <summary>
/// Table ELECT-Candidates Applications (ID 60005).
/// </summary>
table 60005 "ELECT-Candidates Applications"
{

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Elections Header"."Election Code" WHERE("Is Active" = FILTER(true));
        }
        field(2; "Candidate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-My Positions"."Voter No." WHERE("Election Code" = FIELD("Election Code"),
                                                                    "Position Code" = FIELD("Position Code"));

            trigger OnValidate()
            begin
                ELECTCandidatesApplications.RESET;
                ELECTCandidatesApplications.SETRANGE("Election Code", Rec."Election Code");
                ELECTCandidatesApplications.SETRANGE("Candidate No.", Rec."Candidate No.");
                IF ELECTCandidatesApplications.COUNT > 1 THEN ERROR('Already applied for a Post');
                IF "Candidate No." = '' THEN BEGIN
                    Rec."Candidate Names" := '';
                    Rec."Position Category" := '';
                    Rec."Position Code" := '';
                    Rec."Electraol District Code" := '';
                    Rec."Department Code" := '';
                    Rec."School Code" := '';
                    Rec."Campus Code" := '';
                    Rec."Campaign Slogan" := '';
                    Rec."Campaign Statement" := '';
                    Rec.Status := Rec.Status::New;
                END ELSE BEGIN
                    ELECTVoterRegister.RESET;
                    ELECTVoterRegister.SETRANGE("Election Code", Rec."Election Code");
                    ELECTVoterRegister.SETRANGE("Voter No.", Rec."Candidate No.");
                    IF ELECTVoterRegister.FIND('-') THEN BEGIN
                        Rec."Candidate Names" := ELECTVoterRegister."Voter Names";
                        Rec."Electraol District Code" := ELECTVoterRegister."Electral District";
                        Rec."Department Code" := ELECTVoterRegister."Department Code";
                        Rec."School Code" := ELECTVoterRegister."School Code";
                        Rec."Campus Code" := ELECTVoterRegister."Campus Code";
                        Rec."Campaign Slogan" := '';
                        Rec."Campaign Statement" := '';
                        Rec.Status := Rec.Status::New;
                    END;
                END;
            end;
        }
        field(3; "Candidate Names"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Position Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-My Positions"."Position Code" WHERE("Election Code" = FIELD("Election Code"),
                                                                        "Voter No." = FIELD("Candidate No."));
        }
        field(6; "Position Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Electraol District Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce";
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
        field(13; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'New,Approved,Rejected';
            OptionMembers = New,Approved,Rejected;
        }
        field(14; Approved; Boolean)
        {
            CalcFormula = Exist("ELECT-Candidates" WHERE("Candidate No." = FIELD("Candidate No."),
                                                        "Election Code" = FIELD("Election Code"),
                                                        "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(15; Qualifies; Boolean)
        {
            CalcFormula = Exist("ELECT-My Positions" WHERE("Election Code" = FIELD("Election Code"),
                                                            "Position Code" = FIELD("Position Code"),
                                                            "Voter No." = FIELD("Candidate No.")));
            FieldClass = FlowField;
        }
        field(16; "Photo/Potrait"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Candidate No.", "Position Code", "Position Category", "Electraol District Code", "Department Code", "School Code", "Campus Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ELECTVoterRegister: Record 60002;
        ELECTCandidatesApplications: Record 60005;
}

