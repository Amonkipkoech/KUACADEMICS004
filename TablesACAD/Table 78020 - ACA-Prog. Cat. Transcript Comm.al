table 78020 "ACA-Prog. Cat. Transcript Comm"
{

    fields
    {
        field(1; "Exam Catogory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Pass Comment"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Failed Comment"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Include Programme Name"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Exam Catogory", "Year of Study")
        {
        }
    }

    fieldgroups
    {
    }
}

