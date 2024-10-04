report 51773 "Official College Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Official College Transcript.rdl';

    dataset
    {
        dataitem(Coregs; 66631)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "School Code", Programme, "Student Number";
            column(StudNo; Coregs."Student Number")
            {
            }
            column(Prog; Coregs.Programme)
            {
            }
            column(Sem; '')
            {
            }
            column(Stag; '')
            {
            }
            column(CumSc; Coregs."Total Marks")
            {
            }
            column(CurrSem; Coregs."Total Marks")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(YoS; Coregs."Year of Study")
            {
            }
            column(TotalYearlyMarks; Coregs."Total Marks")
            {
            }
            column(YearlyAverage; Coregs."Normal Average")
            {
            }
            column(YearlyGrade; Coregs."Final Classification Grade")
            {
            }
            column(YearlyFailed; Coregs."Failed Courses")
            {
            }
            column(YearlyTotalUnits; Coregs."Total Courses")
            {
            }
            column(YearlyRemarks; TransCriptRemarks)
            {
            }
            column(AcadYear; Coregs."Graduation Academic Year")
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
            column(SchoolNamez; SchoolName)
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
            // column(signedSignature;dimVal.Signature)
            // {
            // }
            // column(TranscriptSignatory;dimVal."HOD Names")
            // {
            // }
            // column(TransCriptTitle;dimVal.Titles)
            // {
            // }
            column(ExamCategory; prog."Exam Category")
            {
            }
            // column(FacultyName;UPPERCASE(dimVal."Faculty Name"))
            // {
            // }
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
            dataitem(UnitsReg; 66632)
            {
                DataItemLink = "Student No." = FIELD("Student Number"),
                               Programme = FIELD(Programme),
                               "Year of Study" = FIELD("Year of Study");
                DataItemTableView = WHERE("Use In Classification" = FILTER('Yes'));
                column(Unit; UnitsReg."Unit Code")
                {
                }
                column(Desc; UnitsReg."Unit Description")
                {
                }
                column(Score; UnitsReg."Total Score Decimal")
                {
                }
                column(Final; UnitsReg."Weighted Total Score")
                {
                }
                column(Grade; UnitsReg.Grade)
                {
                }
                column(Status; '')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    units_Subjects.RESET;
                    units_Subjects.SETRANGE("Programme Code", UnitsReg.Programme);
                    units_Subjects.SETRANGE(Code, UnitsReg."Unit Code");
                    IF units_Subjects.FIND('-') THEN BEGIN

                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(LegendDesc);
                CLEAR(LegendGrade);
                CLEAR(LegendRange);
                CLEAR(Countings);
                CLEAR(SchoolName);
                prog.RESET;
                prog.SETRANGE(Code, Coregs.Programme);
                IF prog.FIND('-') THEN BEGIN
                    prog.TESTFIELD("Exam Category");
                    ACAExamGraddingSetup.RESET;
                    ACAExamGraddingSetup.SETRANGE(Category, prog."Exam Category");
                    IF ACAExamGraddingSetup.SETCURRENTKEY(Grade) THEN;
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

                YearOfStudy := FORMAT(Coregs."Year of Study");


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                CLEAR(GRADDATE);
                cust.RESET;
                cust.SETRANGE(cust."No.", Coregs."Student Number");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;

                END;



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


                CLEAR(TransCriptRemarks);
                CLEAR(PassRemark);
                ACAProgCatTranscriptComm.RESET;
                ACAProgCatTranscriptComm.SETRANGE("Exam Catogory", prog."Exam Category");
                ACAProgCatTranscriptComm.SETRANGE("Year of Study", Coregs."Year of Study");
                IF ACAProgCatTranscriptComm.FIND('-') THEN BEGIN
                    IF Coregs."Final Classification Pass" THEN
                        PassRemark := ACAProgCatTranscriptComm."Pass Comment"
                    ELSE
                        PassRemark := ACAProgCatTranscriptComm."Failed Comment";
                    TransCriptRemarks := PassRemark;
                END;

                GRADDATE := Coregs."Final Stage";
                YearOfAdmi := Coregs."Admission Date";
                acadyear := Coregs."Graduation Academic Year";
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
        END;
    end;

    var
        ACAProgCatTranscriptComm: Record 78020;
        ACAResultsStatus: Record 61739;
        TransCriptRemarks: Text[250];
        CourseReg12: Record 61532;
        GRADDATE: Code[30];
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Date;
        SchoolName: Text[250];
        //ExamProcess: Codeunit 60276;
        EResults: Record 61548;
        UnitsR: Record 61517;
        "Units/Subj": Record 61517;
        Sem: Record 61692;
        StudUnits: Record 61549;
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
}

