report 51555 "Examination Audit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Examination Audit.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            RequestFilterFields = Programme, Unit, "Student No.", "Reg. Transacton ID";
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(Student_Units_Unit; Unit)
            {
            }
            column(Student_Units_Unit_Control1102760024; Unit)
            {
            }
            column(Student_Units_Grade; Grade)
            {
            }
            column(Student_Units_Remarks; Remarks)
            {
            }
            column(Student_Units__Total_Score_; "Total Score")
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(Units_CodeCaption; Units_CodeCaptionLbl)
            {
            }
            column(ResultsCaption; ResultsCaptionLbl)
            {
            }
            column(Maseno_UniversityCaption; Maseno_UniversityCaptionLbl)
            {
            }
            column(Examination_AuditCaption; Examination_AuditCaptionLbl)
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Programme_FilterCaption; Programme_FilterCaptionLbl)
            {
            }
            column(Stage_FilterCaption; Stage_FilterCaptionLbl)
            {
            }
            column(Unit_FilterCaption; Unit_FilterCaptionLbl)
            {
            }
            column(Student_Units_Semester; Semester)
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
                IF "ACA-Student Units".Taken = TRUE THEN BEGIN
                    UDesc := '';
                    UnitR.RESET;
                    UnitR.SETRANGE(UnitR."Programme Code", "ACA-Student Units".Programme);
                    UnitR.SETRANGE(UnitR.Code, Unit);
                    IF UnitR.FIND('-') THEN
                        UDesc := UnitR.Desription;


                    IF "ACA-Student Units"."Total Score" > 0 THEN BEGIN
                        Gradings.RESET;
                        Gradings.SETRANGE(Gradings.Category, 'DEFAULT');
                        LastGrade := '';
                        LastRemark := '';
                        LastScore := 0;
                        IF Gradings.FIND('-') THEN BEGIN
                            ExitDo := FALSE;
                            REPEAT
                                IF "ACA-Student Units"."Total Score" < LastScore THEN BEGIN
                                    IF ExitDo = FALSE THEN BEGIN
                                        ExitDo := TRUE;
                                        Grade := LastGrade;
                                        Remarks := LastRemark;
                                    END;
                                END;
                                LastGrade := Gradings.Grade;
                                LastScore := Gradings."Up to";
                                IF Gradings.Failed = TRUE THEN
                                    LastRemark := 'Suplimentary'
                                ELSE
                                    LastRemark := Gradings.Remarks;

                            UNTIL Gradings.NEXT = 0;

                            IF ExitDo = FALSE THEN BEGIN
                                Gradings2.RESET;
                                Gradings2.SETRANGE(Gradings2.Category, 'DEFAULT');
                                IF Gradings2.FIND('+') THEN BEGIN
                                    Grade := Gradings2.Grade;
                                    Remarks := Gradings2.Remarks;
                                END;

                            END;
                        END;

                    END ELSE BEGIN
                        Grade := '';
                        Remarks := 'Not Done';
                    END;


                    OUnits := OUnits + 1;
                    OScore := OScore + "ACA-Student Units"."Total Score";

                END ELSE BEGIN
                    Grade := '';
                    Remarks := '**Exempted**';


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
        Cust: Record 18;

        RFound: Boolean;
        UDesc: Text[200];
        UnitR: Record 61517;
        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];
        Gradings: Record 61599;
        Gradings2: Record 61599;
        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        LastRemark: Text[200];

        RemarkCaptionLbl: Label 'Remark';
        GradeCaptionLbl: Label 'Grade';
        Units_CodeCaptionLbl: Label 'Units Code';
        ResultsCaptionLbl: Label 'Results';
        Maseno_UniversityCaptionLbl: Label 'Maseno University';
        Examination_AuditCaptionLbl: Label 'Examination Audit';
        NameCaptionLbl: Label 'Name';
        Programme_FilterCaptionLbl: Label 'Programme Filter';
        Stage_FilterCaptionLbl: Label 'Stage Filter';
        Unit_FilterCaptionLbl: Label 'Unit Filter';
}

