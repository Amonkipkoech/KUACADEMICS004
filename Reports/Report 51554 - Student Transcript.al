report 51554 "Student Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Transcript.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Customer Type" = CONST(Student));
            RequestFilterFields = "No.";
            column(Prog_Description; Prog.Description)
            {
            }
            column(Customer_Customer_Name; Customer.Name)
            {
            }
            column(Customer_Customer__No__; Customer."No.")
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(GradeCaption; GradeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Student_No_Caption; Student_No_CaptionLbl)
            {
            }
            column(ACADEMIC_TRANSCRIPTCaption; ACADEMIC_TRANSCRIPTCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Student_Name_Caption; Student_Name_CaptionLbl)
            {
            }
            column(Units_CodeCaption; Units_CodeCaptionLbl)
            {
            }
            column(MASENO_UNIVERSITYCaption; MASENO_UNIVERSITYCaptionLbl)
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("No.");
                RequestFilterFields = "Reg. Transacton ID", Programme, Stage, Semester;
                column(Student_Units_Unit; Unit)
                {
                }
                column(UDesc; UDesc)
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
                    PUnits.RESET;
                    PUnits.SETRANGE("Programme Code", "ACA-Student Units".Programme);
                    PUnits.SETRANGE(Code, Unit);
                    IF PUnits.FIND('-') THEN
                        UDesc := PUnits.Desription;

                    IF "ACA-Student Units".Taken = TRUE THEN BEGIN



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

                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", Customer."No.");
                IF CReg.FIND('+') THEN BEGIN
                    IF Prog.GET(CReg.Programmes) THEN
                        RFound := TRUE;

                END;

                OUnits := 0;
                OScore := 0;
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
        PUnits: Record "ACA-Units/Subjects";
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];

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
        CReg: Record 61532;
        RemarkCaptionLbl: Label 'Remark';
        GradeCaptionLbl: Label 'Grade';
        DescriptionCaptionLbl: Label 'Description';
        Student_No_CaptionLbl: Label 'Student No.';
        ACADEMIC_TRANSCRIPTCaptionLbl: Label 'ACADEMIC TRANSCRIPT';
        ProgrammeCaptionLbl: Label 'Programme';
        Student_Name_CaptionLbl: Label 'Student Name:';
        Units_CodeCaptionLbl: Label 'Units Code';
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

