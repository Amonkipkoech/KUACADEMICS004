table 40023  "Supp Exam Registration Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            AutoIncrement = true;
        }

        field(2; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Application No.';
            TableRelation = "Supp Exam Registration Header";
        }

        field(3; "Student Admission No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Student Admission No.';
        }

        field(4; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Code';
        }

        field(5; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Name';
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }

        key(ApplicationNo; "Application No.")
        {
            Clustered = false;
        }
    }
}

