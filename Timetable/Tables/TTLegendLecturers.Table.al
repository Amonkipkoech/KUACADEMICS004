table 74526 "TT-Legend Lecturers"
{

    fields
    {
        field(1; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lecturer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Lecturer Name"; Text[200])
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
        key(Key1; Semester, "Lecturer Code", "User Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

