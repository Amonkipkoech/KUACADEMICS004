table 74502 "TT-Days"
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
        field(3; "Day Code"; Code[20])
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
        key(Key1; "Academic Year", Semester, "Day Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TTDailyLessons.RESET;
        TTDailyLessons.SETRANGE(Semester, Rec.Semester);
        TTDailyLessons.SETRANGE("Day Code", Rec."Day Code");
        IF TTDailyLessons.FIND('-') THEN TTDailyLessons.DELETEALL;
    end;

    var
        TTDailyLessons: Record 74503;
}

