table 77730 "ACA-Count. Exam Attendance"
{

    fields
    {
        field(1; "User Name"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Counted Students"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User Name", Programme, Semester, "Unit Code", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

