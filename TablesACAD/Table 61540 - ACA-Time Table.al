table 61540 "ACA-Time Table"
{

    fields
    {
        field(1; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(3; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(4; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programme));
        }
        field(5; Period; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Lessons".Code;
        }
        field(6; "Day of Week"; Code[20])
        {
            TableRelation = "ACA-Day Of Week".Day;
        }
        field(7; "Day Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Day Of Week".Day;
        }
        field(8; "Lecture Room"; Code[10])
        {
            TableRelation = IF ("Room Type" = CONST(Room)) "ACA-Lecture Rooms".Code
            ELSE
            IF ("Room Type" = CONST(Labs)) "ACA-Lecture Rooms Labs".Code;
        }
        field(9; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; Class; Code[100])
        {
            NotBlank = false;
            TableRelation = "ACA-Course Classes".Code WHERE(Programmes = FIELD(Programme),
                                                             Stage = FIELD(Stage));
        }
        field(11; "No. Of Hours"; Decimal)
        {
        }
        field(12; Lecturer; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(13; "Unit Class"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programme),
                                                            Stage = FIELD(Stage),
                                                            Unit = FIELD(Unit));
        }
        field(14; Exam; Code[20])
        {
            TableRelation = "ACA-Exams".Code WHERE("Programme Code" = FIELD(Programme),
                                                  "Stage Code" = FIELD(Stage),
                                                  Semester = FIELD(Semester));
        }
        field(15; "Exam Date"; Text[30])
        {
        }
        field(16; Released; Boolean)
        {
        }
        field(17; Session; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time","Part Time";
        }
        field(18; Department; Code[20])
        {
        }
        field(19; "Programme Option"; Code[20])
        {
        }
        field(20; "Room Type"; Option)
        {
            OptionCaption = 'Room,Labs';
            OptionMembers = Room,Labs;
        }
        field(21; "Campus Code"; Code[20])
        {
        }
        field(50050; "Unit Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Programme = FIELD(Programme),
                                                        Stage = FIELD(Stage),
                                                        "Day of Week" = FIELD("Day of Week"),
                                                        Period = FIELD(Period),
                                                        Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50051; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(50052; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50053; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50055; "Lesson Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lessons".Code;
        }
        field(50056; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
                                                           "Stage Code" = FIELD(Stage));
        }
        field(50057; "Room Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Programme = FIELD("Programme Filter"),
                                                        Stage = FIELD("Stage Filter"),
                                                        "Date Filter" = FIELD("Date Filter"),
                                                        Period = FIELD("Lesson Filter"),
                                                        "Lecture Room" = FIELD("Room Filter")));
            FieldClass = FlowField;
        }
        field(50058; "Room Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50059; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50060; "Lecturer Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Programme = FIELD("Programme Filter"),
                                                        Stage = FIELD("Stage Filter"),
                                                        "Date Filter" = FIELD("Date Filter"),
                                                        Period = FIELD("Lesson Filter"),
                                                        Lecturer = FIELD("Lecturer Filter")));
            FieldClass = FlowField;
        }
        field(50061; Auto; Boolean)
        {
        }
        field(50062; "Unit Week Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Programme = FIELD(Programme),
                                                        Stage = FIELD(Stage),
                                                        Unit = FIELD(Unit),
                                                        Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50063; "Programme Lk"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Programme Code" WHERE(Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50064; "Stage Lk"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Stage Code" WHERE(Code = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50065; DPTNM; Text[250])
        {
        }
        field(50066; progname; Text[250])
        {
        }
        field(50067; unitNm; Text[250])
        {
        }
        field(50068; LecturerNM; Text[100])
        {
        }
        field(50069; semNM; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Programme, Stage, Unit, Semester, Period, "Day of Week", "Lecture Room", Class, "Unit Class", Exam, Released)
        {
            SumIndexFields = "No. Of Hours";
        }
    }

    fieldgroups
    {
    }
}

