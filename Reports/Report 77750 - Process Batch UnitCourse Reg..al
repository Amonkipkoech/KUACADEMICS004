report 77750 "Process Batch Unit/Course Reg."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(ExamBuff2; 61746)
        {

            trigger OnAfterGetRecord()
            var
                yos: Integer;
            begin
                progress.UPDATE(1, ExamBuff2."Student No.");
                progress.UPDATE(2, ExamBuff2."Student Name");
                // Attempt to Pick stage & Semester
                CLEAR(yos);
                CLEAR(errorReason);

                IF ExamBuff2.Stage <> '' THEN BEGIN
                    IF EVALUATE(yos, COPYSTR(ExamBuff2.Stage, 2, 1)) THEN BEGIN
                    END;
                END;
                IF ExamBuff2.Stage = '' THEN BEGIN
                    // ExamBuff2.Stage:=(GetUnitStage(ExamBuff2."Unit Code",ExamBuff2.Programme));
                    IF ExamBuff2.RENAME(ExamBuff2."Student No.",
                      ExamBuff2."Academic Year", ExamBuff2.Semester,
                      ExamBuff2.Programme, ExamBuff2."Unit Code",
                      (GetUnitStage(ExamBuff2."Unit Code", ExamBuff2.Programme)),
                      ExamBuff2.Intake, ExamBuff2."Exam Session") THEN BEGIN
                    END;
                    IF (GetUnitStage(ExamBuff2."Unit Code", ExamBuff2.Programme)) = '' THEN
                        errorReason := errorReason + 'Unit Stage is Missing;'
                    ELSE BEGIN

                        //ExamBuff2.Stage:=(GetUnitStage(ExamBuff2."Unit Code",ExamBuff2.Programme));
                        /*  IF ExamBuff2.RENAME(
                   ExamBuff2."Student No.",ExamBuff2."Academic Year",
                   ExamBuff2.Semester,ExamBuff2.Programme,
                   ExamBuff2."Unit Code",(GetUnitStage(ExamBuff2."Unit Code",ExamBuff2.Programme)),
                   ExamBuff2.Intake,ExamBuff2."Exam Session") THEN BEGIN
                   END;*/

                        IF EVALUATE(yos, COPYSTR((GetUnitStage(ExamBuff2."Unit Code", ExamBuff2.Programme)), 2, 1)) THEN BEGIN
                        END;
                    END;
                END;

                IF ExamBuff2."Unit Name" = '' THEN BEGIN
                    IF (GetUnitName(ExamBuff2."Unit Code", ExamBuff2.Programme)) <> '' THEN BEGIN
                        ExamBuff2."Unit Name" := (GetUnitName(ExamBuff2."Unit Code", ExamBuff2.Programme));
                        ExamBuff2.MODIFY;
                    END;
                END;

                IF ExamBuff2.Semester = '' THEN BEGIN
                    IF (GetSemester(yos, ExamBuff2."Student No.", ExamBuff2."Unit Code",
                      ExamBuff2.Programme)) = '' THEN
                        errorReason := errorReason + 'Not Registered;' ELSE BEGIN
                        //ExamBuff2.Semester:=GetSemester(yos,ExamBuff2."Student No.",ExamBuff2."Unit Code",
                        //    ExamBuff2.Programme);
                        IF ExamBuff2.RENAME(
                   ExamBuff2."Student No.", ExamBuff2."Academic Year",
                   (GetSemester(yos, ExamBuff2."Student No.", ExamBuff2."Unit Code",
                       ExamBuff2.Programme)), ExamBuff2.Programme,
                   ExamBuff2."Unit Code", (GetUnitStage(ExamBuff2."Unit Code", ExamBuff2.Programme)),
                   ExamBuff2.Intake, ExamBuff2."Exam Session") THEN BEGIN
                        END;
                        // ExamBuff2.MODIFY;
                    END;
                END;

                CLEAR(failed);
                //CLEAR(errorReason);
                // Check if student Exists
                IF ExamBuff2."Academic Year" = '' THEN errorReason := errorReason + 'No Acad. Year;';
                //IF ExamBuff2.Semester='' THEN
                IF ExamBuff2.Programme = '' THEN errorReason := errorReason + 'No Prog.;';
                IF ExamBuff2."Unit Code" = '' THEN errorReason := errorReason + 'No Unit;';
                //IF ExamBuff2.Stage='' THEN errorReason:=errorReason+'No Stage;';
                IF errorReason <> '' THEN failed := TRUE;
                IF errorReason = '' THEN BEGIN
                    cust.RESET;
                    cust.SETRANGE(cust."No.", ExamBuff2."Student No.");
                    IF cust.FIND('-') THEN BEGIN
                        progs.RESET;
                        progs.SETRANGE(progs.Code, ExamBuff2.Programme);
                        IF progs.FIND('-') THEN BEGIN
                            // Check if the stage exists
                            ProgStages.RESET;
                            ProgStages.SETRANGE(ProgStages."Programme Code", ExamBuff2.Programme);
                            ProgStages.SETRANGE(ProgStages.Code, ExamBuff2.Stage);
                            IF ProgStages.FIND('-') THEN BEGIN
                                // check if Unit Exists, If Not so, create one
                                units.RESET;
                                units.SETRANGE(units."Programme Code", ExamBuff2.Programme);
                                units.SETRANGE(units."Stage Code", ExamBuff2.Stage);
                                units.SETRANGE(units.Code, ExamBuff2."Unit Code");
                                IF units.FIND('-') THEN BEGIN// uNIT eXISTS, iNSERT The Results
                                                             // Check if Course Reg Exists and Register Unit
                                    CourseRegANDUnits(ExamBuff2."Student No.", ExamBuff2.Programme,
                                    ExamBuff2.Semester, ExamBuff2."Academic Year",
                                    ExamBuff2."Unit Code", ExamBuff2.Stage);
                                    PostExamz(
                                   ExamBuff2.Programme, ExamBuff2.Stage, ExamBuff2."Unit Code",
                                   ExamBuff2.Semester, 'EXAM',
                                   ExamBuff2."Exam Score", ExamBuff2."CAT Score",
                                    ExamBuff2."Student No.", ExamBuff2."Academic Year"
                                   );
                                END ELSE BEGIN // uNIT nOT eXISTS, CREATE ONE
                                               // Create a Unit
                                    CreateUnit(ExamBuff2.Programme, ExamBuff2."Unit Code",
                                    ExamBuff2.Stage, ExamBuff2."Unit Name");
                                    // Check if Course Reg Exists and Register Unit
                                    CourseRegANDUnits(ExamBuff2."Student No.", ExamBuff2.Programme,
                                    ExamBuff2.Semester, ExamBuff2."Academic Year",
                                    ExamBuff2."Unit Code", ExamBuff2.Stage);
                                    PostExamz(
                                   ExamBuff2.Programme, ExamBuff2.Stage, ExamBuff2."Unit Code",
                                   ExamBuff2.Semester, 'EXAM',
                                   ExamBuff2."Exam Score", ExamBuff2."CAT Score",
                                    ExamBuff2."Student No.", ExamBuff2."Academic Year"
                                   );

                                END;
                            END ELSE BEGIN // end for Prog Stages
                                failed := TRUE;
                                IF errorReason = '' THEN
                                    errorReason := 'Stage ''' + ExamBuff2.Stage + '''Missing'
                                ELSE
                                    errorReason := errorReason + 'Stage ''' + ExamBuff2.Stage + '''Missing'
                            END;// end for Prog Stages
                        END ELSE BEGIN // end for programme
                            failed := TRUE;
                            errorReason := errorReason + 'Programme ''' + ExamBuff2.Programme + '''Missing';
                        END; // end for programme
                    END // end for cust
                    ELSE BEGIN
                        failed := TRUE;
                        errorReason := errorReason + 'Student No.:  ''' + ExamBuff2."Student No." + ': ' + ExamBuff2."Student Name" + '''  Missing';
                    END;// end for cust
                END;
                IF failed = FALSE THEN BEGIN
                    ExamBuff2."Course Reg. Created" := TRUE;
                    ExamBuff2."Units Reg. Created" := TRUE;
                    ExamBuff2."Failure Reason" := '';
                    ExamBuff2.MODIFY;
                END ELSE BEGIN
                    ExamBuff2."Course Reg. Created" := FALSE;
                    ExamBuff2."Units Reg. Created" := FALSE;
                    ExamBuff2."Failure Reason" := errorReason;
                    ExamBuff2.MODIFY;
                END;

            end;

            trigger OnPreDataItem()
            begin
                //ExamBuff2.SETRANGE(ExamBuff2."User Name",USERID);
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
        progress.OPEN('Register Units\Please Wait....\No.: #1##########################################\Name: #2#############################################');
        //IF CONFIRM('Corect the Units?',FALSE)=TRUE THEN  BEGIN
        REPORT.RUN(70094, FALSE, FALSE);
        //END;
    end;

    var
        failed: Boolean;
        errorReason: Code[250];
        courseReg: Record 61532;
        unitsReg: Record 61549;
        ProgStages: Record 61516;
        units: Record 61517;
        progs: Record 61511;
        examResults: Record 61548;
        NoSeriesMgt: Codeunit 396;
        GenSetup: Record 61534;
        cust: Record 18;
        progress: Dialog;
        ACAUnitsSubjects: Record 61517;
        ACACourseRegistration: Record 61532;

    procedure CourseRegANDUnits(StudNos: Code[50]; Progys: Code[50]; Semz: Code[50]; AcadYear: Code[50]; UnitzCode: Code[50]; stagez: Code[50])
    var
        RegTransID: Code[20];
        ACAUnitsSubjects: Record 61517;
    begin
        CLEAR(RegTransID);
        courseReg.RESET;
        courseReg.SETRANGE(courseReg."Student No.", StudNos);
        courseReg.SETRANGE(courseReg.Programmes, Progys);
        courseReg.SETRANGE(courseReg.Semester, Semz);
        courseReg.SETRANGE(courseReg."Academic Year", AcadYear);
        // courseReg.SETRANGE(Stage,stagez);
        IF courseReg.FIND('-') THEN BEGIN
            // Create A Units Registration
            unitsReg.RESET;
            unitsReg.SETRANGE(unitsReg.Programme, Progys);
            //  unitsReg.SETRANGE(unitsReg.Stage,stagez);
            unitsReg.SETRANGE(unitsReg.Unit, UnitzCode);
            unitsReg.SETRANGE(unitsReg."Student No.", StudNos);
            unitsReg.SETRANGE(unitsReg.Semester, Semz);
            // unitsReg.SETRANGE(unitsReg."Academic Year",courseReg."Academic Year");
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
                    unitsReg."Credit Hours" := 1;
                    unitsReg."Reg. Transacton ID" := courseReg."Reg. Transacton ID";
                    unitsReg."Student No." := StudNos;
                    unitsReg."Academic Year" := courseReg."Academic Year";
                    unitsReg.Taken := TRUE;
                    unitsReg.INSERT;
                END;
            END;
        END ELSE BEGIN
            // Create A course Registration
            RegTransID := NoSeriesMgt.GetNextNo('TRANS', 0D, TRUE);
            courseReg.INIT;
            courseReg."Reg. Transacton ID" := RegTransID;
            courseReg.Programmes := Progys;
            courseReg."Student No." := StudNos;
            courseReg.Semester := Semz;
            courseReg."Register for" := courseReg."Register for"::Stage;
            courseReg.VALIDATE(Stage, stagez);
            courseReg."Student Type" := courseReg."Student Type"::"Full Time";
            courseReg."Settlement Type" := 'SSP';
            courseReg."Registration Date" := TODAY;
            courseReg."Admission No." := StudNos;
            courseReg."Academic Year" := AcadYear;
            courseReg.Session := ExamBuff2.Intake;
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
                    courseReg.VALIDATE(Stage, stagez);
                    unitsReg.Unit := UnitzCode;
                    unitsReg.Semester := Semz;
                    unitsReg.Units := 1;
                    unitsReg."Credit Hours" := 1;
                    unitsReg."Reg. Transacton ID" := RegTransID;
                    unitsReg."Student No." := StudNos;
                    unitsReg."Academic Year" := courseReg."Academic Year";
                    unitsReg.Taken := TRUE;
                    unitsReg.INSERT;
                END;
            END;

        END;
        //
    end;

    procedure CreateUnit(Progys: Code[50]; UnitzCode: Code[50]; stages: Code[50]; UnitName: Text[250])
    var
        unitsLis: Record 61517;
    begin
        /*unitsLis.RESET;
        unitsLis.SETRANGE(unitsLis.Code,UnitzCode);
        unitsLis.SETRANGE(unitsLis."Programme Code",Progys);
        unitsLis.SETRANGE(unitsLis."Stage Code",stages);
        IF NOT unitsLis.FIND('-') THEN BEGIN
        unitsLis.INIT;
        unitsLis.Code:=UnitzCode;
        unitsLis."Programme Code" :=Progys;
        unitsLis."Stage Code":=stages;
        unitsLis.Desription :=UnitName;
        unitsLis."Credit Hours":=3;
        unitsLis."No. Units":=3;
        unitsLis.INSERT;
        END;*/

    end;

    procedure PostExamz(Progy: Code[50]; stage: Code[50]; unitcode: Code[50]; semez: Code[50]; examz: Code[50]; ExamMarks: Decimal; CatMarks: Decimal; studNo: Code[50]; AcadYear: Code[20])
    var
        examRes: Record 61548;
        coreg: Record 61532;
    begin
        /*coreg.RESET;
        coreg.SETRANGE(coreg."Student No.",studNo);
        coreg.SETRANGE(coreg.Programme,Progy);
        coreg.SETRANGE(coreg.Semester,semez);
        //coreg.SETRANGE(coreg.Stage,stage);
        //coreg.SETRANGE(coreg."Academic Year",AcadYear);
        IF coreg.FIND('-') THEN BEGIN
        examRes.RESET;
        examRes.SETRANGE(examRes."Student No.",studNo);
        examRes.SETRANGE(examRes.Programme,Progy);
        //examRes.SETRANGE(examRes.Stage,stage);
        examRes.SETRANGE(examRes.Unit,unitcode);
        examRes.SETRANGE(examRes.Semester,semez);
        //examRes.SETRANGE(examRes."Academic Year",AcadYear);
        IF examRes.FIND('-') THEN examRes.DELETEALL;
        examRes.INIT;
        examRes."Student No.":=studNo;
        examRes.Programme:=Progy;
        examRes.Stage:=stage;
        examRes.Unit:=unitcode;
        examRes.Semester:=semez;
        examRes."User Name":=USERID;
        examRes.ExamType:='FINAL EXAM';
        examRes."Reg. Transaction ID":=coreg."Reg. Transacton ID";
        examRes.Score:=ExamMarks;
        examRes.Exam:='FINAL EXAM';
        examRes."Admission No":=studNo;
        examRes."Academic Year":=AcadYear;
        examRes.INSERT;
        IF CatMarks<>0 THEN BEGIN
          examRes.INIT;
        examRes."Student No.":=studNo;
        examRes.Programme:=Progy;
        examRes.Stage:=stage;
        examRes.Unit:=unitcode;
        examRes.Semester:=semez;
        examRes."User Name":=USERID;
        examRes.ExamType:='CAT';
        examRes."Reg. Transaction ID":=coreg."Reg. Transacton ID";
        examRes.Score:=CatMarks;
        examRes.Exam:='CAT';
        examRes."Admission No":=studNo;
        examRes."Academic Year":=AcadYear;
        examRes.INSERT;
          END;
        // // // END ELSE BEGIN
        // // // examRes.Score:=scorez;
        // // // examRes.MODIFY;
        // // //  END;
        END;
        */

    end;

    local procedure GetSemester(YearOfStudy: Integer; StudNo: Code[20]; UnitCode: Code[20]; Prog: Code[20]) Semz: Code[20]
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCode);
        ACAUnitsSubjects.SETRANGE("Programme Code", Prog);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            ACACourseRegistration.RESET;
            ACACourseRegistration.SETRANGE("Student No.", StudNo);
            ACACourseRegistration.SETRANGE(Stage, ACAUnitsSubjects."Stage Code");
            ACACourseRegistration.SETRANGE(Programmes, Prog);
            ACACourseRegistration.SETRANGE("Year Of Study", YearOfStudy);
            ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
            IF ACACourseRegistration.FIND('-') THEN BEGIN
                IF ACACourseRegistration.Semester <> '' THEN Semz := ACACourseRegistration.Semester;
            END ELSE BEGIN
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE("Student No.", StudNo);
                ACACourseRegistration.SETRANGE(Programmes, Prog);
                ACACourseRegistration.SETRANGE("Year Of Study", YearOfStudy);
                ACACourseRegistration.SETFILTER(Reversed, '=%1', FALSE);
                IF ACACourseRegistration.FIND('+') THEN BEGIN
                    IF ACACourseRegistration.Semester <> '' THEN Semz := ACACourseRegistration.Semester;
                END;
            END;

        END;
    end;

    local procedure GetUnitStage(UnitCodezz: Code[20]; Progzz: Code[20]) StageCode: Code[20]
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCodezz);
        ACAUnitsSubjects.SETRANGE("Programme Code", Progzz);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            StageCode := ACAUnitsSubjects."Stage Code";
        END;
    end;

    local procedure GetUnitName(UnitCode: Code[20]; Prog: Code[20]) UntName: Code[150]
    begin
        ACAUnitsSubjects.RESET;
        ACAUnitsSubjects.SETRANGE(Code, UnitCode);
        ACAUnitsSubjects.SETRANGE("Programme Code", Prog);
        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
            UntName := ACAUnitsSubjects.Desription;
        END;
    end;
}

