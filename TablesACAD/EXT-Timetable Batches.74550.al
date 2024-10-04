table 74550 "EXT-Timetable Batches"
{

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
            TableRelation = "ACA-Semesters".Code WHERE("Academic Year" = FIELD("Academic Year"));
        }
        field(3; Current; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Semesters"."Current Semester" WHERE(Code = FIELD(Semester)));

        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Include Saturday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Include Sunday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Include Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

