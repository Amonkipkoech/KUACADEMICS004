table 74527 "TT-Legend Units"
{

    fields
    {
        field(1; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Name"; Text[200])
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
        key(Key1; Semester, "Unit Code", "User Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

