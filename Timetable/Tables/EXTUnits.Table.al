/// <summary>
/// Table EXT-Units (ID 74554).
/// </summary>
table 74554 "EXT-Units"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Weighting Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Weight Lesson Categories"."Category Code" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester));
        }
        field(6; "Unit Name"; Text[150])
        {
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD("Programme Code"),
                                                                      Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(7; Timetabled; Boolean)
        {
            CalcFormula = Exist("EXT-Timetable FInal Collector" WHERE(Unit = FIELD("Unit Code"),
                                                                       Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Programme Code", "Unit Code", "Weighting Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

