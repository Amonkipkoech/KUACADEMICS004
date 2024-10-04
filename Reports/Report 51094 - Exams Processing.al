report 51094 "Exams Processing"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false),
                                      Status = FILTER(Deceased | Registration | Current));
            RequestFilterFields = "Student No.", Programmes, Stage, Semester;
            column(StudNo; "ACA-Course Registration"."Student No.")
            {
            }
            column(Prog; "ACA-Course Registration".Programmes)
            {
            }
            column(Sem; "ACA-Course Registration".Semester)
            {
            }
            column(Stag; "ACA-Course Registration".Stage)
            {
            }
            column(CumSc; "ACA-Course Registration"."Cumm Score")
            {
            }
            column(CurrSem; "ACA-Course Registration"."Current Cumm Score")
            {
            }
            column(sName; sName)
            {
            }
            dataitem(StudUz; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               Semester = FIELD(Semester);
                column(Unit; StudUz.Unit)
                {
                }
                column(Desc; StudUz.Description)
                {
                }
                column(Score; StudUz."Total Score")
                {
                }
                column(Final; StudUz."Final Score")
                {
                }
                column(Grade; StudUz.Grade)
                {
                }
                column(Status; StudUz."Exam Status")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //ExamProcess.UpdateStudentUvbnits("Student Units"."Student No.","Student Units".Programme,"Student Units".Semester,"Student Units".Stage);
                    CLEAR(TotMarks);
                    // IF ((StudUz."Student No."='MS/00004/015') AND (StudUz.Unit='UCI 410')) THEN
                    // CLEAR(TotMarks);
                    progress.UPDATE(1, "ACA-Course Registration"."Student No.");
                    progress.UPDATE(2, StudUz.Programme);
                    progress.UPDATE(3, StudUz.Unit);
                    StudUz.VALIDATE(Unit);
                    // EResults.RESET;
                    // EResults.SETFILTER(EResults."Student No.","Student Units"."Student No.");
                    // EResults.SETFILTER(EResults.Programme,"Student Units".Programme);
                    // EResults.SETFILTER(EResults.Unit,"Student Units".Unit);
                    //  EResults.SETFILTER(EResults.Semester,"Student Units".Semester);
                    //  EResults.SETFILTER(EResults."Reg. Transaction ID","Student Units"."Reg. Transacton ID");
                    // IF EResults.FIND('-') THEN BEGIN
                    // REPEAT
                    // BEGIN
                    //    EResults.VALIDATE(EResults.Score);
                    // EResults.CALCFIELDS(EResults.Stager);
                    // EResults.SETCURRENTKEY(EResults."Student No.",EResults.Programme,EResults.Stage,EResults.Unit,
                    // EResults.Semester,EResults.Exam,EResults."Reg. Transaction ID",EResults."Re-Sited",
                    //  EResults."Entry No");
                    //  IF EResults.Stage<>EResults.Stager THEN BEGIN
                    // EResults.Stage:=EResults.Stager;
                    //   EResults.RENAME(EResults."Student No.",EResults.Programme,EResults.Stager,EResults.Unit,
                    //  EResults.Semester,EResults.Exam,EResults."Reg. Transaction ID",EResults."Re-Sited",
                    //  EResults."Entry No");

                    // EResults.MODIFY;
                    // END;
                    // TotMarks:=TotMarks+EResults.Contribution;

                    // END;
                    // UNTIL EResults.NEXT=0;
                    // END;
                    // ERROR(FORMAT(TotMarks));
                    CALCFIELDS(StudUz."Total Score");

                    StudUz."Final Score" := StudUz."Total Score";
                    StudUz."Total Marks" := StudUz."Total Score";
                    StudUz.MODIFY;
                    TotMarks := StudUz."Total Score";

                    //CALCFIELDS("Student Units"."Credited Hours",
                    //"Student Units"."CATs Marks","Student Units"."EXAMs Marks");
                    //IF   "Student Units"."Credited Hours"<>0 THEN
                    // "Student Units"."Credit Hours":="Student Units"."Credited Hours";
                    IF UnitsR.GET(StudUz.Programme, StudUz.Stage, StudUz.Unit) THEN //BEGIN
                        StudUz."No. Of Units" := UnitsR."Credit Hours";
                    //"Student Units"."Unit Type":=UnitsR."Unit Type";
                    //END;
                    "Units/Subj".RESET;
                    "Units/Subj".SETRANGE("Units/Subj"."Programme Code", StudUz.Programme);
                    "Units/Subj".SETRANGE("Units/Subj".Code, StudUz.Unit);
                    "Units/Subj".SETRANGE("Units/Subj"."Stage Code", StudUz.Stage);
                    // "Units/Subj".SETRANGE("Units/Subj".Old,FALSE);
                    IF "Units/Subj".FIND('-') THEN
                        StudUz.Description := "Units/Subj".Desription;
                    StudUz."Credit Hours" := "Units/Subj"."Credit Hours";
                    //  IF StudUz.Unit='MNS 103' THEN
                    //  StudUz.CALCFIELDS(StudUz."Total Score");
                    StudUz.CALCFIELDS(StudUz."Total Score");
                    //"Student Units".CALCFIELDS("Student Units"."Ignore in Final Average");
                    StudUz."Ignore in Cumm  Average" := StudUz."Ignore in Final Average";
                    StudUz.MODIFY;
                    // CLEAR(TotMarks);
                    // TotMarks:="Student Units"."Total Score";
                    IF (GetGradeStatus(TotMarks, StudUz.Programme, StudUz.Unit)) OR
                    (StudUz."Final Score" = 0) THEN BEGIN
                        StudUz."Result Status" := 'FAIL';
                        // StudUz.Failed:=TRUE;
                    END ELSE BEGIN
                        StudUz."Result Status" := 'PASS';
                    END;
                    CLEAR(Gradeaqq2);
                    StudUz.Grade := GetGrade(
                    TotMarks, StudUz.Unit, StudUz.Programme);
                    StudUz.Grade := GetGrade(StudUz."Total Score", StudUz.Unit, StudUz.Programme);
                    Gradeaqq2 := GetGrade(StudUz."Final Score", StudUz.Unit, StudUz.Programme);
                    MODIFY;
                    // "Student Units"."GPA Points":=GetGPAPoints("Student Units"."Final Score","Student Units".Unit);
                    //"Student Units"."Unit Points":=((GetGPAPoints("Student Units"."Final Score","Student Units".Unit))*
                    //  ("Student Units"."Credit Hours"));


                    //"Student Units".SETCURRENTKEY(Programme,Stage,Unit,Semester,"Reg. Transacton ID","Student No.",ENo
                    //);
                    // "Student Units".RENAME(
                    //"Student Units".Programme,"Student Units".Stage,"Student Units".Unit,
                    //"Student Units".Semester,"Student Units"."Reg. Transacton ID","Student Units"."Student No.",
                    //"Student Units".ENo,
                    // GetGrade("Student Units"."Final Score",
                    // "Student Units".Unit),
                    //"Student Units"."Academic Year"
                    // );

                    //"Student Units".MODIFY;

                    // Update Supplimentary
                    IF StudUz."Register for" = StudUz."Register for"::Supplimentary THEN BEGIN
                        StudUnits.RESET;
                        StudUnits.SETRANGE(StudUnits."Student No.", StudUz."Student No.");
                        StudUnits.SETRANGE(StudUnits.Unit, StudUz.Unit);
                        StudUnits.SETRANGE(StudUnits."Re-Take", FALSE);
                        StudUnits.SETRANGE(StudUnits."Supp Taken", FALSE);
                        IF StudUnits.FIND('-') THEN BEGIN
                            REPEAT
                                StudUnits."Supp Taken" := TRUE;
                                StudUnits.MODIFY;
                            UNTIL StudUnits.NEXT = 0;
                        END;
                    END;

                    EResults.RESET;
                    EResults.SETRANGE(EResults."Student No.", StudUz."Student No.");
                    EResults.SETRANGE(EResults.Unit, StudUz.Unit);
                    EResults.SETRANGE(EResults.Programmes, StudUz.Programme);
                    EResults.SETRANGE(EResults.Stage, StudUz.Stage);
                    EResults.SETRANGE(EResults.Semester, StudUz.Semester);
                    EResults.SETRANGE(EResults."Re-Take", FALSE);
                    EResults.SETFILTER(Status, '%1|%2|%3', EResults.Status::Current, EResults.Status::Registration, EResults.Status::Deceased);
                    IF EResults.FIND('-') THEN BEGIN
                        REPEAT
                            EResults.CALCFIELDS(EResults."Re-Sit");
                            EResults."Re-Sited" := EResults."Re-Sit";
                            EResults.MODIFY;
                        UNTIL EResults.NEXT = 0;
                    END;
                    // // // // // // // // // // // // // // StudUz."Consolidated Mark Pref." :='';
                    // // // // // // // // // // // // // // IF StudUz.Grade='E' THEN
                    // // // // // // // // // // // // // // StudUz."Consolidated Mark Pref." :='^';
                    // // // // // // // // // // // // // // StudUz.CALCFIELDS(StudUz."CATs Marks Exists",StudUz."EXAMs Marks Exists");
                    // // // // // // // // // // // // // // IF ((StudUz."CATs Marks Exists"=FALSE) AND (StudUz."EXAMs Marks Exists"=FALSE)) THEN BEGIN
                    // // // // // // // // // // // // // // StudUz."Consolidated Mark Pref." :='x';
                    // // // // // // // // // // // // // //  END ELSE IF ((StudUz."CATs Marks Exists"=TRUE) AND (StudUz."EXAMs Marks Exists"=FALSE)) THEN BEGIN
                    // // // // // // // // // // // // // // StudUz."Consolidated Mark Pref." :='c';
                    // // // // // // // // // // // // // //  END ELSE IF ((StudUz."CATs Marks Exists"=FALSE) AND (StudUz."EXAMs Marks Exists"=TRUE)) THEN BEGIN
                    // // // // // // // // // // // // // // StudUz."Consolidated Mark Pref." :='e';
                    // // // // // // // // // // // // // //  END;
                    //StudUz.VALIDATE(Score);

                    StudUz.MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                CLEAR(sName);
                cust.RESET;
                cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                IF cust.FIND('-') THEN
                    sName := cust.Name;
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Processing 1 of 7.\This may take a minute or two.....                 \Stud: #1#############################################' +
        '\Prog: #2############################################\Unit: #3#################################################');
    end;

    var
        ExamProcess: Codeunit 60276;
        EResults: Record 61548;
        UnitsR: Record 61517;
        "Units/Subj": Record 61517;
        Sem: Record 61692;
        StudUnits: Record 61549;
        stduntz: Record 61549;
        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[20];
        TotalMarks: Decimal;
        Gradings: Record 61599;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record 61599;
        Gradeaqq2: Code[20];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        progress: Dialog;

    procedure GetGrade(EXAMMark: Decimal; UnitG: Code[20]; Proga: Code[20]) xGrade: Text[100]
    var
        UnitsRR: Record 61517;
        ProgrammeRec: Record 61511;
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
    begin
        CLEAR(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code", Proga);
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code","Student Units".Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(UnitG) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN GradeCategory := 'DEFAULT';
            END;
        END;
        xGrade := '';
        IF Marks > 0 THEN BEGIN
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            Gradings.SETFILTER(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SETFILTER(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                //REPEAT
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


            END;

        END ELSE BEGIN
            Grade := '';
        END;
    end;

    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]; var Unit: Code[20]) F: Boolean
    var
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
        ProgrammeRec: Record 61511;
        Grd: Code[80];
        GradeCategory: Code[20];
        UnitsRR: Record 61517;
    begin
        F := FALSE;

        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code", ProgCode);
        UnitsRR.SETRANGE(UnitsRR.Code, Unit);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code",StudUz.Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(ProgCode) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN GradeCategory := 'DEFAULT';//ERROR('Please note that you must specify Exam Category in Programme Setup');
            END;
        END;

        IF AvMarks > 0 THEN BEGIN
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            Gradings.SETFILTER(Gradings."Lower Limit", '<%1|=%2', AvMarks, AvMarks);
            Gradings.SETFILTER(Gradings."Upper Limit", '>%1|=%2', AvMarks, AvMarks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                //REPEAT
                LastScore := Gradings."Up to";
                IF AvMarks < LastScore THEN BEGIN
                    IF ExitDo = FALSE THEN BEGIN
                        Grd := Gradings.Grade;
                        F := Gradings.Failed;
                        ExitDo := TRUE;
                    END;
                END;

                //UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;

    procedure GetGPAPoints(Marks: Decimal; UnitG: Code[20]; Progra: Code[20]) xGPA: Decimal
    var
        UnitsRR: Record 61517;
        ProgrammeRec: Record 61511;
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
    begin
        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code", Progra);
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code",StudUz.Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(StudUz.Programme) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN GradeCategory := 'DEFAULT';
                //ERROR('Please note that you must specify Exam Category in Programme Setup');
            END;
        END;

        xGPA := 0;
        IF Marks > 0 THEN BEGIN
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
                            //xGPA:=Gradings."GPA Points";
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
    end;
}

