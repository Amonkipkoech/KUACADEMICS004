report 66666 "Final Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Final Transcript.rdl';
    Caption = 'Final Transcript';

    dataset
    {
        dataitem(Coregs; 66631)
        {
            CalcFields = "Admissions Date", "Graduation Date";
            DataItemTableView = WHERE(Graduating = FILTER('Yes'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "School Code", Programme, "Student Number", "Graduation Academic Year", "Year of Study";
            column(StudNo; Coregs."Student Number")
            {
            }
            column(ProgClassInt; ProgClassInt)
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
            column(AdmissionDates; ACAAcademicYear369."Admission Date")
            {
            }
            column(GradDates; gradDates)
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
            column(signedSignature; dimVal.Signature)
            {
            }
            column(TranscriptSignatory; dimVal."HOD Names")
            {
            }
            column(TransCriptTitle; dimVal.Titles)
            {
            }
            column(ExamCategory; prog."Exam Category")
            {
            }
            column(FacultyName; UPPERCASE(dimVal."Faculty Name"))
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
            column(PassGrade; PassGrade)
            {
            }
            column(PassRemarks; PassRemarks)
            {
            }
            dataitem(UnitsReg; 66632)
            {
                DataItemLink = "Student No." = FIELD("Student Number"),
                               Programme = FIELD(Programme),
                               "Year of Study" = FIELD("Year of Study"),
                               "Graduation Academic Year" = FIELD("Graduation Academic Year");
                DataItemTableView = WHERE("Total Score" = FILTER(<> ''));
                column(Unit; UnitsReg."Unit Code")
                {
                }
                column(Desc; units_Subjects.Desription)
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
                column(AcadHours; units_Subjects."Academic Hours")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    units_Subjects.RESET;
                    units_Subjects.SETRANGE(units_Subjects."Programme Code", UnitsReg.Programme);
                    units_Subjects.SETRANGE(units_Subjects.Code, UnitsReg."Unit Code");
                    IF units_Subjects.FIND('-') THEN BEGIN

                    END;
                    IF UnitsReg.Grade = 'P' THEN PExists := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PassRemarks := '';
                PassGrade := '';
                ACAClassificationUnits369.RESET;
                ACAClassificationUnits369.SETRANGE(ACAClassificationUnits369."Student No.", Coregs."Student Number");
                ACAClassificationUnits369.SETRANGE("Year of Study", Coregs."Year of Study");
                ACAClassificationUnits369.SETRANGE(Programme, Coregs.Programme);
                ACAClassificationUnits369.SETRANGE(ACAClassificationUnits369.Grade, 'P');
                IF ACAClassificationUnits369.FIND('-') THEN BEGIN
                    PassRemarks := 'PASS';
                    PassGrade := 'P';
                END;
                CLEAR(gradDates);
                prog.RESET;
                prog.SETRANGE(prog.Code, Coregs.Programme);
                IF prog.FIND('-') THEN;
                ACACourseRegistration369.RESET;
                ACACourseRegistration369.SETRANGE(ACACourseRegistration369."Student No.", Coregs."Student Number");
                ACACourseRegistration369.SETFILTER(ACACourseRegistration369.Reversed, '%1', FALSE);
                ACACourseRegistration369.SETCURRENTKEY(ACACourseRegistration369.Semester);
                IF ACACourseRegistration369.FIND('-') THEN BEGIN
                    Sem.RESET;
                    Sem.SETRANGE(sem.Code, ACACourseRegistration369.Semester);
                    IF Sem.FIND('-') THEN BEGIN
                        ACAAcademicYear369.RESET;
                        ACAAcademicYear369.SETRANGE(ACAAcademicYear369.Code, Sem."Academic Year");
                        IF ACAAcademicYear369.FIND('-') THEN BEGIN
                            //Coregs."Admissions Date":=ACAAcademicYear369."Admission Date";
                            IF ((prog.Category = prog.Category::Certificate) OR (prog.Category = prog.Category::"Course List") OR (prog.Category = prog.Category::Professional)) THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Certificate)");
                                gradDates := ACAAcademicYear369."Graduation Date (Certificate)";
                            END;
                            IF ((prog.Category = prog.Category::Diploma)) THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Diploma)");
                                gradDates := ACAAcademicYear369."Graduation Date (Diploma)";
                            END;
                            IF ((prog.Category = prog.Category::Postgraduate)) THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Masters)");
                                gradDates := ACAAcademicYear369."Graduation Date (Masters)";
                            END;
                            IF ((prog.Category = prog.Category::Undergraduate)) THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Degree)");
                                gradDates := ACAAcademicYear369."Graduation Date (Degree)";
                            END;
                            IF prog."Special Programme Class" = prog."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Medicine)");
                                gradDates := ACAAcademicYear369."Graduation Date (Medicine)";
                            END;
                            IF prog."Special Programme Class" = prog."Special Programme Class"::Engineering THEN BEGIN
                                ACAAcademicYear369.TESTFIELD(ACAAcademicYear369."Graduation Date (Engineering)");
                                gradDates := ACAAcademicYear369."Graduation Date (Engineering)";
                            END;
                        END;
                    END;
                END;

                CLEAR(LegendDesc);
                CLEAR(LegendGrade);
                CLEAR(LegendRange);
                CLEAR(Countings);
                CLEAR(SchoolName);
                CLEAR(Countings);
                CLEAR(ProgClassInt);
                prog.RESET;
                prog.SETRANGE(prog.Code, Coregs.Programme);
                IF prog.FIND('-') THEN BEGIN
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
                ACAProgCatTranscriptComm.SETRANGE(ACAProgCatTranscriptComm."Exam Catogory", prog."Exam Category");
                ACAProgCatTranscriptComm.SETRANGE("Year of Study", Coregs."Year of Study");
                IF ACAProgCatTranscriptComm.FIND('-') THEN BEGIN
                    IF Coregs."Final Classification Pass" THEN
                        PassRemark := ACAProgCatTranscriptComm."Pass Comment"
                    ELSE
                        PassRemark := ACAProgCatTranscriptComm."Failed Comment";
                    IF ACAProgCatTranscriptComm."Include Programme Name" THEN PassRemark := PassRemark + ' ' + prog.Description;
                    PassRemark := UPPERCASE(PassRemark);
                    TransCriptRemarks := PassRemark;
                END;

                ACAAcademicYear.RESET;
                ACAAcademicYear.SETRANGE(ACAAcademicYear.Code, CourseReg12."Academic Year");
                IF ACAAcademicYear.FIND('-') THEN BEGIN
                    GRADDATE := ACAAcademicYear."Graduation Date (Degree)";
                END;
                CourseReg12.RESET;
                CourseReg12.SETRANGE(CourseReg12."Student No.", Coregs."Student Number");
                CourseReg12.SETRANGE("Year Of Study", Coregs."Year of Study");
                CourseReg12.SETFILTER(CourseReg12.Reversed, '%1', FALSE);
                IF CourseReg12.FIND('-') THEN;
                YearOfAdmi := Coregs."Admission Date";
                acadyear := CourseReg12."Academic Year";
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
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
        END;
    end;

    trigger OnPreReport()
    begin
        CLEAR(PExists);
    end;

    var
        gradDates: Date;
        ACAClassificationUnits369: Record 66632;
        PassRemarks: Code[10];
        PassGrade: Code[10];
        ACAAcademicYear369: Record 61382;
        ProgClassInt: Code[10];
        ACAProgCatTranscriptComm: Record 78020;
        ACAResultsStatus: Record 61739;
        TransCriptRemarks: Text[250];
        CourseReg12: Record 61532;
        GRADDATE: Date;
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Date;
        SchoolName: Text[250];
        ExamProcess: Codeunit 60276;
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
        LegendRange: array[40] of Code[20];
        LegendGrade: array[40] of Code[2];
        LegendDesc: array[40] of Code[50];
        ACAExamGraddingSetup: Record 61599;
        Countings: Integer;
        ACAAcademicYear: Record 61382;
        ACACourseRegistration369: Record 61532;
        PExists: Boolean;
}

