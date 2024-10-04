table 61842 "ACA-Programme Stage Semesters"
{
    DrillDownPageID = "ACA-Programme Semesters";
    LookupPageID = "ACA-Programme Semesters";

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme"."Code";
        }
        field(2; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[150])
        {
        }
        field(5; Current; Boolean)
        {
        }
        field(6; Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Units Registration Deadline"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Current Academic Year"; Boolean)
        {
            CalcFormula = Lookup("ACA-Academic Year".Current WHERE(Code = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Programme Code", Semester, Stage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

