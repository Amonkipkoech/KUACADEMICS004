report 66665 "Provisional College Transcrip3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Provisional College Transcrip3.rdl';//Provisional College Transcrip3
    Caption = 'Provisional Transcript';

    dataset
    {
        dataitem(CourseRegs; 66651)
        {
            CalcFields = "Failed Some Units";
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student Number", Programme, "School Code", "Academic Year", "Year of Study";
            column(StudNo; CourseRegs."Student Number")
            {
            }
            column(infoName; info.Name)
            {
            }
            column(infoAddress; info.Address)
            {
            }
            column(infoAddress2; info."Address 2")
            {
            }
            column(infoCity; info.City)
            {
            }
            column(infoEmail; info."E-Mail")
            {
            }
            column(infoPhone; info."Phone No.")
            {
            }

            column(ProgClassInt; ProgClassInt)
            {
            }
            column(Prog; CourseRegs.Programme)
            {
            }
            column(Sem; '')
            {
            }
            column(Stag; '')
            {
            }
            column(CumSc; '')
            {
            }
            column(CurrSem; '')
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(YoS; CourseRegs."Year of Study")
            {
            }
            column(TotalYearlyMarks; CourseRegs."Total Marks")
            {
            }
            column(YearlyAverage; CourseRegs."Normal Average")
            {
            }
            column(YearlyGrade; CourseRegs."Graduation Grade")
            {
            }
            column(YearlyFailed; CourseRegs."Failed Courses")
            {
            }
            column(YearlyTotalUnits; CourseRegs."Total Courses")
            {
            }
            column(CummulativeAverage; CourseRegs."Weighted Average")
            {
            }
            column(CurrAverage; CourseRegs."Normal Average")
            {
            }
            column(YearlyRemarks; YearlyRemarks)
            {
            }
            column(AcadYear; CourseRegs."Academic Year")
            {
            }
            column(sName; CourseRegs."Student Name")
            {
            }
            column(pName; UPPERCASE(pName))
            {
            }
            column(GRADDATE; GRADDATE)
            {
            }
            column(YearOfStudy; YearOfStudy)
            {
            }
            column(YearOfAdmi; YearOfAdmi)
            {
            }
            column(SchoolName; SchoolName)
            {
            }
            column(acadyearz; acadyear)
            {
            }
            // column(signedSignature; dimVal.Signature)
            // {
            // }
            // column(TranscriptSignatory; dimVal."HOD Names")
            // {
            // }
            // column(TransCriptTitle; dimVal.Titles)
            // {
            // }
            column(FacultyName; CourseRegs."School Name")
            {
            }
            column(codSchool; 'COD, ' + SchoolName)
            {
            }
            column(codDept; 'COD,' + DeptName)
            {
            }
            column(PassRemark; PassRemark)
            {
            }
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            column(Cat1; Cat1)
            {
            }
            column(Cat2; Cat2)
            {
            }
            column(Cat3; Cat3)
            {
            }
            column(Label1; GLabel[1])
            {
            }
            column(Label2; GLabel[2])
            {
            }
            column(Label3; GLabel[3])
            {
            }
            column(Label4; GLabel[4])
            {
            }
            column(Label5; GLabel[5])
            {
            }
            column(BLabel1; GLabel2[1])
            {
            }
            column(BLabel2; GLabel2[2])
            {
            }
            column(BLabel3; GLabel2[3])
            {
            }
            column(BLabel4; GLabel2[4])
            {
            }
            column(BLabel5; GLabel2[5])
            {
            }
            column(LegendRange1; LegendRange[1])
            {
            }
            column(LegendGrade1; LegendGrade[1])
            {
            }
            column(LegendDesc1; LegendDesc[1])
            {
            }
            column(LegendRange2; LegendRange[2])
            {
            }
            column(LegendGrade2; LegendGrade[2])
            {
            }
            column(LegendDesc2; LegendDesc[2])
            {
            }
            column(LegendRange3; LegendRange[3])
            {
            }
            column(LegendGrade3; LegendGrade[3])
            {
            }
            column(LegendDesc3; LegendDesc[3])
            {
            }
            column(LegendRange4; LegendRange[4])
            {
            }
            column(LegendGrade4; LegendGrade[4])
            {
            }
            column(LegendDesc4; LegendDesc[4])
            {
            }
            column(LegendRange5; LegendRange[5])
            {
            }
            column(LegendGrade5; LegendGrade[5])
            {
            }
            column(LegendDesc5; LegendDesc[5])
            {
            }
            column(LegendRange6; LegendRange[6])
            {
            }
            column(LegendGrade6; LegendGrade[6])
            {
            }
            column(LegendDesc6; LegendDesc[6])
            {
            }
            dataitem(StudUnitsss; 66650)
            {
                DataItemLink = "Student No." = FIELD("Student Number"),
                               Programme = FIELD(Programme),
                               "Year of Study" = FIELD("Year of Study");
                column(Unit; StudUnitsss."Unit Code")
                {
                }
                column(Desc; StudUnitsss."Unit Description")
                {
                }
                column(CreditHours; StudUnitsss."Credit Hours")
                {
                }
                column(Score; StudUnitsss."Total Score")
                {
                }
                column(Final; StudUnitsss."Total Score")
                {
                }
                column(Grade; StudUnitsss.Grade)
                {
                }
                column(Status; StudUnitsss."Grade Comment")
                {
                }
                dataitem(ExamGraddingSetup; 61599)
                {
                    DataItemLink = Category = FIELD("Exam Category");
                    column(ExamCat; ExamGraddingSetup.Category)
                    {
                    }
                    column(CatGrade; ExamGraddingSetup.Grade)
                    {
                    }
                    column(CatGradeDesc; ExamGraddingSetup.Description)
                    {
                    }
                    column(CatRange; ExamGraddingSetup.Range)
                    {
                    }
                }
                dataitem(StudUnitsss2; "ACA-Student Theory Units ")
                {
                    DataItemLink = "Student No." = FIELD("Student No."),
                               //Programme = FIELD(Programme),
                               "Year of Study" = FIELD("Year of Study");
                    column(Unit2; StudUnitsss."Unit Code")
                    {
                    }
                    column(Desc2; StudUnitsss."Unit Description")
                    {
                    }
                    column(CreditHours2; StudUnitsss."Credit Hours")
                    {
                    }

                }


                trigger OnAfterGetRecord()
                var
                    ProgCategory: Code[20];
                    ACAExamGraddingSetup: Record 61599;
                begin
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(YearlyRemarks);
                CLEAR(LegendDesc);
                CLEAR(LegendGrade);
                CLEAR(LegendRange);
                CLEAR(Countings);
                CLEAR(SchoolName);
                CLEAR(Countings);
                CLEAR(ProgClassInt);
                CLEAR(YearlyRemarks);
                prog.RESET;
                prog.SETRANGE(prog.Code, CourseRegs.Programme);
                IF prog.FIND('-') THEN BEGIN
                    ProvisionalTranscriptComment.RESET;
                    ProvisionalTranscriptComment.SETRANGE(ProvisionalTranscriptComment."Exam Category", prog."Exam Category");
                    ProvisionalTranscriptComment.SETRANGE(ProvisionalTranscriptComment.Code, CourseRegs.Classification);
                    IF ProvisionalTranscriptComment.FIND('-') THEN BEGIN
                        IF CourseRegs."Year of Study" = 1 THEN
                            YearlyRemarks := ProvisionalTranscriptComment."1st Year Trans. Comments"
                        ELSE
                            IF CourseRegs."Year of Study" = 2 THEN
                                YearlyRemarks := ProvisionalTranscriptComment."2nd Year  Trans. Comments"
                            ELSE
                                IF CourseRegs."Year of Study" = 3 THEN
                                    YearlyRemarks := ProvisionalTranscriptComment."3rd Year  Trans. Comments"
                                ELSE
                                    IF CourseRegs."Year of Study" = 4 THEN
                                        YearlyRemarks := ProvisionalTranscriptComment."4th Year  Trans. Comments"
                                    ELSE
                                        IF CourseRegs."Year of Study" = 5 THEN
                                            YearlyRemarks := ProvisionalTranscriptComment."5th Year  Trans. Comments"
                                        ELSE
                                            IF CourseRegs."Year of Study" = 6 THEN
                                                YearlyRemarks := ProvisionalTranscriptComment."6th Year  Trans. Comments"
                                            ELSE
                                                IF CourseRegs."Year of Study" = 7 THEN
                                                    YearlyRemarks := ProvisionalTranscriptComment."7th Year  Trans. Comments"
                    END;
                    IF ((CourseRegs."Year of Study" = CourseRegs."Final Year of Study") AND (CourseRegs."Failed Some Units")) THEN YearlyRemarks := 'RESIT ALL FAILED COURSES';

                    IF prog."Special Programme Class" = prog."Special Programme Class"::"Medicine & Nursing" THEN
                        ProgClassInt := 'B'
                    ELSE
                        IF prog."Special Programme Class" = prog."Special Programme Class"::General THEN ProgClassInt := 'A';
                    IF ((prog.Category = prog.Category::Certificate)
                      OR (prog.Category = prog.Category::Professional)
                      OR (prog.Category = prog.Category::Diploma)
                      OR (prog.Category = prog.Category::"Course List")) THEN
                        ProgClassInt := 'C';
                    prog.TESTFIELD(prog."Exam Category");
                    ACAExamGraddingSetup.RESET;
                    ACAExamGraddingSetup.SETRANGE(ACAExamGraddingSetup.Category, prog."Exam Category");
                    IF ACAExamGraddingSetup.SETCURRENTKEY(ACAExamGraddingSetup.Grade) THEN;
                    IF ACAExamGraddingSetup.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            Countings += 1;
                            LegendDesc[Countings] := ACAExamGraddingSetup.Description;
                            LegendGrade[Countings] := ACAExamGraddingSetup.Grade;
                            LegendRange[Countings] := ACAExamGraddingSetup.Range;
                        END;
                        UNTIL ACAExamGraddingSetup.NEXT = 0;
                    END;
                    pName := prog.Description;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'FACULTY');
                    dimVal.SETRANGE(dimVal.Code, prog."School Code");
                    IF dimVal.FIND('-') THEN BEGIN
                        SchoolName := dimVal.Name;
                    END;
                END;
                dimVal.RESET;
                dimVal.SETRANGE(dimVal."Dimension Code", 'Department');
                dimVal.SETRANGE(dimVal.Code, prog."Department Code");
                IF dimVal.FIND('-') THEN BEGIN
                    DeptName := dimVal.Name;
                END;


                CLEAR(YearOfStudy);

                YearOfStudy := FORMAT(CourseRegs."Year of Study");


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                CLEAR(GRADDATE);
                cust.RESET;
                cust.SETRANGE(cust."No.", CourseRegs."Student Number");
                IF cust.FIND('-') THEN BEGIN
                END;
                sName := CourseRegs."Student Name";

                CourseReg12.RESET;
                CourseReg12.SETRANGE(CourseReg12.Programmes, CourseRegs.Programme);
                CourseReg12.SETRANGE(CourseReg12."Student No.", CourseRegs."Student Number");
                IF CourseReg12.FIND('-') THEN BEGIN
                    //IF CourseReg12."Registration Date"<>0D THEN BEGIN
                    Sem.RESET;
                    Sem.SETRANGE(Sem.Code, CourseReg12.Semester);
                    IF Sem.FIND('-') THEN BEGIN
                        IF Sem.From <> 0D THEN BEGIN
                            ACAProgCatTranscriptComm.RESET;
                            ACAProgCatTranscriptComm.SETRANGE(ACAProgCatTranscriptComm."Exam Catogory", prog."Exam Category");
                            IF ACAProgCatTranscriptComm.FIND('-') THEN
                                GRADDATE := FORMAT(DATE2DMY((CALCDATE(FORMAT(ACAProgCatTranscriptComm.COUNT) + 'Y', Sem.From)), 3));
                            YearOfAdmi := Sem.From;
                        END;
                    END;
                END;



                acadyear := CourseRegs."Academic Year";


                CLEAR(TransCriptRemarks);

                TransCriptRemarks := CourseRegs."Provisional Transcript Remark";
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Cat1);
                CLEAR(Cat2);
                CLEAR(Cat3);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        ProvisionalTranscriptComment: Record 88852;
        YearlyRemarks: Text[250];
        ACAProgCatTranscriptComm: Record 78020;
        TransCriptRemarks: Text[250];
        PassRemarks: Code[10];
        ProgClassInt: Code[10];
        LegendDesc: array[40] of Code[50];
        LegendGrade: array[120] of Code[20];
        LegendRange: array[120] of Code[50];
        CourseReg12: Record 61532;
        GRADDATE: Code[30];
        pName: Text[250];
        YearOfStudy: Code[10];
        YearOfAdmi: Date;
        SchoolName: Text[250];
        Sem: Record 61692;
        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record 61511;
        dimVal: Record 349;
        PassRemark: Text[200];
        SemRec: Record 61692;
        DeptName: Text[100];
        i: Integer;
        GLabel: array[10] of Text[200];
        GLabel2: array[10] of Text[200];
        Passmark: Decimal;
        CompanyInformation: Record 79;
        UnitsCount: Integer;
        UnitsFailedCount: Integer;
        TotalMarksCounted: Decimal;
        AverageMarks: Decimal;
        AvrgGrade: Code[1];
        AvrgRemarks: Code[250];
        YearofStudyView: Option " ","1st","2nd","3rd","4th","5th","6th";
        SemesterLoader: Integer;
        ProgramLoader: Integer;
        LegendRange1: array[50] of Code[20];
        LegendGrade1: array[50] of Code[2];
        LegendDesc1: array[50] of Code[50];
        LegendRange2: array[50] of Code[20];
        LegendGrade2: array[50] of Code[2];
        LegendDesc2: array[50] of Code[50];
        LegendRange3: array[50] of Code[20];
        LegendGrade3: array[50] of Code[2];
        LegendDesc3: array[50] of Code[50];
        ACAExamGraddingSetup: Record 61599;
        Cat1: Code[20];
        Cat2: Code[20];
        Cat3: Code[20];
        Countings: Integer;
        Countings2: Integer;
        Countings3: Integer;
        ACAResultsStatus: Record 61739;
        info: Record "Company Information";
}

