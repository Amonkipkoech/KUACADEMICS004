report 51583 "Graduation List MU"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Graduation List MU.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Stage Filter";
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
            column(Programme_Description; Description)
            {
            }
            column(Graduation_ListCaption; Graduation_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
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
                column(Course_Registration__Student_No__Caption; "ACA-Course Registration".FIELDCAPTION("Student No."))
                {
                }
                column(NamesCaption; NamesCaptionLbl)
                {
                }
                column(Registered__Units_Caption; Registered__Units_CaptionLbl)
                {
                }
                column(Passed_Core__Units_Caption; Passed_Core__Units_CaptionLbl)
                {
                }
                column(Passed_Electives__Units_Caption; Passed_Electives__Units_CaptionLbl)
                {
                }
                column(Failed_Core__Course_Caption; Failed_Core__Course_CaptionLbl)
                {
                }
                column(Failed_Elective__Course_Caption; Failed_Elective__Course_CaptionLbl)
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(ClassCaption; ClassCaptionLbl)
                {
                }
                column(Average_ScoreCaption; Average_ScoreCaptionLbl)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    column(Course_Registration__Student_No__; "Student No.")
                    {
                    }
                    column(Names; Names)
                    {
                    }
                    column(TotalUnits; TotalUnits)
                    {
                    }
                    column(CPassedUnits; CPassedUnits)
                    {
                    }
                    column(CFailedCourse; CFailedCourse)
                    {
                    }
                    column(EPassedUnits; EPassedUnits)
                    {
                    }
                    column(EFailedCourse; EFailedCourse)
                    {
                    }
                    column(Remark; Remark)
                    {
                    }
                    column(MRemark; MRemark)
                    {
                    }
                    column(MeanScore; MeanScore)
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

                    trigger OnAfterGetRecord()
                    begin
                        RCount := RCount + 1;
                        Remark := '';
                        MRemark := '';
                        Names := '';
                        MUnits := 0;


                        EPassedUnits := 0;
                        EPassedCourse := 0;
                        EFailedUnits := 0;
                        EFailedCourse := 0;
                        CPassedUnits := 0;
                        CPassedCourse := 0;
                        CFailedUnits := 0;
                        CFailedCourse := 0;
                        TotalCourse := 0;
                        TotalUnits := 0;
                        TotalScore := 0;



                        IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                            Names := Cust.Name;



                        Grading.RESET;
                        Grading.SETRANGE(Grading.Category, 'DEFAULT');
                        Grading.SETRANGE(Grading.Failed, TRUE);
                        IF Grading.FIND('+') THEN
                            FailScore := Grading."Up to";

                        StudUnits.RESET;
                        StudUnits.SETRANGE(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                        StudUnits.SETRANGE(StudUnits.Programme, "ACA-Course Registration".Programmes);
                        //StudUnits.SETFILTER(StudUnits.Stage,'Y2S1..Y4S2');
                        StudUnits.SETRANGE(StudUnits.Taken, TRUE);
                        StudUnits.SETRANGE(StudUnits."Allow Supplementary", FALSE);
                        StudUnits.SETRANGE(StudUnits.Audit, FALSE);
                        IF StudUnits.FIND('-') THEN BEGIN
                            REPEAT
                                StudUnits.CALCFIELDS(StudUnits."Total Score");

                                TotalCourse := TotalCourse + 1;
                                TotalUnits := TotalUnits + StudUnits."No. Of Units";
                                TotalScore := TotalScore + StudUnits."Total Score";


                                IF StudUnits."Course Type" = StudUnits."Course Type"::Elective THEN BEGIN
                                    IF StudUnits."Total Score" > FailScore THEN BEGIN
                                        EPassedUnits := EPassedUnits + StudUnits."No. Of Units";
                                        EPassedCourse := EPassedCourse + 1;
                                    END ELSE BEGIN
                                        EFailedUnits := EFailedUnits + StudUnits."No. Of Units";
                                        EFailedCourse := EFailedCourse + 1;
                                    END;

                                END ELSE BEGIN
                                    IF StudUnits."Total Score" > FailScore THEN BEGIN
                                        CPassedUnits := CPassedUnits + StudUnits."No. Of Units";
                                        CPassedCourse := CPassedCourse + 1;
                                    END ELSE BEGIN
                                        CFailedUnits := CFailedUnits + StudUnits."No. Of Units";
                                        CFailedCourse := CFailedCourse + 1;
                                    END;


                                END;

                            UNTIL StudUnits.NEXT = 0;
                        END;



                        IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                            Prog.CALCFIELDS(Prog."Mandatory Units");
                            MUnits := Prog."Mandatory Units";
                            IF Prog."Min Pass Units" <= CPassedUnits THEN
                                Remark := 'GRADUATING'
                            ELSE
                                Remark := 'NOT GRADUATING';

                        END;

                        IF EFailedCourse > 1 THEN
                            Remark := 'NOT GRADUATING';

                        IF CFailedCourse > 0 THEN
                            Remark := 'NOT GRADUATING';




                        //Determine Class
                        IF TotalScore > 0 THEN BEGIN
                            IF TotalCourse > 0 THEN
                                MeanScore := TotalScore / TotalCourse;
                        END;

                        IF MeanScore > 0 THEN BEGIN
                            Gradings.RESET;
                            Gradings.SETRANGE(Gradings.Category, 'GRAD');
                            LastGrade := '';
                            LastScore := 0;
                            IF Gradings.FIND('-') THEN BEGIN
                                ExitDo := FALSE;
                                REPEAT
                                    IF MeanScore < LastScore THEN BEGIN
                                        IF ExitDo = FALSE THEN BEGIN
                                            ExitDo := TRUE;
                                            MeanGrade := LastGrade;
                                            MRemark := LastRemark;
                                        END;
                                    END;
                                    LastGrade := Gradings.Grade;
                                    LastScore := Gradings."Up to";
                                    LastRemark := Gradings.Description;

                                UNTIL Gradings.NEXT = 0;

                                IF ExitDo = FALSE THEN BEGIN
                                    Gradings2.RESET;
                                    Gradings2.SETRANGE(Gradings2.Category, 'GRAD');
                                    IF Gradings2.FIND('+') THEN BEGIN
                                        MeanGrade := Gradings2.Grade;
                                        MRemark := Gradings2.Description;
                                    END;

                                END;
                            END;

                        END ELSE BEGIN
                            Grade := '';
                            MRemark := '';
                        END;


                        //Determine Class

                        //Check Fee Bal
                        IF Cust.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                            Cust.CALCFIELDS(Cust."Balance (LCY)");
                            IF Cust."Balance (LCY)" > 0 THEN
                                Remarks := 'NOT GRADUATING-FEE';

                        END;
                    end;
                }
            }
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
        Names: Text[200];
        UnitsReg: Integer;
        UnitsPassed: Integer;
        UnitsCR: Integer;
        Grading: Record 61569;
        Gradings: Record 61569;
        Gradings2: Record 61569;
        StudUnits: Record 61549;
        FailScore: Decimal;
        Remark: Text[150];
        RCount: Integer;
        Prog: Record 61511;
        MUnits: Integer;
        Cust: Record 18;
        TotalCourse: Integer;
        TotalUnits: Integer;
        EPassedUnits: Integer;
        EPassedCourse: Integer;
        EFailedUnits: Integer;
        EFailedCourse: Integer;
        CPassedUnits: Integer;
        CPassedCourse: Integer;
        CFailedUnits: Integer;
        CFailedCourse: Integer;
        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        MRemark: Text[200];
        LastRemark: Text[200];
        Grade: Text[200];
        Graduation_ListCaptionLbl: Label 'Graduation List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
        Registered__Units_CaptionLbl: Label 'Registered (Units)';
        Passed_Core__Units_CaptionLbl: Label 'Passed Core (Units)';
        Passed_Electives__Units_CaptionLbl: Label 'Passed Electives (Units)';
        Failed_Core__Course_CaptionLbl: Label 'Failed Core (Course)';
        Failed_Elective__Course_CaptionLbl: Label 'Failed Elective (Course)';
        RemarksCaptionLbl: Label 'Remarks';
        ClassCaptionLbl: Label 'Class';
        Average_ScoreCaptionLbl: Label 'Average Score';
}

