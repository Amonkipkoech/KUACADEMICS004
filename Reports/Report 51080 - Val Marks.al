report 51080 "Val Marks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Val Marks.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.", ENo);
            RequestFilterFields = "Student No.", Programme, Semester, Stage;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Student_Units_Semester; Semester)
            {
            }
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units__Final_Score_; "Final Score")
            {
            }
            column(Student_Units__Total_Score_; "Total Score")
            {
            }
            column(Student_Units_Grade; Grade)
            {
            }
            column(Student_Units__Result_Status_; "Result Status")
            {
            }
            column(Student_UnitsCaption; Student_UnitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Student_Units_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Student_Units_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Student_Units__Final_Score_Caption; FIELDCAPTION("Final Score"))
            {
            }
            column(Student_Units__Total_Score_Caption; FIELDCAPTION("Total Score"))
            {
            }
            column(Student_Units_GradeCaption; FIELDCAPTION(Grade))
            {
            }
            column(Student_Units__Result_Status_Caption; FIELDCAPTION("Result Status"))
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(Student_Units_Unit; Unit)
            {
            }
            column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Units/Subj".RESET;
                "Units/Subj".SETRANGE("Units/Subj"."Programme Code", "ACA-Student Units".Programme);
                "Units/Subj".SETRANGE("Units/Subj".Code, "ACA-Student Units".Unit);
                "Units/Subj".SETRANGE("Units/Subj"."Stage Code", "ACA-Student Units".Stage);
                IF "Units/Subj".FIND('-') THEN
                    "ACA-Student Units".Description := "Units/Subj".Desription;

                "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Total Score");
                "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Cust Exist");
                "ACA-Student Units"."Final Score" := "ACA-Student Units"."Total Score";
                "ACA-Student Units".Registered := "ACA-Student Units".Registered;

                IF (GetGradeStatus("ACA-Student Units"."Final Score", "ACA-Student Units".Programme, "ACA-Student Units".Unit)) OR
                ("ACA-Student Units"."Final Score" = 0) THEN BEGIN
                    "ACA-Student Units"."Result Status" := 'FAIL';
                    "ACA-Student Units".Failed := TRUE;
                END ELSE BEGIN
                    "ACA-Student Units"."Result Status" := 'PASS';
                END;
                "ACA-Student Units".Grade := GetGrade("ACA-Student Units"."Final Score", "ACA-Student Units".Unit);
                "ACA-Student Units".MODIFY;

                // Update Supplimentary
                IF "ACA-Student Units"."Register for" = "ACA-Student Units"."Register for"::Supplimentary THEN BEGIN
                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Student Units"."Student No.");
                    StudUnits.SETRANGE(StudUnits.Unit, "ACA-Student Units".Unit);
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
                EResults.SETRANGE(EResults."Student No.", "ACA-Student Units"."Student No.");
                EResults.SETRANGE(EResults.Unit, "ACA-Student Units".Unit);
                EResults.SETRANGE(EResults.Programmes, "ACA-Student Units".Programme);
                EResults.SETRANGE(EResults.Stage, "ACA-Student Units".Stage);
                EResults.SETRANGE(EResults.Semester, "ACA-Student Units".Semester);
                EResults.SETRANGE(EResults."Re-Take", FALSE);
                IF EResults.FIND('-') THEN BEGIN
                    REPEAT
                        EResults.CALCFIELDS(EResults."Re-Sit");
                        EResults."Re-Sited" := EResults."Re-Sit";
                        EResults.MODIFY;
                    UNTIL EResults.NEXT = 0;
                END;

                // Update Online Results
                OnlineGrading.RESET;
                OnlineGrading.SETRANGE(OnlineGrading."Student No", "ACA-Student Units"."Student No.");
                OnlineGrading.SETRANGE(OnlineGrading."Unit Code", "ACA-Student Units".Unit);
                IF OnlineGrading.FIND('-') THEN
                    OnlineGrading.DELETEALL;

                IF Sem.GET("ACA-Student Units".Semester) THEN
                    IF Sem."SMS Results Semester" = TRUE THEN BEGIN
                        IF "ACA-Student Units"."Final Score" > 0 THEN BEGIN
                            OnlineGrading.INIT;
                            OnlineGrading."Student No" := "ACA-Student Units"."Student No.";
                            OnlineGrading."Unit Code" := "ACA-Student Units".Unit;
                            OnlineGrading.Description := "ACA-Student Units".Description;
                            OnlineGrading.Exam := FORMAT("ACA-Student Units"."Final Score");
                            OnlineGrading.Grade := "ACA-Student Units".Grade;
                            OnlineGrading.INSERT;
                        END;
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
        OnlineGrading: Record 61006;
        "Units/Subj": Record 61517;
        Sem: Record 61518;
        StudUnits: Record 61549;
        EResults: Record 61548;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';

    procedure GetGrade(Marks: Decimal; UnitG: Code[20]) xGrade: Text[100]
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
        UnitsRR.SETRANGE(UnitsRR."Programme Code", "ACA-Student Units".Programme);
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        UnitsRR.SETRANGE(UnitsRR."Stage Code", "ACA-Student Units".Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET("ACA-Student Units".Programme) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
            END;
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
        UnitsRR.SETRANGE(UnitsRR."Stage Code", "ACA-Student Units".Stage);
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
}

