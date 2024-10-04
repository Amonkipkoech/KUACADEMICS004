/// <summary>
/// Table EXT-Periods (ID 74556).
/// </summary>
table 74556 "EXT-Periods"
{
    DrillDownPageID = 74555;
    LookupPageID = 74555;

    fields
    {
        field(1; "Period Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Period Order"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

