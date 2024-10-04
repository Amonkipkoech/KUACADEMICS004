report 51722 "Exams Award List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exams Award List.rdl';

    dataset
    {
        dataitem("ACA-Results Status"; "ACA-Results Status")
        {
            DataItemTableView = WHERE(Code = CONST('PASS'));
            RequestFilterFields = "Programme Filter", "Stage Filter", "Semester Filter";
            column(Logo; CompInf.Picture)
            {
            }
            column(CompanyName; CompInf.Name)
            {
            }
            column(University_EXAMINATIONS; 'University EXAMINATIONS  ')
            {
            }
            column(FORMAT_UPPERCASE_Depts_Description__; FORMAT(UPPERCASE(Depts.Description)))
            {
            }
            column(FORMAT_UPPERCASE_Dimensions_Name_______DEPARTMENT_; FORMAT(UPPERCASE(DeptDesc)) + ' DEPARTMENT')
            {
            }
            column(Semesters_Description_____ORDINARY_EXAMS_; Semesters.Description + ' ORDINARY EXAMS')
            {
            }
            column(USERID; USERID)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(Status_Msg1______FORMAT__Students_Count________Status_Msg2______FacDesc_____msg_____ProgDesc_____msg2_____Awrd__msg3; "Status Msg1" + ' ' + FORMAT("Students Count") + ' ' + "Status Msg2" + ' ' + FacDesc + ' ' + msg + ' ' + ProgDesc + ' ' + msg2 + ' ' + Awrd + msg3)
            {
            }
            column(AWARD_LIST_; 'AWARD LIST')
            {
            }
            column(Dean____FacDesc; 'Dean, ' + FacDesc)
            {
            }
            column(Chairman_of_Senate_; 'Chairman of Senate')
            {
            }
            column(ProgDesc; ProgDesc)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755022; EmptyStringCaption_Control1102755022Lbl)
            {
            }
            column(Results_Status_Code; Code)
            {
            }
            column(Results_Status_Programme_Filter; "Programme Filter")
            {
            }
            column(Results_Status_Stage_Filter; "Stage Filter")
            {
            }
            column(Results_Status_Semester_Filter; "Semester Filter")
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD("Programme Filter"),
                               Stage = FIELD("Stage Filter"),
                               "Exam Status" = FIELD(Code),
                               Semester = FIELD("Semester Filter");
#pragma warning disable AL0254
                DataItemTableView = SORTING("Exam Grade")
#pragma warning restore AL0254
                                    ORDER(Ascending);
                RequestFilterFields = "Exam Grade";
                column(S_N_; 'S/N')
                {
                }
                column(REG__NO_; 'REG. NO')
                {
                }
                column(NAME_; 'NAME')
                {
                }
                column(Course_Registration__Exam_Grade_; "Exam Grade")
                {
                }
                column(Course_Registration__Student_No__; "Student No.")
                {
                }
                column(Cust_Name; Cust.Name)
                {
                }
                column(N; N)
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Programme; Programmes)
                {
                }
                column(Course_Registration_Semester; Semester)
                {
                }
                column(Course_Registration_Register_for; "Register for")
                {
                }
                column(Course_Registration_Stage; Stage)
                {
                }
                column(Course_Registration_Unit; Unit)
                {
                }
                column(Course_Registration_Student_Type; "Student Type")
                {
                }
                column(Course_Registration_Entry_No_; "Entry No.")
                {
                }
                column(Course_Registration_Exam_Status; "Exam Status")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                        StudentsL := '';
                    IF ("ACA-Results Status".Code = 'FAIL') THEN BEGIN
                        StudUnits.RESET;
                        // StudUnits.SETRANGE(StudUnits.Programme,"Course Registration".Programme);
                        StudUnits.SETRANGE(StudUnits.Stage, "ACA-Course Registration".Stage);
                        StudUnits.SETRANGE(StudUnits.Semester, "ACA-Course Registration".Semester);
                        StudUnits.SETRANGE(StudUnits."Result Status", "ACA-Course Registration"."Exam Status");
                        StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                        StudUnits.SETFILTER(StudUnits."Supp Taken", '%1', FALSE);
                        IF StudUnits.FIND('-') THEN BEGIN
                            REPEAT
                                StudentsL := StudUnits.Unit + ',' + StudentsL
                            UNTIL StudUnits.NEXT = 0;
                        END;
                    END;

                    IF ("ACA-Results Status".Code = 'SPECIAL') THEN BEGIN
                        StudUnits.RESET;
                        //  StudUnits.SETRANGE(StudUnits.Programme,"Course Registration".Programme);
                        StudUnits.SETRANGE(StudUnits.Stage, "ACA-Course Registration".Stage);
                        StudUnits.SETRANGE(StudUnits.Semester, "ACA-Course Registration".Semester);
                        StudUnits.SETRANGE(StudUnits."Result Status", "ACA-Course Registration"."Exam Status");
                        StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                        StudUnits.SETFILTER(StudUnits."Supp Taken", '%1', FALSE);
                        IF StudUnits.FIND('-') THEN BEGIN
                            REPEAT
                                // StudUnits.CALCFIELDS(StudUnits."Exam Marks");
                                // IF StudUnits."Exam Marks"=0 THEN
                                StudentsL := StudUnits.Unit + ',' + StudentsL
                            UNTIL StudUnits.NEXT = 0;
                        END;
                    END;

                    IF ("ACA-Results Status".Code = 'ACADEMIC LEAVE') THEN
                        StudentsL := "ACA-Course Registration".Remarks;


                    N := N + 1;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Exam Grade");

                    CReg.RESET;
                    CReg.SETFILTER(CReg.Programmes, "ACA-Results Status".GETFILTER("ACA-Results Status"."Programme Filter"));
                    CReg.SETFILTER(CReg.Stage, "ACA-Results Status".GETFILTER("ACA-Results Status"."Stage Filter"));
                    CReg.SETFILTER(CReg.Semester, "ACA-Results Status".GETFILTER("ACA-Results Status"."Semester Filter"));
                    AverageMarks := 0;
                    IF CReg.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits.Stage, CReg.Stage);
                            StudUnits.SETRANGE(StudUnits.Semester, CReg.Semester);
                            StudUnits.SETRANGE(StudUnits."Result Status", 'PASS');
                            StudUnits.SETRANGE(StudUnits."Student No.", CReg."Student No.");
                            StudUnits.SETFILTER(StudUnits."Supp Taken", '%1', FALSE);
                            IF StudUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    StudUnits.CALCFIELDS(StudUnits."Total Score");
                                    AverageMarks := AverageMarks + StudUnits."Total Score";
                                UNTIL StudUnits.NEXT = 0;
                            END;

                            CReg.CALCFIELDS(CReg."Units Taken");
                            IF (AverageMarks <> 0) AND (CReg."Units Taken" <> 0) THEN BEGIN
                                AverageMarks := AverageMarks / CReg."Units Taken";
                                CReg."Exam Grade" := GetGradeClassification(AverageMarks, CReg.Programmes);
                                CReg.MODIFY;
                            END;
                        UNTIL CReg.NEXT = 0;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "ACA-Results Status".CALCFIELDS("ACA-Results Status"."Students Count");
                N := 0;
            end;

            trigger OnPreDataItem()
            begin
                IF CompInf.GET() THEN
                    CompInf.CALCFIELDS(CompInf.Picture);

                // Labels
                //GET YEAR OF STUDY
                Semesters.RESET;
                Semesters.SETRANGE(Semesters.Code, "ACA-Results Status".GETFILTER("Semester Filter"));
                IF Semesters.FIND('-') THEN
                    //YEAR

                    // Prog.GET("Results Status".GETFILTER("Results Status"."Programme Filter"));
                    Prog.SETFILTER(Prog.Code, "ACA-Results Status".GETFILTER("ACA-Results Status"."Programme Filter"));
                IF Prog.FIND('-') THEN BEGIN
                    ProgDesc := Prog.Description;
                    //GET DEPT
                    Dimensions.RESET;
                    Dimensions.SETRANGE(Dimensions."Dimension Code", 'DEPARTMENT');
                    Dimensions.SETRANGE(Dimensions.Code, Prog."Department Code");
                    IF Dimensions.FIND('-') THEN
                        DeptDesc := Dimensions.Name;
                    //DEPT

                    //GET FACULTY
                    FacDesc := '';
                    Dimensions.RESET;
                    Dimensions.SETRANGE(Dimensions."Dimension Code", 'SCHOOL');
                    Dimensions.SETRANGE(Dimensions.Code, Prog.Faculty);
                    IF Dimensions.FIND('-') THEN
                        FacDesc := Dimensions.Name;
                    //END FACULTY

                END;
                //End Labels

                AverageMarks := 0;
                // Update Students units results
                StudUnits.RESET;
                StudUnits.SETFILTER(StudUnits.Programme, "ACA-Results Status".GETFILTER("Programme Filter"));
                StudUnits.SETFILTER(StudUnits.Stage, "ACA-Results Status".GETFILTER("Stage Filter"));
                StudUnits.SETFILTER(StudUnits.Semester, "ACA-Results Status".GETFILTER("Semester Filter"));
                IF StudUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Total Score");
                        StudUnits.CALCFIELDS(StudUnits."Registration Status");
                        StudUnits."Final Score" := StudUnits."Total Score";
                        AverageMarks := AverageMarks + StudUnits."Total Score";
                        Grd := '';
                        StudUnits.Failed := FALSE;
                        IF GetGradeStatus(StudUnits."Total Score", StudUnits.Programme) = FALSE THEN BEGIN
                            StudUnits."Result Status" := 'PASS';
                        END ELSE BEGIN
                            StudUnits."Result Status" := 'FAIL';
                            StudUnits.Failed := TRUE;
                        END;
                        IF StudUnits."Total Score" = 0 THEN
                            StudUnits."Result Status" := 'FAIL';

                        StudUnits.Grade := Grd;

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


                            CReg."Exam Grade" := GetGradeClassification(AverageMarks, CReg.Programmes);
                            CReg.MODIFY;
                        END;
                        IF StudUnits."Registration Status" <> 0 THEN
                            StudUnits."Result Status" := FORMAT(StudUnits."Registration Status");
                        StudUnits.MODIFY;
                    UNTIL StudUnits.NEXT = 0;
                END;
                //GetGrade(StudUnits."Total Score",StudUnits.Programme);
                msg := 'having successfully completed the course requirments for award of ';
                msg2 := ' and it is there fore recommended that they be awarded';
                msg3 := ' in the classification indicated ';
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        StudUnits: Record 61549;
        CReg: Record 61532;
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record 18;
        Semesters: Record 61518;
        Dimensions: Record 349;
        Prog: Record 61511;
        FacDesc: Code[100];
        Depts: Record 61587;
        Stages: Record 61516;
        StudentsL: Text[250];
        N: Integer;
        Grd: Code[50];
        Marks: Decimal;
        AverageMarks: Decimal;
        Awrd: Text[50];
        ProgDesc: Text[100];
        msg: Text[250];
        msg2: Text[250];
        msg3: Text[250];
        KIMATHI_UNIVERISTYCaptionLbl: Label 'KIMATHI UNIVERISTY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmptyStringCaptionLbl: Label '_______________________________________';
        EmptyStringCaption_Control1102755022Lbl: Label '_______________________________________';
        CompInf: Record 79;
        DeptDesc: Text[100];

    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]) F: Boolean
    var
        LastGrade: Code[50];
        LastRemark: Code[50];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GradeCategory: Code[50];
        GLabel: array[6] of Code[50];
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

    procedure GetGradeClassification(var AvMarks2: Decimal; var ProgCode2: Code[20]) CS: Code[50]
    var
        LastGrade2: Code[50];
        LastRemark2: Code[50];
        ExitDo2: Boolean;
        LastScore2: Decimal;
        Gradings2: Record 61599;
        Gradings3: Record 61599;
        GradeCategory2: Code[50];
        ProgrammeRec2: Record 61511;
    begin
        CS := '';

        GradeCategory2 := '';
        ProgrammeRec2.RESET;
        IF ProgrammeRec2.GET(ProgCode2) THEN
            GradeCategory2 := ProgrammeRec2."Exam Category";
        IF GradeCategory2 = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');

        IF AvMarks2 > 0 THEN BEGIN
            Gradings2.RESET;
            Gradings2.SETRANGE(Gradings2.Category, GradeCategory2);
            LastGrade2 := '';
            LastRemark2 := '';
            LastScore2 := 0;
            IF Gradings2.FIND('-') THEN BEGIN
                ExitDo2 := FALSE;
                REPEAT
                    LastScore2 := Gradings2."Up to";
                    IF AvMarks2 < LastScore2 THEN BEGIN
                        IF ExitDo2 = FALSE THEN BEGIN
                            Grd := Gradings2.Grade;
                            CS := Gradings2.Remarks;
                            ExitDo2 := TRUE;
                        END;
                    END;

                UNTIL Gradings2.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;
}

