table 74520 "TT-Lessons"
{
    DrillDownPageID = 74529;
    LookupPageID = 74529;

    fields
    {
        field(1; "Lesson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lesson Order"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End TIme"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Lesson Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

