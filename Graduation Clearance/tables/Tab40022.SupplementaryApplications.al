table 40022  "Supp Exam Registration Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Application No.';
        }

        field(2; "Student Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Full Name';
        }

        field(3; "Student Admission No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Admission No.';
        }

        field(4; "Program"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Program';
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }
}

