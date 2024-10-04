/// <summary>
/// Table TT-Weight Lesson Categories (ID 74506).
/// </summary>
table 74506 "TT-Weight Lesson Categories"
{
    LookupPageId = "TT-Weight Lesson Categories";
    DrillDownPageId = "TT-Weight Lesson Categories";

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; "Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Single Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Double Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Triple Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Quadruple  Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Penta Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Hexa Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Hepta Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Octa Classes"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Default Category"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

