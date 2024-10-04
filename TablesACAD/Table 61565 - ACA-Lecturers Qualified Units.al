table 61565 "ACA-Lecturers Qualified Units"
{

    fields
    {
        field(1; Lecturer; Code[30])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(3; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(4; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(5; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programmes));
        }
        field(6; Remarks; Text[200])
        {
        }
        field(7; "No. Of Hours"; Decimal)
        {
            Editable = false;
        }
        field(8; "No. Of Hours Contracted"; Decimal)
        {
        }
        field(9; "Available From"; Time)
        {
        }
        field(10; "Available To"; Time)
        {
        }
        field(11; "Time Table Hours"; Decimal)
        {
            CalcFormula = Sum("ACA-Time Table"."No. Of Hours" WHERE(Programme = FIELD(Programmes),
                                                                     Stage = FIELD(Stage),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Minimum Contracted"; Decimal)
        {
        }
        field(13; Class; Code[20])
        {
            TableRelation = "ACA-Course Classes".Code WHERE(Programmes = FIELD(Programmes),
                                                             Stage = FIELD(Stage));
        }
        field(14; "Unit Class"; Code[20])
        {
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programmes),
                                                            Stage = FIELD(Stage),
                                                            Unit = FIELD(Unit));
        }
        field(15; "Full Time/Part Time"; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time","Part Time";
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, Unit, Semester, Lecturer)
        {
        }
    }

    fieldgroups
    {
    }
}

