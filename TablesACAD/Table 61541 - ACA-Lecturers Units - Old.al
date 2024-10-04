table 61541 "ACA-Lecturers Units - Old"
{
    DrillDownPageID = 67038;
    LookupPageID = 67038;

    fields
    {
        field(1; Lecturer; Code[30])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(3; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(4; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme),
                                                           "Stage Code" = FIELD(Stage));

            trigger OnValidate()
            begin
                UnitSubj.RESET;
                UnitSubj.SETRANGE(UnitSubj.Code, Unit);
                UnitSubj.SETRANGE(UnitSubj."Programme Code", Programme);
                IF UnitSubj.FIND('-') THEN
                    Description := UnitSubj.Desription;
            end;
        }
        field(5; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD(Programme));
        }
        field(6; Remarks; Text[200])
        {
        }
        field(7; "No. Of Hours"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Amount := (Rate * "No. Of Hours");
            end;
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
            CalcFormula = Sum("ACA-Time Table"."No. Of Hours" WHERE(Programme = FIELD(Programme),
                                                                     Stage = FIELD(Stage),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Minimum Contracted"; Decimal)
        {
        }
        field(13; Class; Code[100])
        {
            TableRelation = "ACA-Course Classes".Code WHERE(Programmes = FIELD(Programme),
                                                             Stage = FIELD(Stage));
        }
        field(14; "Unit Class"; Code[20])
        {
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programme),
                                                            Stage = FIELD(Stage),
                                                            Unit = FIELD(Unit));
        }
        field(15; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Weekend,Evening';
            OptionMembers = "Full Time","Part Time",Weekend,Evening;
        }
        field(16; Allocation; Decimal)
        {
            CalcFormula = Sum("ACA-Time Table"."No. Of Hours" WHERE(Programme = FIELD(Programme),
                                                                     Stage = FIELD(Stage),
                                                                     Unit = FIELD(Unit),
                                                                     Semester = FIELD(Semester),
                                                                     "Unit Class" = FIELD("Unit Class")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; Description; Text[100])
        {
        }
        field(18; Rate; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := (Rate * "No. Of Hours");
            end;
        }
        field(19; "Credit hours"; Decimal)
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."No. Units");
            FieldClass = FlowField;
        }
        field(20; "Lect. Hrs"; Decimal)
        {
        }
        field(21; "Pract. Hrs"; Decimal)
        {
        }
        field(22; "Tut. Hrs"; Decimal)
        {
        }
        field(23; "Class Type"; Option)
        {
            OptionCaption = 'SSP,JAB,SSP & JAB';
            OptionMembers = SSP,JAB,"SSP & JAB";
        }
        field(24; "Unit Students Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Semester = FIELD(Semester),
                                                           Programme = FIELD(Programme),
                                                           Stage = FIELD(Stage),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(25; "Unit Results Count"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Semester = FIELD(Semester),
                                                           Programme = FIELD(Programme),
                                                           Stage = FIELD(Stage),
                                                           Unit = FIELD(Unit),
                                                           "Final Score" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(26; Claimed; Boolean)
        {
        }
        field(27; "Claimed Amount"; Decimal)
        {
        }
        field(28; "Claimed Date"; Date)
        {
        }
        field(29; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
        field(30; "Class Size"; Decimal)
        {
        }
        field(31; Posted; Boolean)
        {
        }
        field(32; "Posted By"; Code[30])
        {
        }
        field(33; "Posted On"; Date)
        {
        }
        field(34; Amount; Decimal)
        {
        }
        field(35; "Claim to pay"; Boolean)
        {
        }
        field(36; "CATs Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Exams Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Angagement Terms"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full-Time,Internal Part-Timer,External Part-Timer';
            OptionMembers = " ","Full-Time","Internal Part-Timer","External Part-Timer";
        }
        field(39; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Marks Submitted"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Programmes = FIELD(Programme),
                                                          Semester = FIELD(Semester),
                                                          Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(41; "Registered Students"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE(Semester = FIELD(Semester),
                                                           Unit = FIELD(Unit),
                                                           Reversed = FILTER(false)));
            FieldClass = FlowField;
        }
        field(45; Approved; Boolean)
        {
            CalcFormula = Lookup("ACA-Course Registration".Reversed WHERE(Programmes = FIELD(Programme),
                                                                           Semester = FIELD(Semester)));

            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Programme, Stage, Unit, Semester, Lecturer)
        {
        }
        key(Key2; Lecturer)
        {
        }
        key(Key3; Unit)
        {
        }
        key(Key4; Semester)
        {
        }
    }

    fieldgroups
    {
    }

    var
        UnitSubj: Record "ACA-Units/Subjects";
}

