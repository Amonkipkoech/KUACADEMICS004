codeunit 60276 "Exams Processing"
{

    trigger OnRun()
    begin
        UpdateGradingSystem('2019/2020');
    end;

    var
        NoofCourses: Integer;
        dials: Dialog;

    //[Scope('Internal')]
    procedure UpdateStudentUnits(StudNo: Code[20]; Prog: Code[20]; Sem: Code[20]; Stag: Code[20])
    var
        ProgrammeRec: Record 61511;
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        EResults: Record 61548;
        "Units/Subj": Record 61517;
    begin
        StudUnits.RESET;
        StudUnits.SETRANGE(StudUnits."Student No.", StudNo);
        StudUnits.SETRANGE(StudUnits.Programme, Prog);
        StudUnits.SETRANGE(StudUnits.Stage, Stag);
        StudUnits.SETRANGE(StudUnits.Semester, Sem);
        IF StudUnits.FIND('-') THEN BEGIN
            REPEAT
                "Units/Subj".RESET;
                "Units/Subj".SETRANGE("Units/Subj"."Programme Code", StudUnits.Programme);
                "Units/Subj".SETRANGE("Units/Subj".Code, StudUnits.Unit);
                // "Units/Subj".SETRANGE("Units/Subj"."Stage Code",StudUnits.Stage);
                IF "Units/Subj".FIND('-') THEN BEGIN
                    StudUnits.Description := "Units/Subj".Desription;
                    StudUnits."No. Of Units" := "Units/Subj"."No. Units";
                    // StudUnits."No. Of Units":=3;
                END;
                StudUnits.CALCFIELDS(StudUnits."Total Score");
                StudUnits.CALCFIELDS(StudUnits."Ignore in Final Average");
                StudUnits."Final Score" := StudUnits."Total Score";
                StudUnits."Ignore in Cumm  Average" := StudUnits."Ignore in Final Average";

                StudUnits."Final Score" := StudUnits."Total Score";
                StudUnits."CF Score" := StudUnits."Total Score" * StudUnits."No. Of Units";
                StudUnits.Grade := GetGrade(StudUnits."Total Score", StudUnits.Unit, StudUnits.Programme, StudUnits.Stage);
                IF GetGradeStatus(StudUnits."Total Score", StudUnits.Programme, StudUnits.Unit, StudUnits.Stage) = TRUE THEN
                    StudUnits."Result Status" := 'FAIL'
                ELSE
                    StudUnits."Result Status" := 'PASS';

                StudUnits.MODIFY;

                // Update Supplimentary
                IF StudUnits."Register for" = StudUnits."Register for"::Supplimentary THEN BEGIN
                    StudUnits2.RESET;
                    StudUnits2.SETRANGE(StudUnits2."Student No.", StudUnits."Student No.");
                    StudUnits2.SETRANGE(StudUnits2.Unit, StudUnits.Unit);
                    StudUnits2.SETRANGE(StudUnits2."Re-Take", FALSE);
                    StudUnits2.SETRANGE(StudUnits2."Supp Taken", FALSE);
                    IF StudUnits2.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnits2."Supp Taken" := TRUE;
                            StudUnits2.MODIFY;
                        UNTIL StudUnits2.NEXT = 0;
                    END;
                END;

                EResults.RESET;
                EResults.SETRANGE(EResults."Student No.", StudUnits."Student No.");
                EResults.SETRANGE(EResults.Unit, StudUnits.Unit);
                EResults.SETRANGE(EResults.Programmes, StudUnits.Programme);
                EResults.SETRANGE(EResults.Stage, StudUnits.Stage);
                EResults.SETRANGE(EResults.Semester, StudUnits.Semester);
                EResults.SETRANGE(EResults."Re-Take", FALSE);
                IF EResults.FIND('-') THEN BEGIN
                    REPEAT
                        EResults.CALCFIELDS(EResults."Re-Sit");
                        EResults."Re-Sited" := EResults."Re-Sit";
                        EResults.MODIFY;
                    UNTIL EResults.NEXT = 0;
                END;

            UNTIL StudUnits.NEXT = 0;
        END;
    end;

    //[Scope('Internal')]
    procedure UpdateCourseReg(StudNo: Code[20]; Prog: Code[20]; Stag: Code[20]; Sem: Code[20])
    var
        Creg: Record 61532;
        StudUnits: Record 61549;
        XC: Code[20];
    begin
        Creg.RESET;
        Creg.SETRANGE(Creg."Student No.", StudNo);
        Creg.SETRANGE(Creg.Programmes, Prog);
        Creg.SETRANGE(Creg.Semester, Sem);
        Creg.SETRANGE(Creg.Stage, Stag);
        Creg.SETFILTER(Creg."Stage Filter", Stag);
        Creg.SETFILTER(Creg."Semester Filter", Sem);
        IF Creg.FIND('-') THEN BEGIN
            REPEAT
                Creg.CALCFIELDS(Creg."CF Count");
                Creg.CALCFIELDS(Creg."CF Total Score");
                IF (Creg."CF Count" <> 0) AND (Creg."CF Total Score" <> 0) THEN BEGIN
                    Creg."Cumm Score" := Creg."CF Total Score" / Creg."CF Count";
                    Creg."Cumm Grade" := GetGrade((Creg."CF Total Score" / Creg."CF Count"), XC, Prog, XC);
                END;
                Creg.MODIFY;
            UNTIL Creg.NEXT = 0;
        END;


        Creg.RESET;
        Creg.SETRANGE(Creg."Student No.", StudNo);
        Creg.SETRANGE(Creg.Programmes, Prog);
        Creg.SETFILTER(Creg."Stage Filter", Stag);
        Creg.SETFILTER(Creg."Semester Filter", Sem);
        IF Creg.FIND('-') THEN BEGIN
            REPEAT
                Creg.CALCFIELDS(Creg."CF Count");
                Creg.CALCFIELDS(Creg."CF Total Score");
                Creg.CALCFIELDS(Creg."Cum Units Done");
                Creg.CALCFIELDS(Creg."Cum Units Passed");
                Creg.CALCFIELDS(Creg."Cum Units Failed");
                Creg."Exam Status" := 'FAIL';
                IF (Creg."CF Total Score" > 0) AND (Creg."CF Count" > 0) THEN BEGIN
                    Creg."Current Cumm Score" := Creg."CF Total Score" / Creg."CF Count";
                    Creg."Current Cumm Grade" := GetGrade((Creg."CF Total Score" / Creg."CF Count"), XC, Prog, XC);
                END;
                IF GetGradeStatus(Creg."Current Cumm Score", Prog, XC, XC) = TRUE THEN BEGIN
                    Creg."Exam Status" := 'FAIL'
                END ELSE BEGIN
                    IF (Creg."Cum Units Done" = Creg."Cum Units Passed") AND (Creg."Cum Units Failed" = 0) THEN
                        Creg."Exam Status" := 'PASS';
                END;
                Creg.MODIFY;
            UNTIL Creg.NEXT = 0;
        END;
    end;

    //[Scope('Internal')]
    procedure GetGrade(Marks: Decimal; UnitG: Code[20]; Studprog: Code[20]; StudStage: Code[20]) xGrade: Text[100]
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
        UnitsRR.SETRANGE(UnitsRR."Programme Code", Studprog);
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        UnitsRR.SETRANGE(UnitsRR."Stage Code", StudStage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END;
        END;
        IF GradeCategory = '' THEN BEGIN
            ProgrammeRec.RESET;
            IF ProgrammeRec.GET(Studprog) THEN
                GradeCategory := ProgrammeRec."Exam Category";
            IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
        END;
        xGrade := '';
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
    end;

    //[Scope('Internal')]
    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]; var Unit: Code[20]; StudStage: Code[20]) F: Boolean
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
        UnitsRR.SETRANGE(UnitsRR."Stage Code", StudStage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(ProgCode) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
            END;
        END;

        IF AvMarks > 0 THEN BEGIN
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                REPEAT
                    LastScore := Gradings."Up to";
                    IF AvMarks < LastScore THEN BEGIN
                        IF ExitDo = FALSE THEN BEGIN
                            Grd := Gradings.Grade;
                            F := Gradings.Failed;
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;

    procedure UpdateGradingSystem(acadYears: Code[20])
    var
        ACAExamGraddingSetup: Record "ACA-Exam Gradding Setup";
        ACAExamGradingSource: Record "ACA-Exam Grading Source";
        LowerLimit: Decimal;
        UpperLimit: Decimal;
        LimitDif: Decimal;
    begin
        ACAExamGradingSource.RESET;
        ACAExamGradingSource.SETRANGE("Academic Year", acadYears);
        IF ACAExamGradingSource.FIND('-') THEN ACAExamGradingSource.DELETEALL;
        CLEAR(NoofCourses);
        dials.OPEN('#1###################################################\' +
        '#2###################################################\' +
        '#3###################################################');

        ACAExamGraddingSetup.RESET;
        IF ACAExamGraddingSetup.FIND('-') THEN BEGIN

            NoofCourses := ACAExamGraddingSetup.COUNT;
            dials.UPDATE(1, 'Total Records: ' + FORMAT(NoofCourses));
            REPEAT
            BEGIN
                NoofCourses := NoofCourses - 1;
                dials.UPDATE(2, 'Processing: ' + ACAExamGraddingSetup.Category + ': ' + ACAExamGraddingSetup.Grade);
                dials.UPDATE(3, 'Remaining: ' + FORMAT(FORMAT(NoofCourses)));
                CLEAR(LowerLimit);
                CLEAR(UpperLimit);
                LowerLimit := ACAExamGraddingSetup."Lower Limit";
                UpperLimit := ACAExamGraddingSetup."Upper Limit" + 0.01;

                REPEAT
                BEGIN
                    IF ((ACAExamGraddingSetup."Results Exists Status" = ACAExamGraddingSetup."Results Exists Status"::"CAT Only") OR
                      (ACAExamGraddingSetup."Results Exists Status" = ACAExamGraddingSetup."Results Exists Status"::"Exam Only")) THEN BEGIN
                        ACAExamGradingSource.INIT;
                        ACAExamGradingSource."Academic Year" := acadYears;
                        ACAExamGradingSource."Exam Catregory" := ACAExamGraddingSetup.Category;
                        ACAExamGradingSource."Total Score" := LowerLimit;
                        ACAExamGradingSource.Grade := ACAExamGraddingSetup.Grade;
                        ACAExamGradingSource."Consolidated Prefix" := ACAExamGraddingSetup."Consolidated Prefix";
                        ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                        IF ACAExamGraddingSetup.Failed THEN
                            ACAExamGradingSource.Pass := FALSE ELSE
                            ACAExamGradingSource.Pass := TRUE;
                        ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                        ACAExamGradingSource."Results Exists Status" := ACAExamGradingSource."Results Exists Status"::"CAT Only";
                        IF ACAExamGradingSource.INSERT THEN;
                        ACAExamGradingSource.INIT;
                        ACAExamGradingSource."Academic Year" := acadYears;
                        ACAExamGradingSource."Exam Catregory" := ACAExamGraddingSetup.Category;
                        ACAExamGradingSource."Total Score" := LowerLimit;
                        ACAExamGradingSource.Grade := ACAExamGraddingSetup.Grade;
                        ACAExamGradingSource."Consolidated Prefix" := ACAExamGraddingSetup."Consolidated Prefix";
                        ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                        IF ACAExamGraddingSetup.Failed THEN
                            ACAExamGradingSource.Pass := FALSE ELSE
                            ACAExamGradingSource.Pass := TRUE;
                        ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                        ACAExamGradingSource."Results Exists Status" := ACAExamGradingSource."Results Exists Status"::"Exam Only";
                        IF ACAExamGradingSource.INSERT THEN;
                    END ELSE
                        IF ((ACAExamGraddingSetup."Results Exists Status" = ACAExamGraddingSetup."Results Exists Status"::"Both Exists") OR
                  (ACAExamGraddingSetup."Results Exists Status" = ACAExamGraddingSetup."Results Exists Status"::"None Exists")) THEN BEGIN
                            ACAExamGradingSource.INIT;
                            ACAExamGradingSource."Academic Year" := acadYears;
                            ACAExamGradingSource."Exam Catregory" := ACAExamGraddingSetup.Category;
                            ACAExamGradingSource."Total Score" := LowerLimit;
                            ACAExamGradingSource.Grade := ACAExamGraddingSetup.Grade;
                            ACAExamGradingSource."Consolidated Prefix" := ACAExamGraddingSetup."Consolidated Prefix";
                            ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                            IF ACAExamGraddingSetup.Failed THEN
                                ACAExamGradingSource.Pass := FALSE ELSE
                                ACAExamGradingSource.Pass := TRUE;
                            ACAExamGradingSource.Remarks := ACAExamGraddingSetup.Remarks;
                            ACAExamGradingSource."Results Exists Status" := ACAExamGraddingSetup."Results Exists Status";
                            IF ACAExamGradingSource.INSERT THEN;
                        END;

                    // IF ((UpperLimit-LowerLimit)>0.01) THEN BEGIN
                    LowerLimit := LowerLimit + 0.01;
                    // END;
                END;
                UNTIL ((LowerLimit = UpperLimit) OR (LowerLimit > UpperLimit));
            END;
            UNTIL ACAExamGraddingSetup.NEXT = 0;
        END;
        dials.CLOSE;
    end;
}
