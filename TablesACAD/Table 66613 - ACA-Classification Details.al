table 66613 "ACA-Classification Details"
{

    fields
    {
        field(1; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Graduation Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Pass Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Classification Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Classification Serial"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Graduation Serial"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Student Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Class Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Faculty; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(21; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENT'));
        }
        field(22; Appearances; Integer)
        {
            CalcFormula = Count("ACA-Classification Details" WHERE("User ID" = FIELD("User ID"),
                                                                    "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                    "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID", "Graduation Academic Year", "Student No.", "Programme Code")
        {
        }
        key(Key2; "Student No.", "Classification Code")
        {
        }
        key(Key3; "Student Name", "Pass Status", "Classification Code", "Class Order")
        {
        }
    }

    fieldgroups
    {
    }
}

