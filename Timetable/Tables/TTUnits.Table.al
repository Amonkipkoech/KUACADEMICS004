/// <summary>
/// Table TT-Units (ID 74517).
/// </summary>
table 74517 "TT-Units"
{
    LookupPageId = "TT-Timetable Units";
    DrillDownPageId = "TT-Timetable Units";

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
            TableRelation = "ACA-Semester Units On Offer"."Unit Code";
            trigger OnValidate()
            var
                subj: Record "ACA-Semester Units On Offer";
            begin
                subj.Reset();
                subj.SetRange("Unit Code", "Unit Code");
                if subj.Find('-') then begin
                    "Unit Name" := subj.Desription;
                    "Unit Base Code" := subj."Unit Base Code"
                end;

            end;
        }
        field(5; "Weighting Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TT-Weight Lesson Categories"."Category Code" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester));
        }
        field(6; "Unit Name"; Text[150])
        {
            CalcFormula = Lookup("ACA-Semester Units On Offer".Desription WHERE("Programme Code" = FIELD("Programme Code"),
                                                                      "Unit Code" = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(7; "No. of Singles"; Integer)
        {
            CalcFormula = Count("TT-Timetable Collector Singles" WHERE(Programme = FIELD("Programme Code"),
                                                                        Unit = FIELD("Unit Code"),
                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(8; "No. of Doubles"; Integer)
        {
            CalcFormula = Count("TT-Timetable Collector Doubles" WHERE(Programme = FIELD("Programme Code"),
                                                                        Unit = FIELD("Unit Code"),
                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(9; "No. of Tripples"; Integer)
        {
            CalcFormula = Count("TT-Timetable Collector Tripple" WHERE(Programme = FIELD("Programme Code"),
                                                                        Unit = FIELD("Unit Code"),
                                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(10; "Unit Base Code"; code[20])
        {

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

