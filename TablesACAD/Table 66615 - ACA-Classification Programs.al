table 66615 "ACA-Classification Programs"
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
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Classification Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Pass Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Pass Status Count"; Integer)
        {
            CalcFormula = Count("ACA-Classification Details" WHERE("User ID" = FIELD("User ID"),
                                                                    "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                    "Programme Code" = FIELD("Programme Code"),
                                                                    "Pass Status" = FIELD("Pass Status")));
            FieldClass = FlowField;
        }
        field(6; "Pass Status Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Classification Count"; Integer)
        {
            CalcFormula = Count("ACA-Classification Details" WHERE("User ID" = FIELD("User ID"),
                                                                    "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                    "Programme Code" = FIELD("Programme Code"),
                                                                    "Classification Code" = FIELD("Classification Code")));
            FieldClass = FlowField;
        }
        field(8; "Classification Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme".Code;
        }
        field(10; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Total Number of Students"; Integer)
        {
            CalcFormula = Count("ACA-Classification Details" WHERE("User ID" = FIELD("User ID"),
                                                                    "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                    "Programme Code" = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(12; "Year of Study Text"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Final Year Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Msg1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Msg2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Msg3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Msg4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Msg5; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Msg6; Text[250])
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
    }

    keys
    {
        key(Key1; "User ID", "Graduation Academic Year", "Classification Code", "Programme Code")
        {
        }
    }

    fieldgroups
    {
    }
}

