table 61548 "ACA-Exam Results"
{
    DrillDownPageID = "Exam Res. List";
    LookupPageID = "Exam Res. List";

    fields
    {
        field(1; Programmes; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Stage; Code[50])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; Unit; Code[50])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code;
        }
        field(4; Semester; Code[50])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters";
        }
        field(5; Score; Decimal)
        {
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            var
                ACAExamResults: Record "ACA-Exam Results";
                ACAExamGraddingSetup: Record "ACA-Exam Gradding Setup";
            begin
                ACASemesters.RESET;
                ACASemesters.SETRANGE(Code, Semester);
                IF ACASemesters.FIND('-') THEN BEGIN
                    IF ACASemesters."Academic Year" <> '' THEN BEGIN
                        Rec."Academic Year" := ACASemesters."Academic Year";
                    END;
                END;
                // // IF ExamType='FINAL EXAM' THEN BEGIN
                // //  ExamType:='EXAM';
                // //  Exam:='EXAM';
                // //  Rec.RENAME("Student No.",Programme,Stage,Unit,Semester,ExamType,"Reg. Transaction ID","Entry No");
                // //  END;

                ACAExamResults.RESET;
                ACAExamResults.SETRANGE("Student No.", Rec."Student No.");
                ACAExamResults.SETRANGE(Unit, Unit);
                ACAExamResults.SETRANGE(Stage, Stage);
                ACAExamResults.SETRANGE(Semester, Semester);
                //IF ACAExamResults.FIND('-') THEN REPORT.RUN(70100,FALSE,FALSE,ACAExamResults);

                //Check if the Unit is registered. If Not, register
                //IF Programme='BSC ECOHIM' THEN
                //CourseRegANDUggnits("Student No.",Programme,Semester,"Academic Year",Unit,Stage);
                // // // // // Course_Reg.RESET;
                // // // // // Course_Reg.SETRANGE(Course_Reg."Student No.","Student No.");
                // // // // // Course_Reg.SETRANGE(Course_Reg.Programme,Programme);
                // // // // // Course_Reg.SETRANGE(Course_Reg.Semester,Semester);
                // // // // // //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                // // // // // Course_Reg.SETRANGE(Course_Reg.Stage,Stage);
                // // // // // IF Course_Reg.FIND('-') THEN BEGIN
                // // // // //  SETCURRENTKEY("Student No.",Programme,Stage,Unit,Semester,ExamType,"Reg. Transaction ID","Entry No");
                // // // // //  //IF NOT (ACAExamResults2.GET("Student No.",Programme,Stage,Unit,Semester,ExamType,Course_Reg."Reg. Transacton ID","Entry No")) THEN
                // // // // //  RENAME("Student No.",Programme,Stage,Unit,Semester,ExamType,Course_Reg."Reg. Transacton ID","Entry No");
                // // // // //
                // // // // // //stud_Units.reset;
                // // // // // //stud_Units.setrange();
                // // // // //
                // // // // // END;
                prog.RESET;
                prog.SETRANGE(Code, Programmes);
                IF NOT prog.FIND('-') THEN ERROR('Invalid Program!');
                IF prog."Exam Category" = '' THEN ERROR('Exam category is missing on the program!');
                CLEAR(GradeCategory);
                // // // GradeCategory:=prog."Exam Category";
                // // // UnitsRegister.RESET;
                // // // UnitsRegister.SETRANGE("Programme Code",Programme);
                // // // UnitsRegister.SETRANGE(Code,Rec.Unit);
                // // // IF UnitsRegister.FIND('-') THEN BEGIN
                // // //  IF UnitsRegister."Default Exam Category"<>'' THEN GradeCategory:=UnitsRegister."Default Exam Category";
                // // //  END;
                UnitsRegister.RESET;
                UnitsRegister.SETRANGE("Programme Code", Programmes);
                UnitsRegister.SETRANGE(Code, Unit);
                IF UnitsRegister.FIND('-') THEN BEGIN
                    //  IF UnitsRegister."Default Exam Category" <> '' THEN GradeCategory := UnitsRegister."Default Exam Category";
                END;

                prog.RESET;
                IF prog.GET(Programmes) THEN
                    IF GradeCategory = '' THEN
                        GradeCategory := prog."Exam Category";

                SExams.RESET;
                SExams.SETRANGE(SExams.Code, ExamType);
                SExams.SETRANGE(Category, GradeCategory);
                IF SExams.FIND('-') THEN BEGIN
                    IF Score > SExams."Max. Score" THEN
                        Score := (Score / 100) * 70;
                    //ERROR('Invalid Score, Check = Unit Code'+Unit+', Programme:'+Programme+', Student No.:'+"Student No."+', Acad year:'+"Academic Year"+', Sem:'+Semester+'. Mark entered By: '+"Lecturer Names");
                    IF Score > 0 THEN BEGIN
                        Percentage := (Score / SExams."Max. Score") * 100;
                        Contribution := Percentage * (SExams."% Contrib. Final Score" / 100);
                        //MESSAGE('%1',Contribution);
                        //CLEAR(GradeCategory);
                        // // prog.RESET;
                        // // IF prog.GET(Programme) THEN
                        // //  IF prog."Exam Category"='' THEN
                        // // GradeCategory:='DEFAULT'
                        // // ELSE GradeCategory:=prog."Exam Category";

                        // // UnitsRegister.RESET;
                        // // UnitsRegister.SETRANGE("Programme Code",Programme);
                        // // UnitsRegister.SETRANGE(Code,Rec.Unit);
                        // // IF UnitsRegister.FIND('-') THEN BEGIN
                        // //  IF UnitsRegister."Default Exam Category"<>'' THEN GradeCategory:=UnitsRegister."Default Exam Category";
                        // //  END;
                        // //
                        Gradings.RESET;
                        Gradings.SETRANGE(Gradings.Category, GradeCategory);
                        Gradings.SETFILTER("Lower Limit", '=%1|<%2', Score, Score);
                        Gradings.SETFILTER("Upper Limit", '=%1|>%2', Score, Score);
                        LastGrade := '';
                        LastScore := 0;
                        IF Gradings.FIND('-') THEN BEGIN
                            Grade := Gradings.Grade;
                        END;

                        //Clear other contributions if supplementary
                        IF SExams.Type = SExams.Type::Supplementary THEN BEGIN
                            EResults.RESET;
                            EResults.SETRANGE(EResults."Student No.", "Student No.");
                            EResults.SETRANGE(EResults."Reg. Transaction ID", "Reg. Transaction ID");
                            EResults.SETRANGE(EResults.Unit, Unit);
                            IF EResults.FIND('-') THEN BEGIN
                                REPEAT
                                    IF EResults.Exam <> Exam THEN BEGIN
                                        EResults.Contribution := 0;
                                        EResults.MODIFY;
                                    END;
                                UNTIL EResults.NEXT = 0;

                            END
                        END;

                    END ELSE BEGIN
                        Percentage := 0;
                        Contribution := 0;
                        Grade := '';
                    END;

                END;

                // // // IF ((Rec."Student No."='B106/0456G/17') AND (Rec.Unit='BEN 102')) THEN BEGIN
                // // //
                // // // Course_Reg.RESET;
                // // // END;
                Course_Reg.RESET;
                Course_Reg.SETRANGE(Course_Reg."Student No.", "Student No.");
                Course_Reg.SETRANGE(Course_Reg.Programmes, Programmes);
                Course_Reg.SETRANGE(Course_Reg.Semester, Semester);
                //Course_Reg.SETFILTER(Reversed, '%1', FALSE);
                //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                //Course_Reg.SETRANGE(Course_Reg.Stage,Stage);
                IF Course_Reg.FIND('-') THEN BEGIN

                    stud_Units.RESET;
                    stud_Units.SETRANGE(stud_Units.Programme, Course_Reg.Programmes);
                    //stud_Units.SETRANGE(stud_Units.Stage,Stage);
                    stud_Units.SETRANGE(stud_Units.Unit, Unit);
                    stud_Units.SETRANGE(stud_Units.Semester, Semester);
                    //stud_Units.SETRANGE(stud_Units."Reg. Transacton ID",Course_Reg."Reg. Transacton ID");
                    stud_Units.SETRANGE(stud_Units."Student No.", "Student No.");
                    stud_Units.SETRANGE(Reversed, FALSE);
                    IF stud_Units.FIND('-') THEN BEGIN

                        IF ACASemesters."Academic Year" <> '' THEN BEGIN
                            stud_Units."Academic Year" := ACASemesters."Academic Year";
                        END;
                        CLEAR(consPref);
                        stud_Units."Consolidated Mark Pref." := '';
                        stud_Units.CALCFIELDS(stud_Units."Total Score", stud_Units."CAT-1", stud_Units."CAT-2", stud_Units."CATs Marks", stud_Units."EXAMs Marks", stud_Units."EXAMs Marks Exists",
                        stud_Units."CATs Marks Exists");
                        stud_Units."Final Score" := stud_Units."Total Score";
                        stud_Units."Total Marks" := stud_Units."Total Score";
                        stud_Units.Grade := GetGrade(0, 0, stud_Units."Total Marks", Course_Reg.Programmes, Rec.Unit);
                        IF stud_Units.Taken = FALSE THEN
                            stud_Units.Taken := TRUE;
                        IF stud_Units.Grade = 'E' THEN
                            consPref := '^';
                        IF ((stud_Units."CATs Marks Exists") AND (stud_Units."EXAMs Marks Exists" = FALSE)) THEN
                            consPref := 'c'
                        ELSE
                            IF ((stud_Units."CATs Marks Exists" = FALSE) AND (stud_Units."EXAMs Marks Exists")) THEN
                                consPref := 'e'
                            //
                            ELSE
                                IF ((stud_Units."CATs Marks Exists" = FALSE) AND (stud_Units."EXAMs Marks Exists" = FALSE)) THEN
                                    consPref := 'x';
                        stud_Units."Consolidated Mark Pref." := consPref;
                        ACAUnitsSubjects.RESET;
                        ACAUnitsSubjects.SETRANGE("Programme Code", Programmes);
                        ACAUnitsSubjects.SETRANGE(Code, Unit);
                        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                            // IF ACAUnitsSubjects."Credit Hours"<>0 THEN BEGIN
                            // stud_Units.Units:=ACAUnitsSubjects."Credit Hours";
                            // stud_Units."Weighted Units":=ACAUnitsSubjects."Credit Hours"*stud_Units."Total Score";
                            // END ELSE IF ACAUnitsSubjects."No. Units">0 THEN BEGIN
                            //  stud_Units.Units:=ACAUnitsSubjects."No. Units";
                            //  stud_Units."Weighted Units":=ACAUnitsSubjects."No. Units"*stud_Units."Total Score";
                            //   END;
                            //     IF //ACAUnitsSubjects."No. Units" > 0 THEN BEGIN
                            //         stud_Units.CALCFIELDS(stud_Units."Total Score");
                            //         //stud_Units.Units := ACAUnitsSubjects."No. Units";
                            //         //stud_Units."Weighted Units" := ACAUnitsSubjects."No. Units" * stud_Units."Total Score";
                            //     END ELSE BEGIN
                            //         stud_Units.CALCFIELDS(stud_Units."Total Score");
                            //         stud_Units.Units := ACAUnitsSubjects."Credit Hours";
                            //         stud_Units."Weighted Units" := ACAUnitsSubjects."Credit Hours" * stud_Units."Total Score";
                            //     END;
                            // END;
                            // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                            // stud_Units."Academic Year":="Academic Year";
                            IF stud_Units.MODIFY THEN;

                        END ELSE BEGIN
                            Course_Reg2.RESET;
                            Course_Reg2.SETRANGE(Course_Reg2."Student No.", "Student No.");
                            Course_Reg2.SETRANGE(Course_Reg2.Programmes, Programmes);
                            Course_Reg2.SETRANGE(Course_Reg2.Semester, Semester);
                            //Course_Reg2.SETFILTER(Reversed, '%1', FALSE);
                            //Course_Reg2.SETRANGE(Course_Reg2.Stage,Stage);
                            IF Course_Reg2.FIND('-') THEN BEGIN
                                stud_Units.INIT;
                                stud_Units."Reg. Transacton ID" := Course_Reg2."Reg. Transacton ID";
                                stud_Units.Programme := Programmes;
                                stud_Units.Stage := Stage;
                                stud_Units.Unit := Unit;
                                stud_Units.Semester := Semester;
                                stud_Units."Student No." := "Student No.";
                                stud_Units."Academic Year" := "Academic Year";
                                IF stud_Units.INSERT THEN;

                                stud_Units.RESET;
                                stud_Units.SETRANGE(stud_Units.Programme, Course_Reg.Programmes);
                                //stud_Units.SETRANGE(stud_Units.Stage,Stage);
                                stud_Units.SETRANGE(stud_Units.Unit, Unit);
                                stud_Units.SETRANGE(stud_Units.Semester, Semester);
                                //stud_Units.SETRANGE(stud_Units."Reg. Transacton ID",Course_Reg."Reg. Transacton ID");
                                stud_Units.SETRANGE(stud_Units."Student No.", "Student No.");
                                stud_Units.SETRANGE(Reversed, FALSE);
                                IF stud_Units.FIND('-') THEN BEGIN
                                    CLEAR(consPref);
                                    stud_Units."Consolidated Mark Pref." := '';
                                    stud_Units.CALCFIELDS(stud_Units."Total Score", stud_Units."CAT-1", stud_Units."CAT-2", stud_Units."CATs Marks", stud_Units."EXAMs Marks", stud_Units."EXAMs Marks Exists",
                                    stud_Units."CATs Marks Exists");
                                    stud_Units."Final Score" := stud_Units."Total Score";
                                    stud_Units."Total Marks" := stud_Units."Total Score";
                                    stud_Units.Grade := GetGrade(0, 0, stud_Units."Total Marks", Course_Reg.Programmes, Rec.Unit);
                                    ACAExamGraddingSetup.RESET;
                                    ACAExamGraddingSetup.SETRANGE(Category, prog."Exam Category");
                                    ACAExamGraddingSetup.SETRANGE(Grade, stud_Units.Grade);
                                    IF ACAExamGraddingSetup.FIND('-') THEN
                                        stud_Units.Failed := ACAExamGraddingSetup.Failed;
                                    IF stud_Units.Taken = FALSE THEN
                                        stud_Units.Taken := TRUE;
                                    IF stud_Units.Failed THEN
                                        consPref := '^';
                                    IF ((stud_Units."CATs Marks Exists") AND (stud_Units."EXAMs Marks Exists" = FALSE)) THEN
                                        consPref := 'c'
                                    ELSE
                                        IF ((stud_Units."CATs Marks Exists" = FALSE) AND (stud_Units."EXAMs Marks Exists")) THEN
                                            consPref := 'e'
                                        ELSE
                                            IF ((stud_Units."CATs Marks Exists" = FALSE) AND (stud_Units."EXAMs Marks Exists" = FALSE)) THEN
                                                consPref := 'x';
                                    stud_Units."Consolidated Mark Pref." := consPref;
                                    ACAUnitsSubjects.RESET;
                                    ACAUnitsSubjects.SETRANGE("Programme Code", Programmes);
                                    ACAUnitsSubjects.SETRANGE(Code, Unit);
                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                        //      IF ACAUnitsSubjects."Credit Hours"<>0 THEN BEGIN
                                        //      stud_Units.Units:=ACAUnitsSubjects."Credit Hours";
                                        //      stud_Units."Weighted Units":=ACAUnitsSubjects."Credit Hours"*stud_Units."Total Score";
                                        //      END ELSE IF ACAUnitsSubjects."No. Units">0 THEN BEGIN
                                        //      stud_Units.Units:=ACAUnitsSubjects."No. Units";
                                        //      stud_Units."Weighted Units":=ACAUnitsSubjects."No. Units"*stud_Units."Total Score";
                                        //        END;
                                        //IF ACAUnitsSubjects."No. Units" > 0 THEN BEGIN
                                        stud_Units.CALCFIELDS(stud_Units."Total Score");
                                        // stud_Units.Units := ACAUnitsSubjects."No. Units";
                                        // stud_Units."Weighted Units" := ACAUnitsSubjects."No. Units" * stud_Units."Total Score";
                                    END ELSE BEGIN
                                        stud_Units.CALCFIELDS(stud_Units."Total Score");
                                        stud_Units.Units := ACAUnitsSubjects."Credit Hours";
                                        stud_Units."Weighted Units" := ACAUnitsSubjects."Credit Hours" * stud_Units."Total Score";
                                    END;
                                END;
                                // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                                // stud_Units."Academic Year":="Academic Year";
                                IF stud_Units.MODIFY THEN;

                            END;
                        END;

                    END;

                END;
            end;
        }
        field(6; Exam; Code[50])
        {
        }
        field(7; "Reg. Transaction ID"; Code[50])
        {
            TableRelation = "ACA-Student Units"."Reg. Transacton ID" WHERE("Reg. Transacton ID" = FIELD("Reg. Transaction ID"),
                                                                            "Student No." = FIELD("Student No."));
        }
        field(8; "Student No."; Code[30])
        {
            Editable = true;
            TableRelation = Customer."No.";
        }
        field(9; Grade; Code[50])
        {
            TableRelation = "ACA-Grading System".Grade WHERE("Programme Code" = FIELD(Programmes));
        }
        field(10; Percentage; Decimal)
        {
        }
        field(11; Contribution; Decimal)
        {
            Editable = true;
        }
        field(12; "No Registration"; Boolean)
        {
        }
        field(13; "System Created"; Boolean)
        {
        }
        field(15; "Re-Sit"; Boolean)
        {
            CalcFormula = Lookup("ACA-Student Units"."Supp Taken" WHERE("Student No." = FIELD("Student No."),
                                                                         Programme = FIELD(Programmes),
                                                                         Semester = FIELD(Semester),
                                                                         Stage = FIELD(Stage),
                                                                         Unit = FIELD(Unit),
                                                                         "Reg. Transacton ID" = FIELD("Reg. Transaction ID")));
            Description = 'FlowField From Students Units';
            FieldClass = FlowField;
        }
        field(16; "Re-Sited"; Boolean)
        {
            Description = 'Updated By Re-Sit FlowField to be used as key';
        }
        field(17; "Repeated Score"; Decimal)
        {
        }
        field(18; "Exam Category"; Code[50])
        {
        }
        field(19; ExamType; Code[50])
        {
        }
        field(20; "Admission No"; Code[50])
        {
        }
        field(21; SN; Boolean)
        {
        }
        field(22; Reported; Boolean)
        {
        }
        field(23; "Lecturer Names"; Text[250])
        {
        }
        field(24; UserID; Code[50])
        {
        }
        field(50001; "Original Score"; Decimal)
        {
        }
        field(50002; "Last Edited By"; Code[50])
        {
        }
        field(50003; "Last Edited On"; Date)
        {
        }
        field(50004; Submitted; Boolean)
        {
        }
        field(50005; "Submitted On"; Date)
        {
        }
        field(50006; "Submitted By"; Code[50])
        {
        }
        field(50007; Category; Code[50])
        {
        }
        field(50008; Department; Code[50])
        {
        }
        field(50009; "Original Contribution"; Decimal)
        {
        }
        field(50012; "Semester Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Results".Contribution WHERE("Student No." = FIELD("Student No."),
                                                                     Semester = FIELD(Semester),
                                                                     Unit = FIELD(Unit),
                                                                     Programmes = FIELD(Programmes)));
            FieldClass = FlowField;
        }
        field(50013; "Attachment Unit"; Boolean)
        {
            // CalcFormula = Lookup("ACA-Units/Subjects".Attachment WHERE("Programme Code" = FIELD(Programmes),
            //                                                           Code = FIELD(Unit)));
            // FieldClass = FlowField;
        }
        field(50014; "Re-Take"; Boolean)
        {
            CalcFormula = Lookup("ACA-Student Units"."Re-Take" WHERE("Reg. Transacton ID" = FIELD("Reg. Transaction ID"),
                                                                    "Student No." = FIELD("Student No."),
                                                                    Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50015; Cancelled; Boolean)
        {
        }
        field(50016; "Cancelled By"; Code[50])
        {
        }
        field(50017; "Cancelled Date"; Date)
        {
        }
        field(50018; "Academic Year"; Code[50])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50019; "Entry No"; Integer)
        {
        }
        field(50020; "GPA Points"; Decimal)
        {
        }
        field(50021; "Credit Hours"; Decimal)
        {
        }
        field(50022; "User Name"; Code[20])
        {
        }
        field(50023; "Edit Count"; Integer)
        {
        }
        field(50024; "Counted Occurances"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          ExamType = FIELD(ExamType),
                                                          Semester = FIELD(Semester),
                                                          Exam = FIELD(Exam)));
            FieldClass = FlowField;
        }
        field(50025; "Unit Registration Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Student No." = FIELD("Student No."),
                                                           Semester = FIELD(Semester),
                                                           Unit = FIELD(Unit)));
            FieldClass = FlowField;
        }
        field(50026; "Number of Occurances"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          "Student No." = FIELD("Student No."),
                                                          ExamType = FIELD(ExamType)));
            FieldClass = FlowField;
        }
        field(50027; "To Delete"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63020; Status; Option)
        {
            CalcFormula = Lookup(Customer.Status WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Transferred from MSN,Transferred to MSN,Resit';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,"Transferred from MSN","Transferred to MSN",Resit;
        }
        field(63021; "Count Exam Occurances"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Exam = FILTER('EXAM|MAIN EXAM|FINAL|FINAL EXAM|FINALEXAM|MAINEXAM')));
            FieldClass = FlowField;
        }
        field(63022; "Count CAT Occurances"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Exam = FILTER('CAT|CATS|ASSIGNMENT|ASSIGNMENTS')));
            FieldClass = FlowField;
        }
        field(63023; "Exam is Multiple"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Exam = FILTER('EXAM|MAIN EXAM|FINAL|FINAL EXAM|FINALEXAM|MAINEXAM')));
            //Count "Exam Occurances"=FILTER(>1)));
            FieldClass = FlowField;
        }
        field(63024; "CAT is Multiple"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          Exam = FILTER('CAT|CATS|ASSIGNMENT|ASSIGNMENTS')));
            //Count Exam Occurances=FILTER(>1)));
            FieldClass = FlowField;
        }
        field(63025; "Number of Resits"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          "Exam is Multiple" = FILTER(true),
                                                          "CAT is Multiple" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(63026; "Number of Repeats"; Integer)
        {
            CalcFormula = Count("ACA-Exam Results" WHERE(Unit = FIELD(Unit),
                                                          Programmes = FIELD(Programmes),
                                                          "Student No." = FIELD("Student No."),
                                                          "Exam is Multiple" = FILTER(true),
                                                          "CAT is Multiple" = FILTER(true),
                                                          Exam = FILTER('EXAM|MAIN EXAM|FINAL|FINAL EXAM|FINALEXAM|MAINEXAM')));
            FieldClass = FlowField;
        }
        field(63027; "CAT Cancelled"; Boolean)
        {
            CalcFormula = Exist("Aca-Result Cancelation Subject" WHERE("Student No." = FIELD("Student No."),
                                                                        "Semester Code" = FIELD(Semester),
                                                                        "Unit Code" = FIELD(Unit),
                                                                        "Exam Type" = FILTER("CAT Only"),
                                                                        Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(63028; "Exam Cancelled"; Boolean)
        {
            CalcFormula = Exist("Aca-Result Cancelation Subject" WHERE("Student No." = FIELD("Student No."),
                                                                        "Semester Code" = FIELD(Semester),
                                                                        "Unit Code" = FIELD(Unit),
                                                                        "Exam Type" = FILTER("Exam Only"),
                                                                        Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(63029; "Both Cancelled"; Boolean)
        {
            CalcFormula = Exist("Aca-Result Cancelation Subject" WHERE("Student No." = FIELD("Student No."),
                                                                        "Semester Code" = FIELD(Semester),
                                                                        "Unit Code" = FIELD(Unit),
                                                                        "Exam Type" = FILTER('CAT & Exam'),
                                                                        Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(63030; Correct; Boolean)
        {
            
        }
        field(63031; upload; Boolean)
        {
            
        }
        // field(63030; Duplicate; Integer)
        // {
        //     CalcFormula = count("ACA-Exam Results" where("Student No." = field("Student No."),
        //     Semester = const('JAN-APR23'),
        //     Unit = field(Unit)));
        //     FieldClass = FlowField;
        // }
    }

    keys
    {
        key(Key1; "Student No.", Programmes, Stage, Unit, Semester, ExamType, "Reg. Transaction ID", "Entry No")
        {
            SumIndexFields = Score, Contribution;
        }
        key(Key2; "Reg. Transaction ID", "Student No.", Programmes, Unit)
        {
            SumIndexFields = Score, Contribution;
        }
        key(Key3; "Student No.", Programmes, Stage, Unit, Semester, Exam, "Reg. Transaction ID", "Re-Sited")
        {
            SumIndexFields = Score, Contribution;
        }
        key(Key4; Score)
        {
        }
        key(Key5; Semester)
        {
        }
        key(Key6; Exam, Programmes, "Student No.", Unit, Semester, ExamType)
        {
            SumIndexFields = Score, Percentage, Contribution;
        }
        key(Key7; Exam, Programmes, "Student No.", Unit, Semester)
        {
            SumIndexFields = Score, Percentage, Contribution;
        }
        key(Key8; Programmes, "Student No.", Unit, Semester, ExamType)
        {
            SumIndexFields = Score, Percentage, Contribution;
        }
        key(Key9; Exam, Semester)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //  ERROR('Please note that modification of results is not allowed');
    end;

    trigger OnModify()
    begin
        // ERROR('Please note that modification of results is not allowed');
    end;

    var
        SExams: Record 61567;
        Gradings: Record 61599;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record 61599;
        EResults: Record 61548;
        Exams: Record 61567;
        Course_Reg: Record 61532;
        stud_Units: Record 61549;
        prog: Record 61511;
        ACAUnitsSubjects: Record 61517;
        Course_Reg2: Record 61532;
        consPref: Text[5];
        GradeCategory: Code[20];
        UnitsRegister: Record 61517;
        ACAExamResults2: Record 61548;
        ACASemesters: Record 61692;

    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; prog: Code[100]; UnitCode: Code[20]) xGrade: Text[100]
    var
        UnitsRR: Record 61517;
        UnitsCourses: Record 61517;
        ProgrammeRec: Record 61511;
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        GradeCategory: Code[50];
        Marks: Decimal;
    begin
        GradeCategory := '';

        CLEAR(Marks);
        UnitsCourses.RESET;
        UnitsCourses.SETRANGE("Programme Code", prog);
        UnitsCourses.SETRANGE(Code, UnitCode);
        IF UnitsCourses.FIND('-') THEN BEGIN
            // IF UnitsCourses."Default Exam Category"<>'' THEN GradeCategory:=UnitsCourses."Default Exam Category";
        END;

        ProgrammeRec.RESET;
        IF ProgrammeRec.GET(prog) THEN
            IF GradeCategory = '' THEN
                GradeCategory := ProgrammeRec."Exam Category";

        IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
        xGrade := '';
        IF CAT1 + CAT2 + FinalM > 0 THEN BEGIN
            Marks := CAT1 + CAT2 + FinalM;
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                REPEAT
                    LastScore := Gradings."Up to";
                    IF Marks < LastScore THEN BEGIN
                        IF ExitDo = FALSE THEN BEGIN
                            xGrade := Gradings.Grade;
                            IF Gradings.Failed = FALSE THEN
                                LastRemark := 'PASS'
                            ELSE
                                LastRemark := 'FAIL';
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN
            Grade := '';
            //Remarks:='Not Done';
        END;
        /*
        IF ((CAT1=0) AND (CAT2=0) AND (FinalM=0)) THEN xGrade:='?' ELSE
        //IF ((CAT1=0) OR (CAT2=0) OR (FinalM=0)) THEN xGrade:='!'
        */

    end;

    procedure CourseRegANDUggnits(StudNos: Code[50]; Progys: Code[50]; Semz: Code[50]; AcadYear: Code[50]; UnitzCode: Code[50]; stagez: Code[50])
    var
        RegTransID: Code[20];
        ACAUnitsSubjects: Record 61517;
        courseReg: Record 61532;
        //NoSeriesMgt: Codeunit 396;
        courseReg2: Record 61532;
        unitsReg: Record 61549;
        semesterz: Record 61692;
    begin
        IF AcadYear = '' THEN BEGIN
            semesterz.RESET;
            semesterz.SETRANGE(Code, Semz);
            IF semesterz.FIND('-') THEN BEGIN
                AcadYear := semesterz."Academic Year";
            END;
        END;
        CLEAR(RegTransID);
        courseReg.RESET;
        courseReg.SETRANGE(courseReg."Student No.", StudNos);
        courseReg.SETRANGE(courseReg.Programmes, Progys);
        courseReg.SETRANGE(courseReg.Semester, Semz);
        IF courseReg.FIND('-') THEN BEGIN
            // Create A Units Registration
            unitsReg.RESET;
            unitsReg.SETRANGE(unitsReg.Programme, Progys);
            //  unitsReg.SETRANGE(unitsReg.Stage,stagez);
            unitsReg.SETRANGE(unitsReg.Unit, UnitzCode);
            unitsReg.SETRANGE(unitsReg."Student No.", StudNos);
            unitsReg.SETRANGE(unitsReg.Semester, Semz);
            //unitsReg.SETRANGE(unitsReg."Academic Year",courseReg."Academic Year");
            IF NOT unitsReg.FIND('-') THEN BEGIN
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE("Programme Code", Progys);
                ACAUnitsSubjects.SETRANGE(Code, UnitzCode);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN

                    unitsReg.INIT;
                    unitsReg.Programme := Progys;
                    unitsReg.Stage := stagez;
                    unitsReg.Unit := UnitzCode;
                    unitsReg.Semester := Semz;
                    unitsReg.Units := ACAUnitsSubjects."Credit Hours";
                    unitsReg."Credit Hours" := ACAUnitsSubjects."Credit Hours";
                    unitsReg."Reg. Transacton ID" := courseReg."Reg. Transacton ID";
                    unitsReg."Student No." := StudNos;
                    unitsReg."Academic Year" := AcadYear;
                    unitsReg.Taken := TRUE;
                    IF unitsReg.INSERT THEN;
                END;
            END;
        END ELSE BEGIN
            // Create A course Registration
            //RegTransID:=NoSeriesMgt.GetNextNo('TRANS',0D,TRUE);
            courseReg.INIT;
            courseReg."Reg. Transacton ID" := RegTransID;
            courseReg.Programmes := Progys;
            courseReg."Student No." := StudNos;
            courseReg.Semester := Semz;
            courseReg."Register for" := courseReg."Register for"::Stage;
            courseReg.VALIDATE(Stage, stagez);
            //courseReg."Student Type":=courseReg."Student Type"::"Full Time";
            //courseReg.Posted:=TRUE;
            //
            //    courseReg2.RESET;
            //    courseReg2.SETRANGE(courseReg2."Student No.",StudNos);
            //    courseReg2.SETRANGE(courseReg2.Programme,Progys);
            //    IF courseReg2.FIND('-') THEN ELSE
            //    courseReg."Settlement Type":='SSP';
            courseReg."Registration Date" := TODAY;
            //courseReg."Admission No.":=StudNos;
            //courseReg."Academic Year":=AcadYear;
            //  courseReg.Session:= ExamBuff2.Intake;
            courseReg.INSERT;

            //Create A units Registration
            unitsReg.RESET;
            unitsReg.SETRANGE(unitsReg.Programme, Progys);
            // unitsReg.SETRANGE(unitsReg.Stage,stagez);
            unitsReg.SETRANGE(unitsReg.Unit, UnitzCode);
            unitsReg.SETRANGE(unitsReg."Student No.", StudNos);
            unitsReg.SETRANGE(unitsReg.Semester, Semz);
            //unitsReg.SETRANGE(unitsReg."Academic Year",courseReg."Academic Year");
            IF NOT unitsReg.FIND('-') THEN BEGIN
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE("Programme Code", Progys);
                ACAUnitsSubjects.SETRANGE(Code, UnitzCode);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                    unitsReg.INIT;
                    unitsReg.Programme := Progys;
                    unitsReg.VALIDATE(Stage, stagez);
                    unitsReg.Unit := UnitzCode;
                    unitsReg.Semester := Semz;
                    unitsReg.Units := ACAUnitsSubjects."Credit Hours";
                    unitsReg."Credit Hours" := ACAUnitsSubjects."Credit Hours";
                    unitsReg."Reg. Transacton ID" := RegTransID;
                    unitsReg."Student No." := StudNos;
                    //unitsReg."Academic Year":=courseReg."Academic Year";
                    unitsReg.Taken := TRUE;
                    IF unitsReg.INSERT THEN;
                END;
            END;

        END;
        //
    end;
}

