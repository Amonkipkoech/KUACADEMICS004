table 66661 "ACA-Exam Attendance Register"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lecturer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Exam Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Exam End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Exam Hall ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Semester Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Unit Code", "Semester Code")
        {
        }
    }

    fieldgroups
    {
    }
}

