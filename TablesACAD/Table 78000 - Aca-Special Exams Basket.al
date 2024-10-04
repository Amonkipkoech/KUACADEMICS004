table 78000 "Aca-Special Exams Basket"
{

    fields
    {
        field(1; "Academic Year"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Exam Session"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(5; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Description"; Text[150])
        {
            FieldClass = Normal;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Posted';
            OptionMembers = New,Posted;
        }
        field(11; "CAT Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Exam Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Grade; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Catogory; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Special,Supplementary';
            OptionMembers = " ",Special,Supplementary;
        }
        field(17; "Current Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Marks Exists"; Boolean)
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "Student No.", Stage, Programme, Semester, "Academic Year", Catogory, "Unit Code")
        {
        }
    }

    fieldgroups
    {
    }
}

