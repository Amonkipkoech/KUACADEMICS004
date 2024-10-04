table 40003 "Rotation Group"
{
    Caption = 'Rotation Group';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Group ID"; Integer)
        {
            Caption = 'Group ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Lab ID"; Integer)
        {
            Caption = 'Lab ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Week"; Integer)
        {
            Caption = 'Week';
            DataClassification = ToBeClassified;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
        }
        field(6; "Semester"; Code[20])
        {
            Caption = 'Semester';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Group ID", "Student No.", "Week")
        {
            Clustered = true;
        }
    }
}

