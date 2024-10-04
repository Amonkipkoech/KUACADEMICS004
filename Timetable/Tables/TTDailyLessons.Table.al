table 74503 "TT-Daily Lessons"
{
    DrillDownPageID = 74526;
    LookupPageID = 74526;

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
        field(4; "Lesson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Lessons"."Lesson Code";
        }
        field(5; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Day Code", "Lesson Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

