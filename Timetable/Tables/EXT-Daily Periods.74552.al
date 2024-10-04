/// <summary>
/// Table EXT-Daily Periods (ID 74552).
/// </summary>
table 74552 "EXT-Daily Periods"
{
    DrillDownPageID = 74559;
    LookupPageID = 74559;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Code"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Period Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "EXT-Periods"."Period Code";

            trigger OnValidate()
            begin
                EXTPeriods.RESET;
                EXTPeriods.SETRANGE("Period Code", Rec."Period Code");
                IF EXTPeriods.FIND('-') THEN BEGIN
                    Rec."Start Time" := EXTPeriods."Start Time";
                    Rec."End Time" := EXTPeriods."End Time";
                END;
            end;
        }
        field(5; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Date Code", "Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EXTPeriods: Record 74556;
}

