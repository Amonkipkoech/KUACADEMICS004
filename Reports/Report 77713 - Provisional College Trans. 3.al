report 77713 "Provisional College Trans. 3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Provisional College Trans. 3.rdl';

    dataset
    {
        dataitem(courseReg; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = filter('No'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student No.", Programmes, Semester, "Year Of Study", "Academic Year";
            column(StudNo; reg."Student No.")
            {
            }
            column(Prog; reg.Programmes)
            {
            }
            column(Sem; reg.Semester)
            {
            }
            column(Stag; reg.Stage)
            {
            }
            column(CumSc; reg."Cumm Score")
            {
            }
            column(CurrSem; reg."Current Cumm Score")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(YoS; reg."Year Of Study")
            {
            }
            column(TotalYearlyMarks; reg."Total Yearly Marks")
            {
            }
            column(YearlyAverage; reg."Yearly Average")
            {
            }
            column(YearlyGrade; reg."Yearly Grade")
            {
            }
            column(YearlyFailed; reg."Yearly Failed Units")
            {
            }
            column(YearlyTotalUnits; reg."Yearly Total Units Taken")
            {
            }
            column(CummulativeAverage; reg."Cummulative Average")
            {
            }
            column(CurrAverage; reg."Yearly Average")
            {
            }
            column(YearlyRemarks; TransCriptRemarks)
            {
            }
            column(AcadYear; reg."Academic Year")
            {
            }
            column(sName; UPPERCASE(sName))
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
            column(From100Legend; 'A (70% - 100%)        - Excellent         B (60% - 69%)      - Good       C (50% - 59%)     -Satisfactory ')
            {
            }
            column(From40Legend; 'D (40% - 49%)                - Fair                 E (39% and Below)   - Fail')
            {
            }
            column(PassMarkLegend; 'NOTE:   Pass mark is ' + FORMAT(Passmark) + '%')
            {
            }
            column(DoubleLine; '===============================================================================')
            {
            }
            column(Recomm; 'Recommendation:')
            {
            }
            column(singleLine; '===============================================================================')
            {
            }

            column(TranscriptSignatory; dimVal.Name)
            {
            }

            column(FacultyName; SchoolName)
            {
            }
            column(codSchool; 'COD, ' + SchoolName)
            {
            }
            column(codDept; 'COD,' + DeptName)
            {
            }
            column(dateSigned; 'Date:.......................................................')
            {
            }
            column(PassRemark; PassRemark)
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
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            dataitem(StudUnitsss; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Unit Year of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE("Reg Reversed" = FILTER('No'));
                column(Unit; StudUnitsss.Unit)
                {
                }
                column(Desc; units_Subjects.Desription)
                {
                }
                column(CreditHours; units_Subjects."Credit Hours")
                {
                }
                column(Score; StudUnitsss."Total Score")
                {
                }
                column(Final; StudUnitsss."Final Score")
                {
                }
                column(Grade; StudUnitsss.Grade)
                {
                }
                column(Status; StudUnitsss."Exam Status")
                {
                }
                dataitem(ExamGraddingSetup; 61599)
                {
                    DataItemLink = Category = FIELD("Exam Catogory");
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

                trigger OnAfterGetRecord()
                var
                    ProgCategory: Code[20];
                    ACAExamGraddingSetup: Record 61599;
                begin
                    CLEAR(ProgCategory);
                    StudUnitsss.CALCFIELDS(StudUnitsss."Total Score");
                    // IF StudUnits."Total Score"=0 THEN
                    IF StudUnitsss.Grade = '' THEN StudUnitsss.Grade := '?';
                    units_Subjects.RESET;
                    units_Subjects.SETRANGE("Programme Code", StudUnitsss.Programme);
                    units_Subjects.SETRANGE(Code, StudUnitsss.Unit);
                    IF units_Subjects.FIND('-') THEN BEGIN
                    END;


                    Unitsz.RESET;
                    Unitsz.SETRANGE(Unitsz."Programme Code", StudUnitsss.Programme);
                    Unitsz.SETRANGE(Unitsz.Code, StudUnitsss.Unit);
                    Unitsz.SETRANGE(Unitsz."Old Unit", FALSE);
                    IF Unitsz.FIND('-') THEN BEGIN
                        IF Unitsz."Default Exam Category" <> '' THEN BEGIN
                            ProgCategory := Unitsz."Default Exam Category";
                        END ELSE BEGIN
                            prog.RESET;
                            prog.SETRANGE(prog.Code, StudUnitsss.Programme);
                            IF prog.FIND('-') THEN BEGIN
                                ProgCategory := prog."Exam Category";
                            END;
                        END;
                    END;
                    StudUnitsss."Exam Catogory" := ProgCategory;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                // IF "Course Registration"."Academic Year"<> acadyear THEN
                // CurrReport.SKIP;

                CLEAR(LegendDesc);
                CLEAR(LegendGrade);
                CLEAR(LegendRange);
                CLEAR(Countings);
                CLEAR(SchoolName);
                prog.RESET;
                prog.SETRANGE(prog.Code, reg.Programmes);
                IF prog.FIND('-') THEN BEGIN
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
                    // dimVal.CALCFIELDS(Signature);
                END;

                CLEAR(YearOfStudy);

                YearOfStudy := COPYSTR(reg.Stage, 2, 1);


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                CLEAR(GRADDATE);
                cust.RESET;
                cust.SETRANGE(cust."No.", reg."Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;

                END;
                reg.SETFILTER("Semester Filter", reg.GETFILTER(reg.Semester));
                reg.SETFILTER("Stage Filter", reg.GETFILTER(reg.Stage));
                reg.CALCFIELDS(reg."Cum Units Failed");
                ProgStages.RESET;
                ProgStages.SETRANGE(ProgStages."Programme Code", reg.Programmes);
                ProgStages.SETRANGE(ProgStages.Code, reg.Stage);
                IF ProgStages.FIND('-') THEN BEGIN
                    PassRemark := 'Recommendation: ' + ProgStages.Remarks;
                    IF ProgStages."Final Stage" = TRUE THEN
                        PassRemark := 'Recommendation: ' + reg.Award;
                    IF reg."Cum Units Failed" > 0 THEN
                        PassRemark := 'Recommendation: ' + 'Resit the Failed Units';
                END;

                IntakeRec.RESET;
                IntakeRec.SETRANGE(IntakeRec.Code, reg.Session);
                IF IntakeRec.FIND('-') THEN
                    //YearOfAdmi:=IntakeRec.Description;
                    CourseReg12.RESET;
                CourseReg12.SETRANGE(Programmes, reg.Programmes);
                CourseReg12.SETRANGE("Student No.", reg."Student No.");
                IF CourseReg12.FIND('-') THEN BEGIN
                    //IF CourseReg12."Registration Date"<>0D THEN BEGIN
                    Sem.RESET;
                    Sem.SETRANGE(Code, CourseReg12.Semester);
                    IF Sem.FIND('-') THEN BEGIN
                        IF Sem.From <> 0D THEN BEGIN
                            ACAProgCatTranscriptComm.RESET;
                            ACAProgCatTranscriptComm.SETRANGE("Exam Catogory", prog."Exam Category");
                            IF ACAProgCatTranscriptComm.FIND('-') THEN
                                GRADDATE := FORMAT(DATE2DMY((CALCDATE(FORMAT(ACAProgCatTranscriptComm.COUNT) + 'Y', Sem.From)), 3));
                            YearOfAdmi := Sem.From;
                        END;
                    END;
                END;


                Sem.RESET;
                Sem.SETRANGE(Sem.Code, prog."Semester Filter");
                IF Sem.FIND('-') THEN
                    acadyear := Sem."Academic Year";

                IF prog.GET(prog."Semester Filter") THEN BEGIN
                    i := 1;
                    Gradings.RESET;
                    Gradings.SETRANGE(Gradings.Category, prog."Exam Category");
                    Gradings.ASCENDING := FALSE;
                    IF Gradings.FIND('-') THEN BEGIN
                        REPEAT
                            GLabel[i] := Gradings.Grade + '   (' + Gradings.Range + ') - ' + Gradings.Description;
                            GLabel2[i] := ' - ' + Gradings.Description;
                            IF Gradings.Failed = TRUE THEN
                                Passmark := ROUND(Gradings."Up to", 1);
                            i := i + 1;
                        UNTIL Gradings.NEXT = 0;
                    END;
                END;


                CLEAR(TransCriptRemarks);
                IF reg."Yearly Remarks" <> '' THEN BEGIN
                    ACAResultsStatus.RESET;
                    ACAResultsStatus.SETRANGE(Code, COPYSTR(reg."Yearly Remarks", 1, 50));
                    ACAResultsStatus.SETRANGE("Academic Year", reg."Academic Year");
                    IF ACAResultsStatus.FIND('-') THEN BEGIN
                        TransCriptRemarks := ACAResultsStatus."Transcript Remarks";
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            //CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    trigger OnPreReport()
    begin
        //  IF acadyear='' THEN ERROR('Please specify the academic year.');
    end;

    var
        ACAProgCatTranscriptComm: Record 78020;
        ACAResultsStatus: Record 61739;
        TransCriptRemarks: Text[250];
        CourseReg12: Record 61532;
        GRADDATE: Code[30];
        pName: Text[250];
        units_Subjects: Record 61517;
        Unitsz: Record 61517;
        StudUnits: Record 61549;
        YearOfStudy: Code[10];
        YearOfAdmi: Date;
        SchoolName: Text[250];
        ExamProcess: Codeunit 60276;
        EResults: Record 61548;
        UnitsR: Record 61517;
        "Units/Subj": Record 61517;
        Sem: Record 61692;
        stduntz: Record 61549;
        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;
        Gradings: Record 61599;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record 61599;
        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record 18;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record 61511;
        dimVal: Record 349;
        ProgStages: Record 61516;
        PassRemark: Text[200];
        SemRec: Record 61692;
        Creg: Record 61532;
        IntakeRec: Record 61383;
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
        LegendRange: array[6] of Code[20];
        LegendGrade: array[6] of Code[2];
        LegendDesc: array[6] of Code[50];
        ACAExamGraddingSetup: Record 61599;
        Countings: Integer;
        reg: record "ACA-Course Registration";
}

