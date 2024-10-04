/// <summary>
/// Report Result Slip (ID 51553).
/// </summary>
report 51553 "Result Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Result Slip.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type");
            RequestFilterFields = "Student No.", Programmes, Stage, Semester;
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(Course_Registration__Student_Type_; "Student Type")
            {
            }
            column(Stages_Description; Stages.Description)
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(Course_Registration__Course_Registration__Semester; "ACA-Course Registration".Semester)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(Mode_of_StudyCaption; Mode_of_StudyCaptionLbl)
            {
            }
            column(ACADEMIC_RESULT_SLIPCaption; ACADEMIC_RESULT_SLIPCaptionLbl)
            {
            }
            column(Units_CodeCaption; Units_CodeCaptionLbl)
            {
            }
            column(LevelCaption; LevelCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Student_Name_Caption; Student_Name_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(ResultCaption; ResultCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(SemesterCaption; SemesterCaptionLbl)
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
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
            dataitem("ACA-Student Units"; 61549)
            {
                DataItemLink = "Reg. Transacton ID" = FIELD("Reg. Transacton ID"),
                               "Student No." = FIELD("Student No.");
                DataItemTableView = WHERE(Taken = CONST(true));
                RequestFilterFields = "Reg. Transacton ID", Programme, Stage, Semester;
                column(Student_Units_Unit; Unit)
                {
                }
                column(UDesc; UDesc)
                {
                }
                column(Student_Units__Student_Units___Total_Score_; "ACA-Student Units"."Total Score")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Student_Units_Grade; Grade)
                {
                }
                column(Student_Units_Remarks; Remarks)
                {
                }
                column(MeanGrade; MeanGrade)
                {
                }
                column(Mean_Grade_Caption; Mean_Grade_CaptionLbl)
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
                                        Grade := LastGrade;
                                        Remarks := LastRemark;
                                        ExitDo := TRUE;
                                    END;
                                END;
                                LastGrade := Gradings.Grade;
                                LastScore := Gradings."Up to";
                                IF Gradings.Failed = TRUE THEN
                                    LastRemark := 'Supplementary'
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
                end;
            }
            dataitem("ACA-Grading System Setup1"; "ACA-Grading System Setup1")
            {
                column(Grading_System_Setup1_Description; Description)
                {
                }
                column(Grading_System_Setup1_Remarks; Remarks)
                {
                }
                column(Grading_System_Setup1__Grading_System_Setup1__Grade; "ACA-Grading System Setup1".Grade)
                {
                }
                column(Grading_System_Setup1_RemarksCaption; FIELDCAPTION(Remarks))
                {
                }
                column(MarksCaption; MarksCaptionLbl)
                {
                }
                column(Key_to_Grading_System_Caption; Key_to_Grading_System_CaptionLbl)
                {
                }
                column(GradeCaption_Control1102760044; GradeCaption_Control1102760044Lbl)
                {
                }
                column(Date_________________________________________________________________________________________________Caption; Date_________________________________________________________________________________________________CaptionLbl)
                {
                }
                column(Date__________________________________________________________________________________________________________Caption; Date__________________________________________________________________________________________________________CaptionLbl)
                {
                }
                column(DataItem1102760023; HOD_CaptLbl)
                {
                }
                column(Register_________________________________________________________________________________________________Caption; Register_________________________________________________________________________________________________CaptionLbl)
                {
                }
                column(Signed_Caption; Signed_CaptionLbl)
                {
                }
                column(Grading_System_Setup1_Category; Category)
                {
                }
                column(Grading_System_Setup1_Up_to; "Up to")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    RFound := TRUE;
                IF Prog.GET("ACA-Course Registration".Programmes) THEN
                    RFound := TRUE;
                IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                    RFound := TRUE;

                OUnits := 0;
                OScore := 0;
                MeanScore := 0;
                MeanGrade := '';
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
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        UnitR: Record 61517;
        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];
        Gradings: Record 61569;
        Gradings2: Record 61569;
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
        Mode_of_StudyCaptionLbl: Label 'Mode of Study';
        ACADEMIC_RESULT_SLIPCaptionLbl: Label 'ACADEMIC RESULT SLIP';
        Units_CodeCaptionLbl: Label 'Units Code';
        LevelCaptionLbl: Label 'Level';
        ProgrammeCaptionLbl: Label 'Programme';
        Student_Name_CaptionLbl: Label 'Student Name:';
        DescriptionCaptionLbl: Label 'Description';
        ResultCaptionLbl: Label 'Result';
        GradeCaptionLbl: Label 'Grade';
        RemarkCaptionLbl: Label 'Remark';
        SemesterCaptionLbl: Label 'Semester';
        MASENO_UNIVERSITYCaptionLbl: Label 'MASENO UNIVERSITY';
        Mean_Grade_CaptionLbl: Label 'Mean Grade:';
        MarksCaptionLbl: Label 'Marks';
        Key_to_Grading_System_CaptionLbl: Label 'Key to Grading System:';
        GradeCaption_Control1102760044Lbl: Label 'Grade';
        Date_________________________________________________________________________________________________CaptionLbl: Label 'Date:  ..............................................................................................';
        Date__________________________________________________________________________________________________________CaptionLbl: Label 'Date:  .......................................................................................................';
        HOD_CaptLbl: Label 'HOD:  ...................................................................................................................';
        Register_________________________________________________________________________________________________CaptionLbl: Label 'Register:  ..............................................................................................';
        Signed_CaptionLbl: Label 'Signed:';
}

