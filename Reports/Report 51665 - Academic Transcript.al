report 51665 "Academic Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Academic Transcript.rdl';

    dataset
    {
        dataitem("ACA-Std Exam Registration/Unit"; "ACA-Std Exam Registration/Unit")
        {
            RequestFilterFields = Programmes, Stage, Semester;
            column(Student_Exam_Registration_Unit_Faculty; Faculty)
            {
            }
            column(Student_Exam_Registration_Unit__Student_No__; "Student No.")
            {
            }
            column(Student_Exam_Registration_Unit__Student_Name_; "Student Name")
            {
            }
            column(Student_Exam_Registration_Unit_Semester; Semester)
            {
            }
            column(Student_Exam_Registration_Unit_Stage; Stage)
            {
            }
            column(Student_Exam_Registration_Unit_Programme; Programme)
            {
            }
            column(Department; Department)
            {
            }
            column(Student_Exam_Registration_Unit_Unit; Unit)
            {
            }
            column(UnitDesc; UnitDesc)
            {
            }
            column(FINAL_; "%FINAL")
            {
            }
            column(ThisGrade; ThisGrade)
            {
            }
            column(ThisAverage; ThisAverage)
            {
            }
            column(ThisAverageGrade; ThisAverageGrade)
            {
            }
            column(ExamRemark; ExamRemark)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Faculty_Caption; Faculty_CaptionLbl)
            {
            }
            column(Admission_Number_Caption; Admission_Number_CaptionLbl)
            {
            }
            column(Name_of_Student__Caption; Name_of_Student__CaptionLbl)
            {
            }
            column(ACADEMIC_TRANSCRIPTCaption; ACADEMIC_TRANSCRIPTCaptionLbl)
            {
            }
            column(Course_Caption; Course_CaptionLbl)
            {
            }
            column(Mode_of_Study_Caption; Mode_of_Study_CaptionLbl)
            {
            }
            column(Academic_YearCaption; Academic_YearCaptionLbl)
            {
            }
            column(Unit_CodeCaption; Unit_CodeCaptionLbl)
            {
            }
            column(Unit_CodeCaption_Control1000000021; Unit_CodeCaption_Control1000000021Lbl)
            {
            }
            column(Marks__Caption; Marks__CaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Average_Mark_Caption; Average_Mark_CaptionLbl)
            {
            }
            column(Classification_of_Diploma_CertificateCaption; Classification_of_Diploma_CertificateCaptionLbl)
            {
            }
            column(Remark_on_Status_Caption; Remark_on_Status_CaptionLbl)
            {
            }
            column(Key_to_Grading_System_Caption; Key_to_Grading_System_CaptionLbl)
            {
            }
            column(MarksCaption; MarksCaptionLbl)
            {
            }
            column(ClassCaption; ClassCaptionLbl)
            {
            }
            column(V75____100_Caption; V75____100_CaptionLbl)
            {
            }
            column(V65____74_Caption; V65____74_CaptionLbl)
            {
            }
            column(V50____64_Caption; V50____64_CaptionLbl)
            {
            }
            column(V49__and_BelowCaption; V49__and_BelowCaptionLbl)
            {
            }
            column(FailCaption; FailCaptionLbl)
            {
            }
            column(DistinctionCaption; DistinctionCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(PassCaption; PassCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Pass_after_sitting_supplementaryCaption; Pass_after_sitting_supplementaryCaptionLbl)
            {
            }
            column(Signed_Caption; Signed_CaptionLbl)
            {
            }
            column(Dean_Caption; Dean_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Date_Caption_Control1000000056; Date_Caption_Control1000000056Lbl)
            {
            }
            column(Principal_Caption; Principal_CaptionLbl)
            {
            }
            column(This_transcript_has_been_issued_without_any_alterationsCaption; This_transcript_has_been_issued_without_any_alterationsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GetUnitDesc("ACA-Std Exam Registration/Unit".Unit);
                CalculateFinalScore("ACA-Std Exam Registration/Unit"."Student No.", "ACA-Std Exam Registration/Unit".Unit);
                GoToStudentUnits("ACA-Std Exam Registration/Unit"."Student No.");
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
        Department: Text[120];
        UnitDesc: Text[120];
        Marks: Decimal;
        Grade: Text[50];
        RecUnits: Record 61517;
        RecExamsRes: Record 61572;
        RecExams: Record 61526;
        "%FIRST": Decimal;
        "%SECND": Decimal;
        "%FINAL": Decimal;
        RecExamGrades: Record 61575;
        ThisGrade: Text[30];
        "Average": Decimal;
        TOTAL: Decimal;
        ThisAverage: Decimal;
        ExamRemark: Text[50];
        Classification: Text[50];
        ThisAverageGrade: Text[30];
        StageGrade: Text[30];
        FailCount: Decimal;
        RecStudUnits: Record 61549;
        UnitCount: Integer;
        Programme: Text[50];
        Stage: Text[50];
        Semester: Text[50];
        Department_CaptionLbl: Label 'Department:';
        Faculty_CaptionLbl: Label 'Faculty:';
        Admission_Number_CaptionLbl: Label 'Admission Number:';
        Name_of_Student__CaptionLbl: Label 'Name of Student: ';
        ACADEMIC_TRANSCRIPTCaptionLbl: Label 'ACADEMIC TRANSCRIPT';
        Course_CaptionLbl: Label 'Course:';
        Mode_of_Study_CaptionLbl: Label 'Mode of Study:';
        Academic_YearCaptionLbl: Label 'Academic Year';
        Unit_CodeCaptionLbl: Label 'Unit Code';
        Unit_CodeCaption_Control1000000021Lbl: Label 'Unit Code';
        Marks__CaptionLbl: Label 'Marks %';
        GradeCaptionLbl: Label 'Grade';
        Average_Mark_CaptionLbl: Label 'Average Mark:';
        Classification_of_Diploma_CertificateCaptionLbl: Label 'Classification of Diploma/Certificate';
        Remark_on_Status_CaptionLbl: Label 'Remark on Status:';
        Key_to_Grading_System_CaptionLbl: Label 'Key to Grading System:';
        MarksCaptionLbl: Label 'Marks';
        ClassCaptionLbl: Label 'Class';
        V75____100_CaptionLbl: Label '75% - 100%';
        V65____74_CaptionLbl: Label '65% - 74%';
        V50____64_CaptionLbl: Label '50% - 64%';
        V49__and_BelowCaptionLbl: Label '49% and Below';
        FailCaptionLbl: Label 'Fail';
        DistinctionCaptionLbl: Label 'Distinction';
        CreditCaptionLbl: Label 'Credit';
        PassCaptionLbl: Label 'Pass';
        EmptyStringCaptionLbl: Label '*';
        Pass_after_sitting_supplementaryCaptionLbl: Label 'Pass after sitting supplementary';
        Signed_CaptionLbl: Label 'Signed:';
        Dean_CaptionLbl: Label 'Dean:';
        Date_CaptionLbl: Label 'Date:';
        Date_Caption_Control1000000056Lbl: Label 'Date:';
        Principal_CaptionLbl: Label 'Principal:';
        This_transcript_has_been_issued_without_any_alterationsCaptionLbl: Label 'This transcript has been issued without any alterations';

    procedure GetUnitDesc(var Unit: Code[100])
    begin
        RecUnits.RESET;
        RecUnits.SETFILTER(RecUnits.Code, Unit);
        IF RecUnits.FIND('-') THEN BEGIN
            UnitDesc := RecUnits.Desription;
        END
    end;

    procedure CalculateFinalScore(var StudentNo: Code[150]; var Unit: Code[150]) FinalScore: Decimal
    begin
        RecExamsRes.RESET;
        "%FINAL" := 0;
        RecExamsRes.SETFILTER(RecExamsRes."Student No.", StudentNo);
        RecExamsRes.SETFILTER(RecExamsRes.Unit, Unit);
        IF RecExamsRes.FIND('-') THEN BEGIN
            REPEAT
                RecExams.RESET;
                RecExams.SETFILTER(RecExams.Code, RecExamsRes."Exam Code");
                IF RecExams.FIND('-') THEN BEGIN
                    "%FIRST" := 0;
                    "%SECND" := 0;
                    IF RecExamsRes."New Score" <> 0.0 THEN BEGIN
                        "%FIRST" := ((RecExamsRes."New Score") / (RecExams."Max.Score")) * 100;
                    END
                    ELSE BEGIN
                        "%FIRST" := ((RecExamsRes.Result) / (RecExams."Max.Score")) * 100;
                    END;
                    "%SECND" := (((RecExams."Contribution %") / 100) * ("%FIRST"));
                    "%FINAL" := "%FINAL" + "%SECND";
                END;
            UNTIL (RecExamsRes.NEXT = 0);

        END;
        GetGrade("%FINAL", RecExamsRes."Exam Code");
        TOTAL := TOTAL + "%FINAL";
        GetAverage(TOTAL);
    end;

    procedure GetGrade(var FinalScore: Decimal; var Exam: Code[130]) Grade: Text[100]
    begin
        /*
        RecExams.RESET;
        RecExams.SETFILTER(RecExams.Code,Exam);
        IF RecExams.FIND('-') THEN
        BEGIN
             IF RecExams."Grading System" = 1 THEN
        */
        BEGIN
            RecExamGrades.RESET;
            RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
            //RecExamGrades.ASCENDING(FALSE);
            RecExamGrades.SETFILTER(RecExamGrades.ExamCode, 'DEFAULT');
            IF RecExamGrades.FIND('-') THEN BEGIN
                REPEAT
                    IF FinalScore < RecExamGrades.Upto THEN BEGIN
                        ThisGrade := RecExamGrades.Grade;
                        EXIT;
                    END;
                UNTIL RecExamGrades.NEXT = 0;
            END
        END
        /*
             ELSE
             BEGIN
                  RecExamGrades.RESET;
                  RecExamGrades.SETFILTER(RecExamGrades.ExamCode,Exam);
                  IF RecExamGrades.FIND('-') THEN
                  BEGIN
                       REPEAT
                       IF FinalScore < RecExamGrades.Upto THEN
                       ThisGrade := RecExamGrades.Grade
                       UNTIL RecExamGrades.NEXT = 0;
                  END
        
             END;
        
        END
        */

    end;

    procedure GetAverage(var Score: Decimal) "Average": Decimal
    begin
        IF TOTAL <> 0 THEN BEGIN
            "ACA-Std Exam Registration/Unit".CALCFIELDS("ACA-Std Exam Registration/Unit".UnitCount);
            ThisAverage := (TOTAL / "ACA-Std Exam Registration/Unit".UnitCount);
            GetAverageGrade(ThisAverage);
        END;
    end;

    procedure GetAverageGrade(var "Average": Decimal) Grade: Text[100]
    begin
        BEGIN
            RecExamGrades.RESET;
            RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
            //RecExamGrades.ASCENDING(FALSE);
            RecExamGrades.SETFILTER(RecExamGrades.ExamCode, 'DEFAULT');
            IF RecExamGrades.FIND('-') THEN BEGIN
                REPEAT
                    IF ThisAverage < RecExamGrades.Upto THEN BEGIN
                        ThisAverageGrade := RecExamGrades.Remark;
                        EXIT;
                    END;
                UNTIL RecExamGrades.NEXT = 0;
            END
        END
    end;

    procedure GoToStudentUnits(var "StudentNo.": Code[120]) TotalFailed: Integer
    begin

        StageGrade := '';
        FailCount := 0.0;
        //"%FINAL" := 0.00;
        RecStudUnits.RESET;
        RecStudUnits.SETRANGE(RecStudUnits."Student No.", "StudentNo.");
        IF RecStudUnits.FIND('-') THEN
            RecStudUnits.CALCFIELDS(RecStudUnits.UnitCount);
        UnitCount := RecStudUnits.UnitCount;
        Programme := RecStudUnits.Programme;
        Stage := RecStudUnits.Stage;
        Semester := RecStudUnits.Semester;

        BEGIN
            REPEAT
                IF GoToStudentExams("StudentNo.", RecStudUnits.Unit) = 'FAIL' THEN BEGIN
                    FailCount := FailCount + 1;
                END;
            UNTIL (RecStudUnits.NEXT = 0);
        END;
        IF (FailCount = 0) THEN BEGIN
            ExamRemark := 'PROCEED';
        END;
        IF (FailCount > 0) AND (FailCount <= (RecStudUnits.UnitCount) / 2) THEN BEGIN
            ExamRemark := 'DEFERRED';
        END;
        IF (FailCount > 0) AND (FailCount >= (RecStudUnits.UnitCount) / 2) THEN BEGIN
            ExamRemark := 'REPEAT';
        END;
    end;

    procedure GoToStudentExams(var StudentNo: Code[150]; var Unit: Code[150]) UnitGrade: Text[50]
    begin
        /*
        RecExamsRes.RESET;
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
                       "%FIRST" := ((RecExamsRes.Result)/(RecExams."Max.Score"))*100;
                       "%SECND" := (((RecExams."Contribution %")/100)*("%FIRST"));
                       "%FINAL" := "%FINAL" + "%SECND";
        
                 END
                 UNTIL (RecExamsRes.NEXT = 0);
        
        
        END
        ELSE
        BEGIN
             "%FINAL" := 0.00;
        END;
        */
        BEGIN
            RecExamGrades.RESET;
            RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
            //RecExamGrades.ASCENDING(FALSE);
            RecExamGrades.SETFILTER(RecExamGrades.ExamCode, 'DEFAULT');
            IF RecExamGrades.FIND('-') THEN BEGIN
                REPEAT
                    IF "%FINAL" < RecExamGrades.Upto THEN BEGIN
                        ThisGrade := RecExamGrades.Remark;
                        UnitGrade := ThisGrade;
                        EXIT;
                    END;
                UNTIL RecExamGrades.NEXT = 0;
            END
        END;

    end;
}

