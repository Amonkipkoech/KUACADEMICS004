report 51587 "Sems. Consolidated Marksheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Sems. Consolidated Marksheet.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = CONST(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Year Of Study", "Academic Year", "Student No.", Programmes, Stage, Semester, Session;
            column(StudNo; "ACA-Course Registration"."Student No.")
            {
            }
            column(Prog; "ACA-Course Registration".Programmes)
            {
            }
            column(Sem; "ACA-Course Registration".Semester)
            {
            }
            column(Stag; "ACA-Course Registration".Stage)
            {
            }
            column(CumSc; "ACA-Course Registration"."Cumm Score")
            {
            }
            column(CurrSem; "ACA-Course Registration"."Current Cumm Score")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(YoS; "ACA-Course Registration"."Year Of Study")
            {
            }
            column(TotalYearlyMarks; "ACA-Course Registration"."Total Yearly Marks")
            {
            }
            column(YearlyAverage; "ACA-Course Registration"."Yearly Average")
            {
            }
            column(YearlyGrade; "ACA-Course Registration"."Yearly Grade")
            {
            }
            column(YearlyFailed; "ACA-Course Registration"."Yearly Failed Units")
            {
            }
            column(YearlyTotalUnits; "ACA-Course Registration"."Yearly Total Units Taken")
            {
            }
            column(YearlyRemarks; "ACA-Course Registration"."Yearly Remarks")
            {
            }
            column(TotalSemMarks; "ACA-Course Registration"."Total Semester Marks")
            {
            }
            column(SemAverage; "ACA-Course Registration"."Semester Average")
            {
            }
            column(SemGrade; "ACA-Course Registration"."Semester Grade")
            {
            }
            column(SemFailed; "ACA-Course Registration"."Semester Failed Units")
            {
            }
            column(SemTotalUnits; "ACA-Course Registration"."Semester Total Units Taken")
            {
            }
            column(SemRemarks; "ACA-Course Registration"."Semester Remarks")
            {
            }
            column(SemUnitsPassed; "ACA-Course Registration"."Semester Total Units Taken" - "ACA-Course Registration"."Semester Failed Units")
            {
            }
            column(CommAverage; "ACA-Course Registration"."Cummulative Average")
            {
            }
            column(CummGrade; "ACA-Course Registration"."Cummulative Grade")
            {
            }
            column(CumScore; "ACA-Course Registration"."Cummulative Score")
            {
            }
            column(CumUnits; "ACA-Course Registration"."Cummulative Units Taken")
            {
            }
            column(CumUnits2; "ACA-Course Registration"."Cummulative Units")
            {
            }
            column(CummMarks; "ACA-Course Registration"."Cummulative Marks")
            {
            }
            column(CummAward; "ACA-Course Registration".Award)
            {
            }
            column(sName; sName)
            {
            }
            column(pName; pName)
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
            column(acadyear; acadyear)
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
            column(FacultyName; dimVal."Faculty Name")
            {
            }
            column(codSchool; dimVal.Name)
            {
            }
            column(codDept; dimVal.Code)
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
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Year Of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE(Reversed = FILTER(false));
                column(Unit; "ACA-Student Units".Unit)
                {
                }
                column(Desc; "ACA-Student Units".Description)
                {
                }
                column(Score; "ACA-Student Units"."Total Marks")
                {
                }
                column(Final; "ACA-Student Units"."Final Score")
                {
                }
                column(Grade; "ACA-Student Units".Grade)
                {
                }
                column(Status; "ACA-Student Units"."Exam Status")
                {
                }
                column(ScoreLabel; ScoreLabel)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(ScoreLabel);
                    IF (("ACA-Student Units"."Total Marks" <> 0) AND ("ACA-Student Units".Grade <> '')) THEN ScoreLabel := '[' + FORMAT("ACA-Student Units"."Total Marks") + '][' + "ACA-Student Units".Grade + ']';
                    "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Total Score");
                    // IF "ACA-Student Units"."Total Score"=0 THEN
                    //"ACA-Student Units".Grade:='E';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SchoolName);
                CLEAR(pName);
                IF prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                    pName := prog.Description;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'School');
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
                    //dimVal.CALCFIELDS(Signature);
                END;

                CLEAR(YearOfStudy);

                YearOfStudy := COPYSTR("ACA-Course Registration".Stage, 2, 1);


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;
                END;


                Sem.RESET;
                Sem.SETRANGE(Sem.Code, "ACA-Course Registration".Semester);
                IF Sem.FIND('-') THEN
                    acadyear := Sem."Academic Year";
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

    trigger OnPreReport()
    begin
        //  IF acadyear='' THEN ERROR('Please specify the academic year.');
    end;

    var
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];
        Sem: Record 61692;
        StudUnits: Record 61549;
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
        ScoreLabel: Code[10];

}

