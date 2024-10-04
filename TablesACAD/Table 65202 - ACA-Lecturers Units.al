table 65202 "ACA-Lecturers Units"
{
    DrillDownPageID = 67038;
    LookupPageID = 67038;

    fields
    {
        field(1; Lecturer; Code[30])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                IF HRMEmployeeC.GET(Lecturer) THEN BEGIN

                END;
            end;
        }
        field(2; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;

            trigger OnValidate()
            begin
                //IF "Engagement Terms"="Engagement Terms"::" " THEN ERROR('Specify the Terms of Anagement!');
                ACAProgramme.RESET;
                IF ACAProgramme.GET(Programme) THEN
                    "Campus Code" := ACAProgramme."Campus Code";
            end;
        }
        field(3; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(4; Unit; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme));

            trigger OnValidate()
            begin
                UnitSubj.RESET;
                UnitSubj.SETRANGE(UnitSubj.Code, Unit);
                UnitSubj.SETRANGE(UnitSubj."Programme Code", Programme);
                IF UnitSubj.FIND('-') THEN
                    Description := UnitSubj.Desription;
                // LectLoadCentralSetup.RESET;
                // IF LectLoadCentralSetup.FIND('-') THEN BEGIN
                //     Rec.Rate := LectLoadCentralSetup."Part-Time Charge";
                Rec.VALIDATE(Rec.Rate);

            END;
            //end;
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
            Editable = true;

            trigger OnValidate()
            begin
                "Unit Cost" := "No. Of Hours" * Rate;
                "Claimed Amount" := "No. Of Hours" * Rate;
            end;
        }
        field(8; "No. Of Hours Contracted"; Decimal)
        {
        }
        field(9; "Available From"; Date)
        {
        }
        field(10; "Available To"; Date)
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
            TableRelation = "ACA-Course Classes".Code;
        }
        field(14; "Unit Class"; Code[100])
        {
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD(Programme),
                                                            Stage = FIELD(Stage),
                                                            Unit = FIELD(Unit));
        }
        field(15; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Weekend,Evening,School Based';
            OptionMembers = "Full Time","Part Time",Weekend,Evening,"School Based";
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
                "Unit Cost" := "No. Of Hours" * Rate;
                "Claimed Amount" := "No. Of Hours" * Rate;
            end;
        }
        field(19; "Credit hours"; Decimal)
        {
            CalcFormula = Sum("ACA-Units/Subjects"."No. Units");
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
        field(29; "Campus Code"; Code[100])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
        field(30; "Class Size"; Decimal)
        {
        }
        field(31; Posted; Boolean)
        {
        }
        field(32; "Posted By"; Code[100])
        {
        }
        field(33; "Posted On"; Date)
        {
        }
        field(34; Amount; Decimal)
        {
        }
        field(35; Approved; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // LectLoadPermissions.RESET;
                // IF LectLoadPermissions.GET(USERID) THEN BEGIN
                //  // LectLoadPermissions.TESTFIELD("Can Approve Units");
                //END;
            end;
        }
        field(36; "CATs Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Exams Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Engagement Terms"; Option)
        {
            //DataClassification = ToBeClassified;
            //OptionCaption = ' ,Full-Time,Internal Part-Timer,External Part-Timer';
            OptionMembers = " ","Full-Time","Part Time"
,"Internal Part-Timer","External Part-Timer";

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
            CalcFormula = Count("ACA-Student Units" WHERE(Semester = FIELD(Semester), Unit = FIELD(Unit), Stream = field(Stream), "Campus Code" = field("Campus Code"),ModeOfStudy = field(ModeofStudy)));
            FieldClass = FlowField;
        }
        field(42; "Claim to pay"; Boolean)
        {
        }
        field(43; "Group Type"; Option)
        {
            OptionCaption = 'Regular,Weekend,Evening,ODEL';
            OptionMembers = Regular,Weekend,Evening,ODEL;
        }
        field(44; Day; code[20])
        {
            TableRelation = "TT-Days"."Day Code";
        }
        field(45; TimeSlot; code[20])
        {
            TableRelation = "TT-Daily Lessons"."Lesson Code";
        }
        field(46; ModeOfStudy; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
        field(47; Stream; Text[100])
        {

        }
        field(48; unique; code[20])
        {
            CalcFormula = lookup("ACA-Units Offered"."Unit Base Code" where(Lecturer = field(Lecturer), Day = field(Day), TimeSlot = field(TimeSlot)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Programme, Stage, "Campus Code", "Group Type", Class, Lecturer, Unit, Semester, Description, TimeSlot, Day)
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
        key(Key5; Description)
        {
        }
    }

    fieldgroups
    {
    }

    var
        UnitSubj: Record 61517;
        //LectLoadCentralSetup: Record 65204;
        //LectLoadPermissions: Record 65207;
        HRMEmployeeC: Record "HRM-Employee (D)";
        ACAProgramme: Record 61511;
}

