table 70084 "ACA-Exam Results-old"
{

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
            begin
                // update trans_Reg
                Course_Reg.RESET;
                Course_Reg.SETRANGE(Course_Reg."Student No.", "Student No.");
                Course_Reg.SETRANGE(Course_Reg.Programmes, Programmes);
                Course_Reg.SETRANGE(Course_Reg.Semester, Semester);
                //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                Course_Reg.SETRANGE(Course_Reg.Stage, Stage);
                IF Course_Reg.FIND('-') THEN BEGIN
                    SETCURRENTKEY("Student No.", Programmes, Stage, Unit, Semester, ExamType, "Reg. Transaction ID");
                    RENAME("Student No.", Programmes, Stage, Unit, Semester, ExamType, Course_Reg."Reg. Transacton ID");

                    //stud_Units.reset;
                    //stud_Units.setrange();

                END;

                SExams.RESET;
                SExams.SETRANGE(SExams.Code, ExamType);
                IF SExams.FIND('-') THEN BEGIN
                    IF Score > SExams."Max. Score" THEN
                        ERROR('Score can not be greater than the maximum score.');
                    IF Score > 0 THEN BEGIN
                        Percentage := (Score / SExams."Max. Score") * 100;
                        Contribution := Percentage * (SExams."% Contrib. Final Score" / 100);
                        Gradings.RESET;
                        prog.RESET;
                        IF prog.GET(Programmes) THEN
                            IF prog."Exam Category" = '' THEN
                                Gradings.SETRANGE(Gradings.Category, 'DEFAULT')
                            ELSE
                                Gradings.SETRANGE(Gradings.Category, prog."Exam Category");
                        LastGrade := '';
                        LastScore := 0;
                        IF Gradings.FIND('-') THEN BEGIN
                            ExitDo := FALSE;
                            REPEAT
                                IF Percentage < LastScore THEN BEGIN
                                    IF ExitDo = FALSE THEN BEGIN
                                        ExitDo := TRUE;
                                        Grade := LastGrade;
                                    END;
                                END;
                                LastGrade := Gradings.Grade;
                                LastScore := Gradings."Up to";

                            UNTIL Gradings.NEXT = 0;

                            IF ExitDo = FALSE THEN BEGIN
                                Gradings2.RESET;
                                Gradings2.SETRANGE(Gradings2.Category, "Exam Category");
                                IF Gradings2.FIND('+') THEN
                                    Grade := Gradings2.Grade

                            END;


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


                Course_Reg.RESET;
                Course_Reg.SETRANGE(Course_Reg."Student No.", "Student No.");
                Course_Reg.SETRANGE(Course_Reg.Programmes, Programmes);
                Course_Reg.SETRANGE(Course_Reg.Semester, Semester);
                Course_Reg.SETRANGE(Course_Reg."Academic Year", "Academic Year");
                Course_Reg.SETRANGE(Course_Reg.Stage, Stage);
                IF Course_Reg.FIND('-') THEN BEGIN

                    stud_Units.RESET;
                    stud_Units.SETRANGE(stud_Units.Programme, Course_Reg.Programmes);
                    stud_Units.SETRANGE(stud_Units.Stage, Stage);
                    stud_Units.SETRANGE(stud_Units.Unit, Unit);
                    stud_Units.SETRANGE(stud_Units.Semester, Semester);
                    stud_Units.SETRANGE(stud_Units."Reg. Transacton ID", Course_Reg."Reg. Transacton ID");
                    stud_Units.SETRANGE(stud_Units."Student No.", "Student No.");
                    IF stud_Units.FIND('-') THEN BEGIN
                        stud_Units.CALCFIELDS(stud_Units."Total Score", stud_Units."CAT-1", stud_Units."CAT-2", stud_Units."CATs Marks", stud_Units."EXAMs Marks");
                        stud_Units."Final Score" := stud_Units."Total Score";
                        stud_Units."Total Marks" := stud_Units."Total Score";
                        stud_Units.Grade := GetGrade(stud_Units."CAT-1", stud_Units."CAT-2", stud_Units."EXAMs Marks", Course_Reg.Programmes);
                        // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                        // stud_Units."Academic Year":="Academic Year";
                        stud_Units.MODIFY;

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
            Editable = false;
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
            CalcFormula = Lookup("ACA-Units/Subjects".Attachment WHERE("Programme Code" = FIELD(Programmes),
                                                                      Code = FIELD(Unit)));
            FieldClass = FlowField;
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
        field(50022; "Edit Count"; Integer)
        {
        }
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
        ERROR('Please note that modification of results is not allowed');
    end;

    var
        SExams: Record 61567;
        Gradings: Record 61569;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record 61569;
        EResults: Record 61548;
        Exams: Record 61567;
        Course_Reg: Record 61532;
        stud_Units: Record 61549;
        prog: Record 61511;

    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; prog: Code[100]) xGrade: Text[100]
    var
        UnitsRR: Record 61517;
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
        ProgrammeRec.RESET;
        IF ProgrammeRec.GET(prog) THEN
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

        IF ((CAT1 = 0) AND (CAT2 = 0) AND (FinalM = 0)) THEN
            xGrade := '?' ELSE
            IF ((CAT1 = 0) OR (CAT2 = 0) OR (FinalM = 0)) THEN xGrade := '!'
    end;
}

