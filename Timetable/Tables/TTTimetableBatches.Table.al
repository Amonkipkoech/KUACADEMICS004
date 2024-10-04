table 74505 "TT-Timetable Batches"
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
            CalcFormula = Lookup("ACA-Semesters"."Current Semester" WHERE(Code = FIELD(Semester)));
            FieldClass = FlowField;
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

