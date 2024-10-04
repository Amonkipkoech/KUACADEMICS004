table 74519 "TT-Blocks"
{
    DrillDownPageID = "TT-Blocks List";
    LookupPageID = "TT-Blocks List";

    fields
    {
        field(1; "Block Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Buidings Setups"."Building Code";
            //"Fixed Asset"."No." WHERE("FA Subclass Code" = FILTER('BUILDINGS'));
            trigger OnValidate()
            var
            Bl: Record "ACA-Buidings Setups";
            begin
                Bl.Reset();
                Bl.SetRange("Building Code");
                if Bl.Find('-') then
                    "Block Description" := Bl."Building Name";

            end;
        }
        field(2; "Block Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Buidings Setups"."Building Name" WHERE("Building Code" = FIELD("Block Code")));
            FieldClass = FlowField;
        }
        field(3; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(4; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code WHERE("Academic Year" = FIELD("Academic Year"));
        }
    }

    keys
    {
        key(Key1; "Block Code", "Academic Year", Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TTRooms.RESET;
        TTRooms.SETRANGE(Semester, Rec.Semester);
        TTRooms.SETRANGE("Block Code", Rec."Block Code");
        IF TTRooms.FIND('-') THEN TTRooms.DELETEALL;
    end;

    var
        TTRooms: Record 74501;
}

