/// <summary>
/// Report Summary Graduation List (ID 51564).
/// </summary>
report 51564 "Summary Graduation List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Summary Graduation List.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Semester Filter", "Stage Filter";
            column(EXAM_PERIOD____FORMAT_DATE2DMY_Semesters_From_3__; 'EXAM PERIOD: ' + FORMAT(DATE2DMY(Semesters.From, 3)))
            {
            }
            column(PROGRAMME____Programme_Description; 'PROGRAMME: ' + "ACA-Programme".Description)
            {
            }
            column(FORMAT_UPPERCASE_Depts_Description__; FORMAT(UPPERCASE(Depts.Description)))
            {
            }
            column(FORMAT_UPPERCASE_Dimensions_Name__; FORMAT(UPPERCASE(Dimensions.Name)))
            {
            }
            column(SEMESTER____Semesters_Description; 'SEMESTER: ' + Semesters.Description)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(KIMATHI_UNIVERISTYCaption; KIMATHI_UNIVERISTYCaptionLbl)
            {
            }
            column(UNIVERSITY_EXAMINATIONS_Caption; UNIVERSITY_EXAMINATIONS_CaptionLbl)
            {
            }
            column(GRADUATION_LIST_SUMMARYCaption; GRADUATION_LIST_SUMMARYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Final_StageCaption; Final_StageCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Stage_Filter; "Stage Filter")
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code),
                               Code = FIELD("Stage Filter");
                //DataItemTableView = WHERE("Reg. ID"=CONST('YES'));
                column(ProgDesc; ProgDesc)
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages__Programme_Stages___Programme_Code_; "ACA-Programme Stages"."Programme Code")
                {
                }
                column(Pass; Pass)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "ACA-Programme Stages".CALCFIELDS("ACA-Programme Stages"."Pass Count");
                    Pass := Pass + "ACA-Programme Stages"."Pass Count";
                    /*
                    ProcessedSenate.RESET;
                    ProcessedSenate.SETRANGE(ProcessedSenate.Programme,"Programme Stages"."Programme Code");
                    ProcessedSenate.SETRANGE(ProcessedSenate.Stage,"Programme Stages".Code);
                    ProcessedSenate.SETRANGE(ProcessedSenate.Semester,Programme.GETFILTER("Semester Filter"));
                    IF ProcessedSenate.FIND('-') THEN
                    ProcessedSenate.DELETEALL;
                    
                    Registration.RESET;
                    Registration.SETRANGE(Registration.Programme,"Programme Stages"."Programme Code");
                    Registration.SETRANGE(Registration.Semester,Programme.GETFILTER("Semester Filter"));
                    Registration.SETRANGE(Registration.Stage,"Programme Stages".Code);
                    Registration.SETRANGE(Registration.Reversed,FALSE);
                    IF Registration.FIND('-') THEN REPEAT
                     ProcessedSenate.INIT;
                     ProcessedSenate.Programme:="Programme Stages"."Programme Code";
                     ProcessedSenate.Stage:="Programme Stages".Code;
                     ProcessedSenate.StudentNo:=Registration."Student No.";
                     ProcessedSenate.Semester:=Programme.GETFILTER("Semester Filter");
                     IF Student.GET(Registration."Student No.") THEN
                     ProcessedSenate.Status:=FORMAT(Student.Status);
                     IF Registration."Registration Status" <> 0 THEN
                     ProcessedSenate.Status:=FORMAT(Registration."Registration Status");
                     IF SenateEntry.GET(Registration.Programme,Registration.Stage,Registration.Semester,Registration."Student No.")=FALSE THEN
                      ProcessedSenate.INSERT;
                     ProgressWindow.UPDATE(1,Registration."Student No.");
                    
                    UNTIL Registration.NEXT = 0;
                    
                    
                    
                    SRProcess.RESET;
                    SRProcess.SETRANGE(Programme,"Programme Stages"."Programme Code");
                    SRProcess.SETRANGE(Semester,Programme.GETFILTER("Semester Filter"));
                    SRProcess.SETRANGE(Stage,"Programme Stages".Code);
                    IF SRProcess.FIND('-') THEN BEGIN
                    REPEAT
                    SRProcess.CALCFIELDS("TotalPassed Cumulatively","TotalPerProgramme Cumulatively");
                    
                    
                    IF SRProcess."TotalPassed Cumulatively" >= SRProcess."TotalPerProgramme Cumulatively" THEN
                    Pass:=Pass+1
                    
                    UNTIL SRProcess.NEXT = 0;
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Semester Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Date Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Pass := 0;
                Supp := 0;
                Rep := 0;

                TotalIncome := 0;
                TotalReg := 0;
                ProgDesc := "ACA-Programme".Description;
                ProgressWindow.OPEN('Processing Report #1############');


                //GET YEAR OF STUDY
                Semesters.RESET;
                Semesters.SETRANGE(Semesters.Code, "ACA-Programme".GETFILTER("Semester Filter"));
                IF Semesters.FIND('-') THEN
                    //YEAR



                    //GET DEPT
                    Dimensions.RESET;
                Dimensions.SETRANGE(Dimensions."Dimension Code", 'DEPARTMENT');
                Dimensions.SETRANGE(Dimensions.Code, "ACA-Programme"."School Code");
                IF Dimensions.FIND('-') THEN
                    //DEPT

                    //GET FACULTY
                    FacDesc := '';
                Depts.RESET;
                Depts.SETRANGE(Depts.Code, Faculty);
                IF Depts.FIND('-') THEN BEGIN
                    FacDesc := 'DEAN ' + FORMAT(UPPERCASE(Depts.Description));
                END;

                //END FACULTY
            end;

            trigger OnPreDataItem()
            begin
                IF "ACA-Programme".GETFILTER(Code) = '' THEN
                    ERROR('Please specify the Programme/Course filter.');
                IF "ACA-Programme".GETFILTER("Semester Filter") = '' THEN
                    ERROR('Please specify the Semester filter.');
                IF (AcademicYr = '') THEN
                    //ERROR('Please define the academic year for this report');

                    // Update Students units results
                    StudUnits.RESET;
                StudUnits.SETFILTER(StudUnits.Programme, "ACA-Programme".GETFILTER(Code));
                StudUnits.SETFILTER(StudUnits.Stage, "ACA-Programme".GETFILTER("Stage Filter"));
                StudUnits.SETFILTER(StudUnits.Semester, "ACA-Programme".GETFILTER("Semester Filter"));
                IF StudUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Total Score");
                        StudUnits.CALCFIELDS(StudUnits."Registration Status");
                        StudUnits."Final Score" := StudUnits."Total Score";
                        IF GetGradeStatus(StudUnits."Total Score", StudUnits.Programme) = FALSE THEN BEGIN
                            StudUnits."Result Status" := 'PASS';
                        END ELSE BEGIN
                            StudUnits."Result Status" := 'FAIL';
                        END;
                        IF StudUnits."Total Score" = 0 THEN
                            StudUnits."Result Status" := 'FAIL';

                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", StudUnits."Student No.");
                        CReg.SETRANGE(CReg.Programmes, StudUnits.Programme);
                        CReg.SETRANGE(CReg.Semester, StudUnits.Semester);
                        CReg.SETRANGE(CReg.Stage, StudUnits.Stage);
                        IF CReg.FIND('-') THEN BEGIN
                            CReg.CALCFIELDS(CReg."Units Taken");
                            CReg.CALCFIELDS(CReg."Units Failed");
                            CReg.CALCFIELDS(CReg."Units Passed");

                            ExamsDone := CReg."Units Taken";
                            FailCount := CReg."Units Failed";


                            IF COPYSTR(FORMAT(ExamsDone / 2), 2, 2) = '.' THEN BEGIN
                                IF (ExamsDone <> 0) AND (FailCount <> 0) THEN
                                    IF (ExamsDone / (FailCount + 1)) <= 2 THEN
                                        StudUnits."Result Status" := 'REPEAT';
                            END ELSE BEGIN
                                IF (ExamsDone <> 0) AND (FailCount <> 0) THEN
                                    IF (ExamsDone / FailCount) <= 2 THEN
                                        StudUnits."Result Status" := 'REPEAT';
                                ;
                            END;
                            CReg.CALCFIELDS(CReg."Units Passed");
                            CReg.CALCFIELDS(CReg."Units Failed");
                            CReg.CALCFIELDS(CReg."Units Repeat");

                            CReg."Exam Status" := '';
                            IF (CReg."Units Failed" = 0) AND (CReg."Units Repeat" = 0) AND (CReg."Units Passed" <> 0) THEN
                                CReg."Exam Status" := 'PASS';
                            IF (CReg."Units Failed" <> 0) THEN
                                CReg."Exam Status" := 'FAIL';
                            IF (CReg."Units Repeat" <> 0) THEN
                                CReg."Exam Status" := 'REPEAT';

                            IF CReg."Registration Status" <> 0 THEN
                                CReg."Exam Status" := FORMAT(CReg."Registration Status");

                            CReg.MODIFY;
                        END;
                        IF StudUnits."Registration Status" <> 0 THEN
                            StudUnits."Result Status" := FORMAT(StudUnits."Registration Status");
                        StudUnits.MODIFY;
                    UNTIL StudUnits.NEXT = 0;
                END;
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

    var
        TotalIncome: Decimal;
        TotalReg: Integer;
        Sem: Text[250];
        ProgDesc: Text[250];
        Pass: Integer;
        Supp: Integer;
        Rep: Integer;
        AcademicYr: Text[30];
        Depts: Record 61587;
        Semesters: Record 61518;
        Dimensions: Record 349;
        FacDesc: Text[250];
        Registration: Record 61532;
        Student: Record 18;
        ProgressWindow: Dialog;
        StudUnits: Record 61549;
        CReg: Record 61532;
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record 18;
        Prog: Record 61511;
        Stages: Record 61516;
        KIMATHI_UNIVERISTYCaptionLbl: Label 'KIMATHI UNIVERISTY';
        UNIVERSITY_EXAMINATIONS_CaptionLbl: Label 'UNIVERSITY EXAMINATIONS ';
        GRADUATION_LIST_SUMMARYCaptionLbl: Label 'GRADUATION LIST SUMMARY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ProgrammeCaptionLbl: Label 'Programme';
        Final_StageCaptionLbl: Label 'Final Stage';
        CodeCaptionLbl: Label 'Code';
        TotalCaptionLbl: Label 'Total';

    /// <summary>
    /// GetGradeStatus.
    /// </summary>
    /// <param name="AvMarks">VAR Decimal.</param>
    /// <param name="ProgCode">VAR Code[20].</param>
    /// <returns>Return variable F of type Boolean.</returns>
    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]) F: Boolean
    var
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
        ProgrammeRec: Record 61511;
    begin
        F := FALSE;

        GradeCategory := '';
        ProgrammeRec.RESET;
        IF ProgrammeRec.GET(ProgCode) THEN
            GradeCategory := ProgrammeRec."Exam Category";
        IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');

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

                            F := Gradings.Failed;
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;
}

