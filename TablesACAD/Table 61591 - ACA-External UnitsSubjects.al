table 61591 "ACA-External Units/Subjects"
{
    DrillDownPageID = 68784;
    LookupPageID = 68784;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programmes),
                                                           "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                Units.RESET;
                Units.SETRANGE(Units."Programme Code", Programmes);
                Units.SETRANGE(Units."Stage Code", Stage);
                Units.SETRANGE(Units.Code, Code);
                IF Units.FIND('-') THEN BEGIN
                    Desription := Units.Desription;
                    "No. Units" := Units."No. Units";
                    "Unit Type" := "Unit Type"::Elective;

                END;
            end;
        }
        field(4; Desription; Text[150])
        {
        }
        field(5; "Credit Hours"; Decimal)
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COURSE'));
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(11; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(12; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(13; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(14; "Lecture Room Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lecture Rooms".Code;
        }
        field(15; "Total Income"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE(Programme = FIELD("Programme Code"),
                                                                     Stage = FIELD("Stage Code"),
                                                                     Unit = FIELD(Code),
                                                                     Semester = FIELD("Semester Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Students Registered"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Programme = FIELD("Programme Code"),
                                                           Stage = FIELD("Stage Code"),
                                                           Unit = FIELD(Code),
                                                           Semester = FIELD("Semester Filter"),
                                                           Taken = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Unit Type"; Option)
        {
            OptionCaption = 'Core,Elective,Required';
            OptionMembers = Core,Elective,Required;
        }
        field(18; "Class Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Course Classes".Code WHERE(Programmes = FIELD("Programme Filter"),
                                                             Stage = FIELD("Stage Filter"));
        }
        field(19; "Student Type"; Option)
        {
            OptionCaption = ' ,Full Time,Part Time,Distance Learning';
            OptionMembers = " ","Full Time","Part Time","Distance Learning";
        }
        field(20; "Day Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Day Of Week".Day;
        }
        field(21; "Unit Class Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD("Programme Code"),
                                                            Stage = FIELD("Stage Code"));
        }
        field(22; Allocation; Decimal)
        {
            CalcFormula = Sum("ACA-Time Table"."No. Of Hours" WHERE(Programme = FIELD("Programme Code"),
                                                                     Stage = FIELD("Stage Code"),
                                                                     Unit = FIELD(Code),
                                                                     "Day of Week" = FIELD("Day Filter"),
                                                                     Period = FIELD("Lesson Filter")));
            FieldClass = FlowField;
        }
        field(23; "Exam Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                  "Stage Code" = FIELD("Stage Filter"),
                                                  Semester = FIELD("Semester Filter"));
        }
        field(24; "Exam Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(25; Tested; Boolean)
        {
        }
        field(50; Prerequisite; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(51; "Lesson Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lessons".Code;
        }
        field(52; "Common Unit"; Boolean)
        {
        }
        field(53; "No. Units"; Decimal)
        {
        }
        field(54; Programmes; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(55; Stage; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
    }

    keys
    {
        key(Key1; Programmes, Stage, "Programme Code", "Stage Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Units: Record "ACA-Units/Subjects";
}

