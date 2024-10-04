/// <summary>
/// Codeunit Exams Processing1 (ID 60110).
/// </summary>
codeunit 60110 "Exams Processing1"
{

    trigger OnRun()
    begin
    end;

    var
        EResults: Record 61548;


    /// <summary>
    /// UpdateStudentUnits.
    /// </summary>
    /// <param name="StudNo">Code[20].</param>
    /// <param name="Prog">Code[20].</param>
    /// <param name="Sem">Code[50].</param>
    /// <param name="Stag">Code[20].</param>
    procedure UpdateStudentUnits(StudNo: Code[20]; Prog: Code[20]; Sem: Code[50]; Stag: Code[20])
    var
        ProgrammeRec: Record 61511;
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        EResults: Record 61548;
        "Units/Subj": Record 61517;
    begin
        EResults.RESET;
        EResults.SETRANGE(EResults."Student No.", StudNo);
        EResults.SETRANGE(EResults.Programmes, Prog);
        EResults.SETRANGE(EResults.Stage, Stag);
        EResults.SETRANGE(EResults.Semester, Sem);
        IF EResults.FIND('-') THEN BEGIN
            REPEAT
                EResults.Contribution := EResults.Score;
                EResults.MODIFY;
            UNTIL EResults.NEXT = 0;
        END;

        ProgrammeRec.GET(Prog);
        ProgrammeRec.TESTFIELD(ProgrammeRec."Exam Category");
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
                "Units/Subj".SETRANGE("Units/Subj"."Stage Code", StudUnits.Stage);
                "Units/Subj".SETRANGE("Units/Subj"."Old Unit", StudUnits."Old Unit");
                IF "Units/Subj".FIND('-') THEN BEGIN
                    StudUnits.Description := "Units/Subj".Desription;
                    StudUnits."No. Of Units" := "Units/Subj"."No. Units";
                    StudUnits."Attachment Unit" := "Units/Subj".Attachment;
                    IF "Units/Subj"."No. Units" = 0 THEN
                        StudUnits."No. Of Units" := 1;
                END;
                StudUnits.CALCFIELDS(StudUnits."Total Score");
                StudUnits.CALCFIELDS(StudUnits."Exam Marks");
                StudUnits.CALCFIELDS(StudUnits."Ignore in Final Average");
                StudUnits."Final Score" := StudUnits."Total Score";
                StudUnits."Ignore in Cumm  Average" := StudUnits."Ignore in Final Average";

                StudUnits."Final Score" := StudUnits."Total Score";
                StudUnits."CF Score" := StudUnits."Total Score" * StudUnits."No. Of Units";
                StudUnits.Grade := GetGrade(StudUnits."Total Score", StudUnits.Unit, StudUnits.Programme, StudUnits.Stage);
                IF GetGradeStatus(StudUnits."Total Score", StudUnits.Programme, StudUnits.Unit, StudUnits.Stage) = TRUE THEN BEGIN
                    StudUnits."Result Status" := 'FAIL';
                    StudUnits.Failed := TRUE;
                END ELSE BEGIN
                    StudUnits.Failed := FALSE;
                    StudUnits."Result Status" := 'PASS';
                END;
                IF StudUnits."Final Score" = 0 THEN BEGIN
                    StudUnits."Result Status" := 'FAIL';
                    StudUnits.Failed := TRUE;
                END;
                IF (StudUnits."Final Score" <> 0) AND (StudUnits."Exam Marks" = 0) THEN BEGIN
                    StudUnits."Result Status" := 'SPECIAL';
                    StudUnits.Failed := TRUE;
                END;

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


    /// <summary>
    /// UpdateCourseReg.
    /// </summary>
    /// <param name="StudNo">Code[20].</param>
    /// <param name="Prog">Code[20].</param>
    /// <param name="Stag">Code[100].</param>
    /// <param name="Sem">Code[100].</param>
    procedure UpdateCourseReg(StudNo: Code[20]; Prog: Code[20]; Stag: Code[100]; Sem: Code[100])
    var
        Creg: Record 61532;
        StudUnits: Record 61549;
        XC: Code[20];
        SemRec: Record 61692;
        Spec: Boolean;
        CReg2: Record 61532;
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
                IF (Creg."CF Total Score" > 0) AND (Creg."CF Count" > 0) THEN BEGIN
                    Creg."Cumm Score" := Creg."CF Total Score" / Creg."CF Count";
                    Creg."Cumm Grade" := GetGrade((Creg."CF Total Score" / Creg."CF Count"), XC, Prog, XC);
                    Creg.MODIFY;
                END;
            UNTIL Creg.NEXT = 0;
        END;

        Creg.RESET;
        Creg.SETRANGE(Creg."Student No.", StudNo);
        Creg.SETRANGE(Creg.Programmes, Prog);
        // Creg.SETRANGE(Creg.Stage,Stag);
        // Creg.SETRANGE(Creg.Semester,Sem);
        //Creg.SETFILTER(Creg."Stage Filter",Stag);
        Creg.SETFILTER(Creg."Semester Filter", Sem);
        IF Creg.FIND('-') THEN BEGIN
            REPEAT
                Creg.CALCFIELDS(Creg."CF Count");
                Creg.CALCFIELDS(Creg."CF Total Score");
                Creg.CALCFIELDS(Creg."Cum Units Done");
                Creg.CALCFIELDS(Creg."Cum Units Passed");
                Creg.CALCFIELDS(Creg."Cum Units Failed");
                Creg.CALCFIELDS(Creg."Manual Exam Status");
                Spec := FALSE;
                IF Creg."Manual Exam Status" = FALSE THEN BEGIN
                    Creg."Exam Status" := 'FAIL';
                    Creg."General Remark" := '';
                    IF (Creg."CF Total Score" > 0) AND (Creg."CF Count" > 0) THEN BEGIN

                        Creg."Current Cumm Score" := Creg."CF Total Score" / Creg."CF Count";
                        Creg."Current Cumm Grade" := GetGrade((Creg."CF Total Score" / Creg."CF Count"), XC, Prog, XC);
                        Creg.Award := GetAward((Creg."CF Total Score" / Creg."CF Count"), XC, Prog, XC);
                    END;
                    IF GetGradeStatus(Creg."Current Cumm Score", Prog, XC, XC) = TRUE THEN BEGIN
                        Creg."Exam Status" := 'SUPP'
                    END ELSE BEGIN
                        IF (Creg."Cum Units Done" = Creg."Cum Units Passed") THEN
                            Creg."Exam Status" := 'PASS'

                    END;
                    IF (Creg."Cum Units Done" = Creg."Cum Units Passed") THEN BEGIN
                        Creg."Exam Status" := 'PASS'
                    END;

                    IF (Creg."Cum Units Done" <> 0) AND (Creg."Cum Units Passed" <> 0) THEN BEGIN
                        Creg."Yearly Average" := ROUND(((Creg."Cum Units Done" - (Creg."Cum Units Passed" + Creg."Total Yearly Marks")) / Creg."Cum Units Done") * 100, 1);

                        IF (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) < 25) THEN BEGIN
                            Creg."Exam Status" := 'SUPP';
                        END;

                        IF (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) > 25) AND
                        (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) < 50) THEN BEGIN
                            Creg."Exam Status" := 'REPEAT';
                        END;
                        IF (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) > 50) THEN BEGIN
                            Creg."Exam Status" := 'DISCONTINUED';
                        END;
                    END;
                    IF Creg."Cum Units Passed" = 0 THEN
                        Creg."Exam Status" := 'DISCONTINUED';

                    // Mark Marks with Missing Exam Marks as Special
                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", Creg."Student No.");
                    StudUnits.SETFILTER(StudUnits.Stage, Stag);
                    StudUnits.SETFILTER(StudUnits.Semester, Sem);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnits.CALCFIELDS(StudUnits."Exam Marks");
                            StudUnits.CALCFIELDS(StudUnits."CAT Total Marks");
                            StudUnits.CALCFIELDS(StudUnits."Total Score");
                            IF (StudUnits."Total Score") <> 0 THEN BEGIN
                                IF StudUnits."Exam Marks" = 0 THEN BEGIN
                                    IF SemRec.GET(Creg.Semester) THEN
                                        IF SemRec."BackLog Marks" = FALSE THEN BEGIN
                                            Creg."Exam Status" := 'SPECIAL';


                                            IF StudUnits."CAT Total Marks" = 0 THEN BEGIN
                                                Creg."Exam Status" := 'DTSC';
                                                Creg."General Remark" := 'Missing Exam Marks';
                                                Spec := TRUE;
                                            END;
                                        END;
                                END;
                            END;
                        UNTIL StudUnits.NEXT = 0;
                    END;
                    Creg.MODIFY;
                END;
            UNTIL Creg.NEXT = 0;
        END;
    end;


    /// <summary>
    /// GetGrade.
    /// </summary>
    /// <param name="Marks">Decimal.</param>
    /// <param name="UnitG">Code[20].</param>
    /// <param name="Studprog">Code[20].</param>
    /// <param name="StudStage">Code[20].</param>
    /// <returns>Return variable xGrade of type Text[100].</returns>
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


    /// <summary>
    /// GetGradeStatus.
    /// </summary>
    /// <param name="AvMarks">VAR Decimal.</param>
    /// <param name="ProgCode">VAR Code[20].</param>
    /// <param name="Unit">VAR Code[20].</param>
    /// <param name="StudStage">Code[20].</param>
    /// <returns>Return variable F of type Boolean.</returns>
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


    /// <summary>
    /// GetAward.
    /// </summary>
    /// <param name="Marks">Decimal.</param>
    /// <param name="UnitG">Code[20].</param>
    /// <param name="Studprog">Code[20].</param>
    /// <param name="StudStage">Code[20].</param>
    /// <returns>Return variable xAward of type Text[200].</returns>
    procedure GetAward(Marks: Decimal; UnitG: Code[20]; Studprog: Code[20]; StudStage: Code[20]) xAward: Text[200]
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
        xAward := '';
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
                            xAward := Gradings.Remarks;
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


    /// <summary>
    /// UpdateCummStatus.
    /// </summary>
    /// <param name="StudNo">Code[20].</param>
    /// <param name="Prog">Code[20].</param>
    /// <param name="Stag">Code[50].</param>
    /// <param name="Sem">Code[50].</param>
    procedure UpdateCummStatus(StudNo: Code[20]; Prog: Code[20]; Stag: Code[50]; Sem: Code[50])
    var
        Creg: Record 61532;
        CX: Code[20];
        Sc: Decimal;
        StudUnits: Record 61549;
        ProgRec: Record 61511;
    begin

        // ERROR(FORMAT(StudNo+' '+Prog+' '+Stag+' '+Sem));
        IF ProgRec.GET(Prog) THEN;
        Creg.RESET;
        Creg.SETRANGE(Creg."Student No.", StudNo);
        Creg.SETRANGE(Creg.Programmes, Prog);
        Creg.SETFILTER(Creg."Stage Filter", Stag);
        Creg.SETFILTER(Creg."Semester Filter", Sem);
        IF Creg.FIND('-') THEN BEGIN
            REPEAT
                Creg.CALCFIELDS(Creg."CF Count");
                Creg.CALCFIELDS(Creg."CF Total Score");
                Creg.CALCFIELDS(Creg."Sem FAIL Count");
                Creg.CALCFIELDS(Creg."Cum Units Done");
                Creg.CALCFIELDS(Creg."Cum Units Passed");
                Creg.CALCFIELDS(Creg."Cum Units Failed");
                Creg.CALCFIELDS(Creg."Manual Exam Status");
                IF Creg."Cum Units Done" = Creg."Cum Units Passed" THEN
                    Creg."Cumm Status" := 'PASS'
                ELSE
                    Creg."Cumm Status" := 'FAIL';

                IF Creg."Cum Units Done" = 0 THEN
                    Creg."Cumm Status" := 'FAIL';

                /*
                IF (Creg."CF Total Score"<>0) AND (Creg."CF Count"<>0) THEN BEGIN
                  Sc:=ROUND(Creg."CF Total Score"/Creg."CF Count",0.5);
                  Creg."Cumm Score":=ROUND(Creg."CF Total Score"/Creg."CF Count",0.5);
                  IF GetGradeStatus(Sc,Prog,CX,CX) =TRUE THEN
                   Creg."Cumm Status":='FAIL';
                   IF Creg."Cum Units Done">0 THEN BEGIN
                    IF Creg."Cum Units Failed"> (Creg."Cum Units Done"/2) THEN
                    Creg."Cumm Status":='REPEAT';

                    IF Creg."Cum Units Failed">(ProgRec."Min Pass Units") THEN
                    Creg."Cumm Status":='DISCONTINUE';
                    END;
                END;
                IF (Creg."CF Total Score"=0) OR (Creg."Cum Units Done"=0) THEN
                  Creg."Cumm Status":='DISCONTINUE';
             */
                IF (Creg."Cum Units Done" <> 0) AND (Creg."Cum Units Passed" <> 0) THEN BEGIN
                    IF (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) > 25) AND
                    (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) < 50) THEN BEGIN
                        Creg."Cumm Status" := 'REPEAT';
                    END;
                    IF (ROUND(((Creg."Cum Units Done" - Creg."Cum Units Passed") / Creg."Cum Units Done") * 100, 1) > 50) THEN BEGIN
                        Creg."Cumm Status" := 'DISCONTINUED';
                    END;
                END;
                IF Creg."Cum Units Passed" = 0 THEN
                    Creg."Cumm Status" := 'DISCONTINUED';


                IF Creg."Manual Exam Status" = FALSE THEN BEGIN// Modify only if Status is Auto
                    Creg.MODIFY;

                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", StudNo);
                    StudUnits.SETRANGE(StudUnits.Failed, TRUE);
                    StudUnits.SETRANGE(StudUnits."Supp Taken", FALSE);
                    StudUnits.SETRANGE(StudUnits.Programme, Prog);
                    StudUnits.SETFILTER(StudUnits."Stage Filter", Stag);
                    StudUnits.SETFILTER(StudUnits."Semester Filter", Sem);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnits."Result Status" := Creg."Cumm Status";
                        //StudUnits.MODIFY;
                        UNTIL StudUnits.NEXT = 0;
                    END;
                END;

            UNTIL Creg.NEXT = 0;
        END;
        // Manual Status
        Creg.RESET;
        Creg.SETRANGE(Creg."Student No.", StudNo);
        Creg.SETRANGE(Creg.Programmes, Prog);
        Creg.SETRANGE(Creg."Manual Exam Status", TRUE);
        Creg.SETFILTER(Creg.Stage, Stag);
        Creg.SETFILTER(Creg.Semester, Sem);
        IF Creg.FIND('-') THEN BEGIN
            REPEAT
                Creg."Cumm Status" := Creg."Exam Status";
                Creg.MODIFY;
            UNTIL Creg.NEXT = 0;
        END;

    end;
}

