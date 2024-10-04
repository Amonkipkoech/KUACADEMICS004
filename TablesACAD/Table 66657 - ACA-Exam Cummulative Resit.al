table 66657 "ACA-Exam Cummulative Resit"
{

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Student Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(6; "Department Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "School Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Grade; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Credit Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Serial; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Unit Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Unit Code", "Student Number", "Academic Year")
        {
        }
        key(Key2; Programme, "Student Number")
        {
        }
        key(Key3; "Student Number")
        {
        }
    }

    fieldgroups
    {
    }
}

