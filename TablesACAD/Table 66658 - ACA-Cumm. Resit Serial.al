table 66658 "ACA-Cumm. Resit Serial"
{

    fields
    {
        field(1; "Stuent No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; YoS; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cumm. Resit Serial"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; YoS, "Stuent No.", "Academic Year", "User ID")
        {
        }
        key(Key2; Programme, "Stuent No.")
        {
        }
    }

    fieldgroups
    {
    }
}

