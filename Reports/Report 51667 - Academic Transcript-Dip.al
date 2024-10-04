report 51667 "Academic Transcript-Dip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Academic Transcript-Dip.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
                                ORDER(Ascending)
                                WHERE(Reversed = CONST(false),
                                      "Trans Count" = FILTER(> 0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Programme Filter", "Stage Filter", "Semester Filter", "Student No.";
            column(Names; Names)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(FacultyDesc; FacultyDesc)
            {
            }
            column(ProgDesc; ProgDesc)
            {
            }
            column(Course_Registration__Course_Registration___Academic_Year_; "ACA-Course Registration"."Academic Year")
            {
            }
            column(PROVISIONAL___UPPERCASE_FORMAT_ProgrammeRec_Category_____ACADEMIC_TRANSCRIPT__; 'PROVISIONAL ' + UPPERCASE(FORMAT(ProgrammeRec.Category)) + ' ACADEMIC TRANSCRIPT*')
            {
            }
            column(DeptDesc; DeptDesc)
            {
            }
            column(LevelDesc; LevelDesc)
            {
            }
            column(Course_Registration__Course_Registration__Stage; "ACA-Course Registration".Stage)
            {
            }
            column(This_transcript_is_issued_without_any_erasures_or_alterations__; '* This transcript is issued without any erasures or alterations.')
            {
            }
            column(Dean____FacultyDesc; 'Dean, ' + FacultyDesc)
            {
            }
            column(DataItem1102755003; '1 unit consist of 35 lecture hours or equivalent (3 Practicle hours of two tutorial hours are equivalent to 1 lecture hour)')
            {
            }
            column(GLabel2_1_; GLabel2[1])
            {
            }
            column(GLabel2_2_; GLabel2[2])
            {
            }
            column(GLabel2_3_; GLabel2[3])
            {
            }
            column(GLabel2_4_; GLabel2[4])
            {
            }
            column(GLabel2_5_; GLabel2[5])
            {
            }
            column(PassRemark; PassRemark)
            {
            }
            column(GLabel_3_; GLabel[3])
            {
            }
            column(GLabel_2_; GLabel[2])
            {
            }
            column(GLabel_1_; GLabel[1])
            {
            }
            column(GLabel_4_; GLabel[4])
            {
            }
            column(GLabel_5_; GLabel[5])
            {
            }
            column(ThisGrade; ThisGrade)
            {
            }
            column(MASENO_UNIVERSITYSCaption; MASENO_UNIVERSITYSCaptionLbl)
            {
            }
            column(NAME__Caption; NAME__CaptionLbl)
            {
            }
            column(Unit_TitleCaption; Unit_TitleCaptionLbl)
            {
            }
            column(Unit_CodeCaption; Unit_CodeCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(REG_NO___Caption; REG_NO___CaptionLbl)
            {
            }
            column(SCHOOL_Caption; SCHOOL_CaptionLbl)
            {
            }
            column(COURSE_Caption; COURSE_CaptionLbl)
            {
            }
            column(ACADEMIC_YEAR_Caption; ACADEMIC_YEAR_CaptionLbl)
            {
            }
            column(Units_s_Caption; Units_s_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755055; EmptyStringCaption_Control1102755055Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755056; EmptyStringCaption_Control1102755056Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755057; EmptyStringCaption_Control1102755057Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755059; EmptyStringCaption_Control1102755059Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755032; EmptyStringCaption_Control1102755032Lbl)
            {
            }
            column(DEPARTMENT_Caption; DEPARTMENT_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000002; EmptyStringCaption_Control1000000002Lbl)
            {
            }
            column(YEAR_OF_STUDY_Caption; YEAR_OF_STUDY_CaptionLbl)
            {
            }
            column(SEMESTER_Caption; SEMESTER_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755046; EmptyStringCaption_Control1102755046Lbl)
            {
            }
            column(Date____________________________Caption; Date____________________________CaptionLbl)
            {
            }
            column(Signed________________________________________________Caption; Signed________________________________________________CaptionLbl)
            {
            }
            column(NB_Caption; NB_CaptionLbl)
            {
            }
            column(KEY_TO_THE_GRADING_SYSTEMCaption; KEY_TO_THE_GRADING_SYSTEMCaptionLbl)
            {
            }
            column(RECOMMENDATION_Caption; RECOMMENDATION_CaptionLbl)
            {
            }
            column(MEAN_GRADECaption; MEAN_GRADECaptionLbl)
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
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               Stage = FIELD(Stage);
                DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.", ENo)
                                    ORDER(Ascending);
                column(Student_Units_Unit; Unit)
                {
                }
                column(UnitDesc; UnitDesc)
                {
                }
                column(Student_Units_Grade; Grade)
                {
                }
                column(Student_Units__Student_Units___No__Of_Units_; "ACA-Student Units"."No. Of Units")
                {
                }
                column(Student_Units_Programme; Programme)
                {
                }
                column(Student_Units_Stage; Stage)
                {
                }
                column(Student_Units_Semester; Semester)
                {
                }
                column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Student_Units_Student_No_; "Student No.")
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    no := no + 1;
                    "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Total Score");
                    TotUnits := TotUnits + 1;
                    TotMarks := TotMarks + "ACA-Student Units"."Total Score";

                    vAverage := '';
                    //vAverage := ClassifySemester(TotAvg);
                    IF AllowRound = TRUE THEN
                        Grade := GetGrade(ROUND("ACA-Student Units"."Total Score", 1, '='))
                    ELSE
                        Grade := GetGrade("ACA-Student Units"."Total Score");

                    IF Grade = 'E' THEN BEGIN
                        "ACA-Student Units"."Result Status" := 'FAIL';
                        "ACA-Student Units".MODIFY;
                    END;
                    UnitDesc := '';
                    RecUnits.RESET;
                    RecUnits.SETRANGE(RecUnits.Code, "ACA-Student Units".Unit);
                    RecUnits.SETRANGE(RecUnits."Programme Code", "ACA-Student Units".Programme);
                    IF RecUnits.FIND('-') THEN BEGIN
                        UnitDesc := RecUnits.Desription;
                        IF RecUnits.Attachment = TRUE THEN
                            Grade := 'PASS'
                    END;
                    IF "ACA-Student Units"."System Taken" = TRUE THEN
                        UnitDesc := "ACA-Student Units".Description;
                end;

                trigger OnPreDataItem()
                begin

                    TOTAL := 0;
                    ThisAverage := 0.0;
                    thisFinalScore := 0;
                    ThisGrade := '';
                    vAverage := '';
                    TotUnits := 0;

                    // "Student Units".SETFILTER("Student Units".Stage,'%1..%2','y1s1',"Course Registration".Stage);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotUnits := 0;
                TotMarks := 0;
                TotAvg := 0;

                //////////////GET THE STUDENT NAMES
                Customers.RESET;
                Customers.SETFILTER(Customers."No.", "ACA-Course Registration"."Student No.");
                IF Customers.FIND('-') THEN
                    Names := Customers.Name;
                /////////////GET THE STUDENT FACULTY
                ProgrammeRec.RESET;
                ProgrammeRec.SETFILTER(ProgrammeRec.Code, "ACA-Course Registration".Programmes);
                IF ProgrammeRec.FIND('-') THEN BEGIN
                    ProgDesc := ProgrammeRec.Description;
                    // Get Grade Labels
                    i := 1;
                    Gradings.RESET;
                    Gradings.SETRANGE(Gradings.Category, ProgrammeRec."Exam Category");
                    IF Gradings.FIND('-') THEN BEGIN
                        REPEAT
                            GLabel[i] := Gradings.Grade + ' - ' + Gradings.Range;
                            GLabel2[i] := ' - ' + Gradings.Description;
                            i := i + 1;
                        UNTIL Gradings.NEXT = 0;
                    END;

                END;
                BEGIN
                    DimensionTables.RESET;
                    DimensionTables.SETFILTER(DimensionTables.Code, ProgrammeRec."School Code");
                    IF DimensionTables.FIND('-') THEN BEGIN
                        FacultyDesc := DimensionTables.Name;
                    END;
                END;

                DimensionTables.RESET;
                DimensionTables.SETFILTER(DimensionTables.Code, ProgrammeRec."Department Code");
                IF DimensionTables.FIND('-') THEN BEGIN
                    DeptDesc := DimensionTables.Name;
                END;


                /*
                Semesters.RESET;
                Semesters.SETFILTER(Semesters.Code,"Course Registration".Semester);
                IF Semesters.FIND('-') THEN
                LevelDesc := LevelDesc + ' ' + Semesters.Description;
                */

                //////////////////GENERATE THE STUDENT UNITS/////////////
                thisCount := 1;
                RecUnits.RESET;
                RecUnits.SETFILTER(RecUnits."Programme Code", "ACA-Course Registration".Programmes);
                RecUnits.SETFILTER(RecUnits."Stage Code", "ACA-Course Registration".Stage);
                IF RecUnits.FIND('-') THEN BEGIN
                    REPEAT
                        thisUnit := RecUnits.Code;
                        thisUnitDesc := RecUnits.Desription;
                        thisCount := thisCount + 1;
                    UNTIL RecUnits.NEXT = 0
                END;
                ////////////////////////////////////////////////////////
                YOS := FORMAT("ACA-Course Registration".Stage);

                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Units Failed");

            end;

            trigger OnPreDataItem()
            begin
                "ACA-Course Registration".SETFILTER("ACA-Course Registration".Programmes, "ACA-Course Registration".GETFILTER(
                "ACA-Course Registration"."Programme Filter"));
                "ACA-Course Registration".SETFILTER("ACA-Course Registration".Stage, "ACA-Course Registration".GETFILTER(
                "ACA-Course Registration"."Stage Filter"));
                "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, "ACA-Course Registration".GETFILTER(
                "ACA-Course Registration"."Semester Filter"));
                IF ShowPassOnly = TRUE THEN
                    "ACA-Course Registration".SETFILTER("ACA-Course Registration"."Cum Units Failed", '%1', 0);
                LevelDesc := '';
                Stages.RESET;
                Stages.SETFILTER(Stages."Programme Code", "ACA-Course Registration".GETFILTER("ACA-Course Registration".Programmes));
                Stages.SETFILTER(Stages.Code, "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage));
                IF Stages.FIND('-') THEN
                    LevelDesc := Stages.Description;
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
        vAverage: Text[30];
        YOS: Text[30];
        Durations: Text[30];
        thisFinalScore: Integer;
        FinalFinal: Integer;
        ExamTotals: Decimal;
        CATotals: Decimal;
        no: Integer;
        Stages: Record 61516;
        Semesters: Record 61518;
        UnitDesc: Text[120];
        Marks: Integer;
        Grade: Text[50];
        RecUnits: Record 61517;
        "%FIRST": Decimal;
        "%SECND": Decimal;
        "%FINAL": Integer;
        ThisGrade: Text[30];
        "Average": Decimal;
        TOTAL: Integer;
        ThisAverage: Decimal;
        ExamRemark: Text[50];
        Classification: Text[50];
        ThisAverageGrade: Text[30];
        StageGrade: Text[30];
        FailCount: Integer;
        RecStudUnits: Record 61549;
        UnitCount: Integer;
        Programmes: Text[50];
        Stage: Text[50];
        Semester: Text[50];
        Names: Text[150];
        Customers: Record 18;
        ProgrammeRec: Record 61511;
        FacultyDesc: Text[150];
        Department: Text[150];
        DimensionTables: Record 349;
        ProgDesc: Text[150];
        LevelDesc: Text[150];
        thisCount: Integer;
        thisUnit: Code[50];
        thisUnitDesc: Text[150];
        Results: Record 61548;
        TotUnits: Integer;
        TotMarks: Decimal;
        TotAvg: Decimal;
        Proceed: Boolean;
        "Progrm Grading": Record 61594;
        "Default Grading": Record 61599;
        LastGrade: Code[50];
        LastRemark: Code[50];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GradeCategory: Code[50];
        GLabel: array[6] of Code[50];
        PassRemark: Text[200];
        GLabel2: array[6] of Code[100];
        TotalMarks: Decimal;
        i: Integer;
        CReg: Record 61532;
        DeptDesc: Text[100];
        AllowRound: Boolean;
        ShowPassOnly: Boolean;
        MASENO_UNIVERSITYSCaptionLbl: Label 'DEDAN MASENO UNIVERSITY OF TECHNOLOGY';
        NAME__CaptionLbl: Label 'NAME: ';
        Unit_TitleCaptionLbl: Label 'Unit Title';
        Unit_CodeCaptionLbl: Label 'Unit Code';
        GradeCaptionLbl: Label 'Grade';
        REG_NO___CaptionLbl: Label 'REG NO.: ';
        SCHOOL_CaptionLbl: Label 'SCHOOL:';
        COURSE_CaptionLbl: Label 'COURSE:';
        ACADEMIC_YEAR_CaptionLbl: Label 'ACADEMIC YEAR:';
        Units_s_CaptionLbl: Label 'Units(s)';
        EmptyStringCaptionLbl: Label '.................................................................................................................';
        EmptyStringCaption_Control1102755055Lbl: Label '.................................................................................................................';
        EmptyStringCaption_Control1102755056Lbl: Label '.................................................................................................................................................................................';
        EmptyStringCaption_Control1102755057Lbl: Label '.................................................................................................................';
        EmptyStringCaption_Control1102755059Lbl: Label '.................................................................................................................................................................................';
        EmptyStringCaption_Control1102755032Lbl: Label '.................................................................................................................................................................................';
        DEPARTMENT_CaptionLbl: Label 'DEPARTMENT:';
        EmptyStringCaption_Control1000000002Lbl: Label '.................................................................................................................';
        YEAR_OF_STUDY_CaptionLbl: Label 'YEAR OF STUDY:';
        SEMESTER_CaptionLbl: Label 'SEMESTER:';
        EmptyStringCaption_Control1102755046Lbl: Label '.................................................................................................................';
        Date____________________________CaptionLbl: Label 'Date:___________________________';
        Signed________________________________________________CaptionLbl: Label 'Signed________________________________________________';
        NB_CaptionLbl: Label 'NB:';
        KEY_TO_THE_GRADING_SYSTEMCaptionLbl: Label 'KEY TO THE GRADING SYSTEM';
        RECOMMENDATION_CaptionLbl: Label 'RECOMMENDATION:';
        MEAN_GRADECaptionLbl: Label 'MEAN GRADE';

    procedure GetUnitDesc(var Unit: Code[100])
    begin
    end;

    procedure CalculateFinalScore(var StudentNo: Code[150]; var Unit: Code[150]) FinalScore: Decimal
    begin
        /*
        RecExamsRes.RESET;
        "%FINAL" := 0.0;
        CATotals := 0;
        ExamTotals := 0;
        FinalFinal := 0;
        thisFinalScore := 0;
        "%FIRST" := 0;
        "%SECND" := 0;
        RecExamsRes.SETFILTER(RecExamsRes."Student No.",StudentNo);
        RecExamsRes.SETFILTER(RecExamsRes.Unit,Unit);
        IF RecExamsRes.FIND('-') THEN
        BEGIN
             REPEAT
                  RecExams.RESET;
                  RecExams.SETFILTER(RecExams.Code,RecExamsRes."Exam Code");
                  IF RecExams.FIND('-') THEN
                  BEGIN
                       "%FIRST" := 0;
                       "%SECND" := 0;
        
                       IF (RecExamsRes.Result<>0) AND ((RecExams."Max.Score") <> 0) AND (RecExamsRes."New Score" <> 0) THEN
                       BEGIN
                       "%FIRST" := (((RecExamsRes."New Score")/(RecExams."Max.Score"))*100);
                       END
                       ELSE
                       BEGIN
                        "%FIRST" := ((RecExamsRes.Result)/(RecExams."Max.Score"))*100;
                       END;
                       "%SECND" := (((RecExams."Contribution %")/100)*("%FIRST"));
        
                  END;
                  BEGIN
                  IF RecExams.Type = 1 THEN
                  BEGIN
                       //FinalFinal := ROUND(FinalFinal + "%SECND",1,'=');
                       CATotals :=  (CATotals + "%SECND");
                  END;
                  IF RecExams.Type = 2 THEN
                  BEGIN
                       //FinalFinal := ROUND(FinalFinal + "%SECND",1,'=');
                       ExamTotals :=  (ExamTotals + "%SECND");
                  END;
                  END;
                  UNTIL (RecExamsRes.NEXT = 0);
                  //****************************************************************************
                     CATotals := ROUND(CATotals,1,'=');
                     ExamTotals := ROUND(ExamTotals,1,'=');
                     thisFinalScore :=  CATotals + ExamTotals;
                     IF (CATotals = 14) AND (ExamTotals > 35) THEN
                    BEGIN
                     CATotals := 15;
                     ExamTotals := ExamTotals - 1;
                    END;
                    IF (CATotals > 15) AND (ExamTotals = 34) THEN
                    BEGIN
                     CATotals := CATotals - 1;
                     ExamTotals := 35;
                    END;
                    IF (CATotals < 14) AND (ExamTotals > 36) THEN
                     thisFinalScore := 50;
                    IF (CATotals > 15) AND (ExamTotals < 34) THEN
                     thisFinalScore := 50;
        
                  //****************************************************************************
        
        END;
        GetGrade(thisFinalScore,RecExams.Code);
        TOTAL :=  thisFinalScore;
        GetAverage(TOTAL);
        */

    end;

    procedure GetGrade(Marks: Decimal) xGrade: Text[100]
    begin
        GradeCategory := '';
        ProgrammeRec.RESET;
        IF ProgrammeRec.GET("ACA-Student Units".Programme) THEN
            GradeCategory := ProgrammeRec."Exam Category";
        IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
        ExamRemark := '';
        PassRemark := '';
        xGrade := '';
        RecUnits.RESET;
        RecUnits.SETFILTER(RecUnits.Code, "ACA-Student Units".Unit);
        IF RecUnits.FIND('-') THEN UnitDesc := RecUnits.Desription;
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
                            PassRemark := Gradings.Remarks;
                            ExamRemark := Gradings.Description;
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

    procedure GetAverage(var Score: Integer) "Average": Decimal
    begin

        /*IF TOTAL <> 0 THEN
        BEGIN
        "Student Exam Registration/Unit".RESET;
        "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit"."Student No.","Course Registration"."Student No.");
        "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Programme,"Course Registration".Programme);
        "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Stage,"Course Registration".Stage);
        //"Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Semester,"Course Registration".Semester);
        IF "Student Exam Registration/Unit".FIND('-') THEN
        "Student Exam Registration/Unit".CALCFIELDS("Student Exam Registration/Unit".UnitCount);
        IF "Student Exam Registration/Unit".UnitCount <> 0 THEN
        ThisAverage := ROUND(TOTAL/"Student Exam Registration/Unit".UnitCount,1,'=');
        //GetAverageGrade(ThisAverage);
        END;
        */

    end;

    procedure GetAverageGrade(var "Average": Decimal) Grade: Text[100]
    begin
        /*    BEGIN
                 RecExamGrades.RESET;
                 RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
                 RecExamGrades.SETFILTER(RecExamGrades.ExamCode,'DEFAULT');
                 IF RecExamGrades.FIND('-') THEN
                 BEGIN
                      REPEAT
                      IF ThisAverage < RecExamGrades.Upto THEN
                      BEGIN
                           ThisAverageGrade := RecExamGrades.Remark;
                           EXIT(ThisAverageGrade);
                      END;
                      UNTIL RecExamGrades.NEXT = 0;
                 END
            END
        */

    end;
}

