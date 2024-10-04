report 51772 "Provisional College Transcript"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Provisional College Transcript.rdl';

    dataset
    {
        dataitem(CourseRegs; 66651)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student Number", Programme, "School Code", "Academic Year", "Year of Study";
            column(StudNo; CourseRegs."Student Number")
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
            column(YearlyRemarks; CourseRegs."Provisional Transcript Remark")
            {
            }
            column(AcadYear; CourseRegs."Academic Year")
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
            // column(signedSignature; dimVal.Signature)
            // {
            // }
            // column(TranscriptSignatory; dimVal."HOD Names")
            // {
            // }
            // column(TransCriptTitle; dimVal.Titles)
            // {
            // }
            column(FacultyName; SchoolName)
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
            dataitem(StudUnitsss; 66650)
            {
                CalcFields = "Grade Comment", "Comsolidated Prefix", Pass, Grade;
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

                trigger OnAfterGetRecord()
                var
                    ProgCategory: Code[20];
                    ACAExamGraddingSetup: Record 61599;
                begin
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(LegendDesc);
                CLEAR(LegendGrade);
                CLEAR(LegendRange);
                CLEAR(Countings);
                CLEAR(SchoolName);

                pName := prog.Description;
                dimVal.RESET;
                dimVal.SETRANGE(dimVal."Dimension Code", 'FACULTY');
                dimVal.SETRANGE(dimVal.Code, prog."School Code");
                IF dimVal.FIND('-') THEN BEGIN
                    SchoolName := dimVal.Name;
                END;
                dimVal.RESET;
                dimVal.SETRANGE(dimVal."Dimension Code", 'Department');
                dimVal.SETRANGE(dimVal.Code, prog."Department Code");
                IF dimVal.FIND('-') THEN BEGIN
                    DeptName := dimVal.Name;
                    // dimVal.CALCFIELDS(Signature);
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
                CourseReg12.SETRANGE(Programmes, CourseRegs.Programme);
                CourseReg12.SETRANGE("Student No.", "Student Number");
                IF CourseReg12.FIND('-') THEN BEGIN
                    //IF CourseReg12."Registration Date"<>0D THEN BEGIN
                    Sem.RESET;
                    Sem.SETRANGE(Code, CourseReg12.Semester);
                    IF Sem.FIND('-') THEN BEGIN
                        IF Sem.From <> 0D THEN BEGIN
                            ACAProgCatTranscriptComm.RESET;
                            //ACAProgCatTranscriptComm.SETRANGE("Exam Category");
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
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var

        ACAProgCatTranscriptComm: Record 78020;
        TransCriptRemarks: Text[250];
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
        LegendRange: array[6] of Code[20];
        LegendGrade: array[6] of Code[2];
        LegendDesc: array[6] of Code[50];
        ACAExamGraddingSetup: Record 61599;
        Countings: Integer;

}

