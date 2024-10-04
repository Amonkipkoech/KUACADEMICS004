/// <summary>
/// Table ELECT-Positions (ID 60001).
/// </summary>
table 60001 "ELECT-Positions"
{
    DrillDownPageID = 60016;
    LookupPageID = 60016;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Position Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Position Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Position Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Electral District"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Electoral Districts"."Electral District Doce";
        }
        field(6; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2));
        }
        field(7; "No. Of Candidates"; Integer)
        {
            CalcFormula = Count("ELECT-Candidates" WHERE("Election Code" = FIELD("Election Code"),
                                                        "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(8; "Position Approved"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Position Approved" = TRUE THEN BEGIN
                    IF "Position Scope" = "Position Scope"::"Campus Position" THEN BEGIN
                        TESTFIELD("Campus Code");
                    END ELSE
                        IF "Position Scope" = "Position Scope"::"School Position" THEN BEGIN
                            TESTFIELD("School Code");
                        END ELSE
                            IF "Position Scope" = "Position Scope"::"Departmental Position" THEN BEGIN
                                TESTFIELD("Department Code");
                            END ELSE
                                IF "Position Scope" = "Position Scope"::"Electral District Position" THEN BEGIN
                                    TESTFIELD("Electral District");
                                END;
                END;
            end;
        }
        field(9; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(3));
        }
        field(10; "Campus Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
        field(11; "Position Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "ELECT-Position Categories"."Category Code" WHERE("Election Code" = FIELD("Election Code"));
        }
        field(12; "No. of Applications"; Integer)
        {
            CalcFormula = Count("ELECT-Candidates Applications" WHERE("Election Code" = FIELD("Election Code"),
                                                                       "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(14; "Votes Cast"; Integer)
        {
            CalcFormula = Count("ELECT-Ballot Register" WHERE("Election Code" = FIELD("Election Code"),
                                                               "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(15; "First Position"; Code[20])
        {
            CalcFormula = Lookup("ELECT-Candidates"."Candidate No." WHERE("Election Code" = FIELD("Election Code"),
                                                                         "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(16; "Highest Score"; Integer)
        {
        }
        field(17; "Count Highest Positions"; Integer)
        {
            CalcFormula = Count("ELECT-Candidates" WHERE("Election Code" = FIELD("Election Code"),
                                                        "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(18; "Tie Exists"; Boolean)
        {
            CalcFormula = Exist("ELECT-Positions" WHERE("Election Code" = FIELD("Election Code"),
                                                       "Position Code" = FIELD("Position Code")));
            FieldClass = FlowField;
        }
        field(19; "Position Scope"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Overal Position,School Position,Campus Position,Electral District Position,Departmental Position';
            OptionMembers = "Overal Position","School Position","Campus Position","Electral District Position","Departmental Position";

            trigger OnValidate()
            begin
                "Electral District" := '';
                "Campus Code" := '';
                "Department Code" := '';
                "School Code" := '';
                "Position Approved" := FALSE;
            end;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Position Code", "Position Category", "Electral District", "School Code", "Department Code", "Campus Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

