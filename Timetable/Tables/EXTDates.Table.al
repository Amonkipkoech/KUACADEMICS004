/// <summary>
/// Table EXT-Dates (ID 74551).
/// </summary>
table 74551 "EXT-Dates"
{
    DrillDownPageID = 74524;
    LookupPageID = 74524;

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
        field(4; "Day Order"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Date Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EXTDailyPeriods.RESET;
        EXTDailyPeriods.SETRANGE(Semester, Rec.Semester);
        EXTDailyPeriods.SETRANGE("Date Code", Rec."Date Code");
        IF EXTDailyPeriods.FIND('-') THEN EXTDailyPeriods.DELETEALL;
    end;

    var
        EXTDailyPeriods: Record 74552;
}

