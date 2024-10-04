table 74525 "TT-Legend Programmes"
{

    fields
    {
        field(1; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Column No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Semester, "Programme Code", "User Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

