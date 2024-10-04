report 51664 "Academic Progress"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Academic Progress.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = Programmes, Stage, Semester, "Student No.";
            column(Names; Names)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(FacultyDesc; FacultyDesc)
            {
            }
            column(DepartmentDesc; DepartmentDesc)
            {
            }
            column(LevelDesc; LevelDesc)
            {
            }
            column(Course_Registration__Course_Registration___Student_Type_; "ACA-Course Registration"."Student Type")
            {
            }
            column(ProgDesc; ProgDesc)
            {
            }
            column(Course_Registration__Course_Registration___KSPS_No__; "ACA-Course Registration"."OLD No.")
            {
            }
            column(PROGRESS_REPORTCaption; PROGRESS_REPORTCaptionLbl)
            {
            }
            column(Name_of_Student__Caption; Name_of_Student__CaptionLbl)
            {
            }
            column(Admission_Number_Caption; Admission_Number_CaptionLbl)
            {
            }
            column(School_Caption; School_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Unit_DescriptionCaption; Unit_DescriptionCaptionLbl)
            {
            }
            column(Unit_CodeCaption; Unit_CodeCaptionLbl)
            {
            }
            column(Academic_YearCaption; Academic_YearCaptionLbl)
            {
            }
            column(Mode_of_Study_Caption; Mode_of_Study_CaptionLbl)
            {
            }
            column(Course_Caption; Course_CaptionLbl)
            {
            }
            column(CATS__30Caption; CATS__30CaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Registration_Caption; Registration_CaptionLbl)
            {
            }
            column(Exam__70Caption; Exam__70CaptionLbl)
            {
            }
            column(Total__100Caption; Total__100CaptionLbl)
            {
            }
            column(This_is_not_a_transcript_Caption; This_is_not_a_transcript_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Class_Teacher_Caption; Class_Teacher_CaptionLbl)
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
            column(ClassCaption; ClassCaptionLbl)
            {
            }
            column(Key_to_Grading_System_Caption; Key_to_Grading_System_CaptionLbl)
            {
            }
            column(MarksCaption; MarksCaptionLbl)
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
            column(Signed_Caption; Signed_CaptionLbl)
            {
            }
            column(HOD_Caption; HOD_CaptionLbl)
            {
            }
            column(Date_Caption_Control1000000051; Date_Caption_Control1000000051Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Pass_after_sitting_supplementaryCaption; Pass_after_sitting_supplementaryCaptionLbl)
            {
            }
            column(Class_Teacher_Comments_Caption; Class_Teacher_Comments_CaptionLbl)
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
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               Stage = FIELD(Stage);
                column(Student_Units_Unit; Unit)
                {
                }
                column(UnitDesc; UnitDesc)
                {
                }
                column(Student_Units__Student_Units___Total_Score_; "ACA-Student Units"."Total Score")
                {
                }
                column(ScoreGrade; ScoreGrade)
                {
                }
                column(Unit_Count_; "Unit Count")
                {
                }
                column(Student_Units__Student_Units___CAT_Total_Marks_; "ACA-Student Units"."CAT Total Marks")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Student_Units__Student_Units___Exam_Marks_; "ACA-Student Units"."Exam Marks")
                {
                    DecimalPlaces = 0 : 0;
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

                    "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Total Score");
                    "Unit Count" := "Unit Count" + 1;
                    TotalMarks := TotalMarks + "ACA-Student Units"."Total Score";

                    RecUnits.RESET;
                    RecUnits.SETFILTER(RecUnits.Code, "ACA-Student Units".Unit);
                    IF RecUnits.FIND('-') THEN
                        UnitDesc := RecUnits.Desription;
                    //CalculateFinalScore("Student Units"."Student No.","Student Units".Unit);

                    //ScoreGrade:=GetGradeStatus("Student Units"."Total Score","Student Units".Programme);
                end;

                trigger OnPreDataItem()
                begin
                    "Unit Count" := 0;
                    TOTAL := 0;
                    ThisAverage := 0.0;
                    "%FINAL" := 0.0;
                    CATotals := 0;
                    TotalMarks := 0;
                    FinalFinal := 0;
                    thisFinalScore := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

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

                    DimensionTables.RESET;
                    DimensionTables.SETFILTER(DimensionTables.Code, ProgrammeRec."Department Code");
                    IF DimensionTables.FIND('-') THEN BEGIN
                        DepartmentDesc := DimensionTables.Name;
                    END;
                    DimensionTables.RESET;
                    DimensionTables.SETFILTER(DimensionTables.Code, ProgrammeRec."School Code");
                    IF DimensionTables.FIND('-') THEN BEGIN
                        FacultyDesc := DimensionTables.Name;
                    END;

                END;
                Stages.RESET;
                Stages.SETFILTER(Stages."Programme Code", "ACA-Course Registration".Programmes);
                IF Stages.FIND('-') THEN BEGIN
                    LevelDesc := Stages.Description;
                    Semesters.RESET;
                    Semesters.SETFILTER(Semesters.Code, "ACA-Course Registration".Semester);
                    IF Semesters.FIND('-') THEN
                        LevelDesc := LevelDesc + ' ' + Semesters.Description;
                END;
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
        thisFinalScore: Integer;

        FinalFinal: Integer;
        TotalMarks: Decimal;
        CATotals: Decimal;
        "Student Exam Registration/Unit": Record 61576;
        "Unit Count": Integer;
        Stages: Record 61516;
        Semesters: Record 61692;
        UnitDesc: Text[120];
        Marks: Integer;
        Grade: Text[50];
        RecUnits: Record 61517;
        RecExamsRes: Record 61572;
        "%FIRST": Decimal;
        "%SECND": Decimal;
        "%FINAL": Integer;
        RecExamGrades: Record 61575;
        ThisGrade: Text[30];
        "Average": Integer;
        TOTAL: Integer;
        ThisAverage: Integer;
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
        DepartmentDesc: Text[150];
        DimensionTables: Record 349;
        ProgDesc: Text[150];
        LevelDesc: Text[150];
        thisCount: Integer;
        thisUnit: Code[50];
        thisUnitDesc: Text[150];
        ScoreGrade: Code[20];
        PROGRESS_REPORTCaptionLbl: Label 'PROGRESS REPORT';
        Name_of_Student__CaptionLbl: Label 'Name of Student: ';
        Admission_Number_CaptionLbl: Label 'Admission Number:';
        School_CaptionLbl: Label 'School:';
        Department_CaptionLbl: Label 'Department:';
        Unit_DescriptionCaptionLbl: Label 'Unit Description';
        Unit_CodeCaptionLbl: Label 'Unit Code';
        Academic_YearCaptionLbl: Label 'Academic Year';
        Mode_of_Study_CaptionLbl: Label 'Mode of Study:';
        Course_CaptionLbl: Label 'Course:';
        CATS__30CaptionLbl: Label 'CATS /30';
        GradeCaptionLbl: Label 'Grade';
        Registration_CaptionLbl: Label 'Registration:';
        Exam__70CaptionLbl: Label 'Exam /70';
        Total__100CaptionLbl: Label 'Total /100';
        This_is_not_a_transcript_CaptionLbl: Label 'This is not a transcript.';
        Date_CaptionLbl: Label 'Date:';
        Class_Teacher_CaptionLbl: Label 'Class Teacher:';
        FailCaptionLbl: Label 'Fail';
        DistinctionCaptionLbl: Label 'Distinction';
        CreditCaptionLbl: Label 'Credit';
        PassCaptionLbl: Label 'Pass';
        ClassCaptionLbl: Label 'Class';
        Key_to_Grading_System_CaptionLbl: Label 'Key to Grading System:';
        MarksCaptionLbl: Label 'Marks';
        V75____100_CaptionLbl: Label '75% - 100%';
        V65____74_CaptionLbl: Label '65% - 74%';
        V50____64_CaptionLbl: Label '50% - 64%';
        V49__and_BelowCaptionLbl: Label '49% and Below';
        Signed_CaptionLbl: Label 'Signed:';
        HOD_CaptionLbl: Label 'HOD:';
        Date_Caption_Control1000000051Lbl: Label 'Date:';
        EmptyStringCaptionLbl: Label '*';
        Pass_after_sitting_supplementaryCaptionLbl: Label 'Pass after sitting supplementary';
        Class_Teacher_Comments_CaptionLbl: Label 'Class Teacher Comments:';

    procedure GetUnitDesc(var Unit: Code[100])
    begin
    end;

    procedure GetGrade(var FinalScore: Integer; var Exam: Code[130]) Grade: Text[100]
    begin
        RecStudUnits.RESET;
        RecStudUnits.SETFILTER(RecStudUnits."Student No.", "ACA-Course Registration"."Student No.");
        RecStudUnits.SETFILTER(RecStudUnits.Programme, "ACA-Course Registration".Programmes);
        RecStudUnits.SETFILTER(RecStudUnits.Stage, "ACA-Course Registration".Stage);
        RecStudUnits.SETFILTER(RecStudUnits.Semester, "ACA-Course Registration".Semester);
        RecStudUnits.CALCFIELDS(RecStudUnits.UnitCount);
        RecExamGrades.RESET;
        RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
        RecExamGrades.ASCENDING := FALSE;
        RecExamGrades.SETFILTER(RecExamGrades.ExamCode, 'DEFAULT');
        IF RecExamGrades.FIND('-') THEN BEGIN
            REPEAT
                IF FinalScore < RecExamGrades.Upto THEN BEGIN
                    ThisGrade := RecExamGrades.Grade;
                    IF ThisGrade = 'FAIL' THEN
                        FailCount := FailCount + 1;
                    IF (FailCount = 0) THEN
                        ExamRemark := 'PROCEED';
                    IF (FailCount > 0) AND (FailCount <= (RecStudUnits.UnitCount) / 2) THEN
                        ExamRemark := 'DEFERRED';
                    IF (FailCount > 0) AND (FailCount >= (RecStudUnits.UnitCount) / 2) THEN
                        ExamRemark := 'REPEAT';
                END;
            UNTIL RecExamGrades.NEXT = 0;
        END
    end;

    procedure GetAverage(var Score: Integer) "Average": Decimal
    begin
        IF TOTAL <> 0 THEN BEGIN
            "Student Exam Registration/Unit".RESET;
            "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit"."Student No.", "ACA-Course Registration"."Student No.");
            "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Programmes, "ACA-Course Registration".Programmes);
            "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Stage, "ACA-Course Registration".Stage);
            "Student Exam Registration/Unit".SETFILTER("Student Exam Registration/Unit".Semester, "ACA-Course Registration".Semester);
            IF "Student Exam Registration/Unit".FIND('-') THEN
                "Student Exam Registration/Unit".CALCFIELDS("Student Exam Registration/Unit".UnitCount);
            IF "Student Exam Registration/Unit".UnitCount <> 0 THEN
                ThisAverage := ROUND(TOTAL / "Student Exam Registration/Unit".UnitCount, 1, '=');
            GetAverageGrade(ThisAverage);
        END;
    end;

    procedure GetAverageGrade(var "Average": Integer) Grade: Text[100]
    begin
        BEGIN
            RecExamGrades.RESET;
            RecExamGrades.SETCURRENTKEY(RecExamGrades.Upto);
            //RecExamGrades.ASCENDING := FALSE;
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
    end;

    procedure GoToStudentExams(var StudentNo: Code[150]; var Unit: Code[150]) UnitGrade: Text[50]
    begin
    end;

    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]) G: Code[20]
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
        G := '';

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

                            G := Gradings.Grade;
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;
}

