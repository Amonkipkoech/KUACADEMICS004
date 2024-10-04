report 78013 "Final Consolidate Marksheet 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/FinalConsolidateMarksheet1.rdl';

    dataset
    {
        dataitem("Fin. Consolid. Marksheet Cntrl"; 78007)
        {
            DataItemTableView = SORTING("Grad. Academic Year", "Programme Code", "Programme Option", "Academic Year", "Year of Study")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(GradAcadYear; "Fin. Consolid. Marksheet Cntrl"."Grad. Academic Year")
            {
            }
            column(GradGroup; '')
            {
            }
            column(Prog; "Fin. Consolid. Marksheet Cntrl"."Programme Code")
            {
            }
            column(ProgOption; "Fin. Consolid. Marksheet Cntrl"."Programme Option")
            {
            }
            column(AcademicYears; "Fin. Consolid. Marksheet Cntrl"."Academic Year")
            {
            }
            column(ProgOptionName; "Fin. Consolid. Marksheet Cntrl"."Prog. Option Name")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(pName; pName)
            {
            }
            column(SchoolName; SchoolName)
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
            column(FacultyName; SchoolName)
            {
            }
            column(codSchool; dimVal.Name)
            {
            }
            column(codDept; dimVal.Code)
            {
            }
            column(DeptName; DeptName)
            {
            }
            dataitem("ACA-Course Registration"; 61532)
            {
                DataItemLink = Programmes = FIELD("Programme Code"),
                               "Academic Year" = FIELD("Academic Year"),
                               Options = FIELD("Programme Option"),
                               "Graduation Academic Year" = FIELD("Grad. Academic Year"),
                               "Year Of Study" = FIELD("Year of Study");
                DataItemTableView = SORTING("Year of Admission", "Student No.")
                                    ORDER(Ascending)
                                    WHERE(Reversed = CONST(false));
                PrintOnlyIfDetail = true;
                RequestFilterFields = Programmes, "Graduation Academic Year", "Year Of Study", Options;
                column(GroupingConcortion; "ACA-Course Registration"."Academic Year" + "ACA-Course Registration".Programmes + DeptName + SchoolName + "ACA-Course Registration".Options + FORMAT("ACA-Course Registration"."Year Of Study"))
                {
                }
                column(StudNo; "ACA-Course Registration"."Student No.")
                {
                }
                column(StudentNoAcademicYear; StudentNoAcademicYear)
                {
                }
                column(CountedDistinct; "ACA-Course Registration"."Student No." + "ACA-Course Registration"."Supp. Yearly Remarks")
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
                column(Option; ACAProgrammeOptions.Desription)
                {
                }
                column(YoS; "ACA-Course Registration"."Year Of Study")
                {
                }
                column(TotalYearlyMarks; "ACA-Course Registration"."Supp. Total Yearly Marks")
                {
                }
                column(YearlyAverage; "ACA-Course Registration"."Supp. Yearly Average")
                {
                }
                column(YearlyGrade; "ACA-Course Registration"."Supp. Yearly Grade")
                {
                }
                column(YearlyPassed; "ACA-Course Registration"."Supp. Yearly Passed Units")
                {
                }
                column(YearlyFailed; "ACA-Course Registration"."Supp. Yearly Failed Units")
                {
                }
                column(YearlyTotalUnits; "ACA-Course Registration"."Supp. Yearly Total Units Taken")
                {
                }
                column(YearlyRemarks; "ACA-Course Registration"."Supp. Yearly Remarks")
                {
                }
                column(TotalSemMarks; "ACA-Course Registration"."Supp. Total Semester Marks")
                {
                }
                column(YearlyWeightedTotal; "ACA-Course Registration"."Supp. Yearly Weighted Total")
                {
                }
                column(YearlyGradUnitsCount; "ACA-Course Registration"."Yearly Graduating Units Count")
                {
                }
                column(YearlyGradWeigUnits; "ACA-Course Registration"."Yearly Grad. Weighted Units")
                {
                }
                column(YearlyGradWAverage; "ACA-Course Registration"."Yearly Grad. W. Average")
                {
                }
                column(FinClass; "ACA-Course Registration"."Final Clasification")
                {
                }
                column(YearlyCFFailed; "ACA-Course Registration"."Supp. Yearly CF% Failed")
                {
                }
                column(YearlyCurrAverage; ROUND("ACA-Course Registration"."Supp. Yearly Curr. Average", 1, '='))
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
                column(SemCurrAverage; "ACA-Course Registration"."Semester Curr. Average")
                {
                }
                column(SemCFFailed; "ACA-Course Registration"."Semester CF% Failed")
                {
                }
                column(SemWeifgtedTotal; "ACA-Course Registration"."Semester Weighted Total")
                {
                }
                column(CommAverage; "ACA-Course Registration"."Supp. Cummulative Average")
                {
                }
                column(CummGrade; "ACA-Course Registration"."Supp. Cummulative Grade")
                {
                }
                column(CumScore; "ACA-Course Registration"."Supp. Cummulative Marks")
                {
                }
                column(CumUnits; "ACA-Course Registration"."Supp. Yearly Total Units Taken")
                {
                }
                column(CumUnits2; "ACA-Course Registration"."Supp. Cummulative Units")
                {
                }
                column(CummMarks; "ACA-Course Registration"."Supp. Cummulative Marks")
                {
                }
                column(CoursesFailed; "ACA-Course Registration"."Supp. Yearly Failed Courses")
                {
                }
                column(CummAward; "ACA-Course Registration".Award)
                {
                }
                column(cc; cc)
                {
                }
                column(YOSText; YOSTewxt)
                {
                }
                column(sName; sName)
                {
                }
                column(YearOfStudy; YearOfStudy)
                {
                }
                column(YearOfAdmi; YearOfAdmi)
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
                column(OrdersOfSum; ACAResultsStatus."Order No")
                {
                }
                column(GenCourseSuppExists; GenCourseSuppExists)
                {
                }
                dataitem("ACA-Student Units"; 61549)
                {
                    DataItemLink = "Student No." = FIELD("Student No."),
                                   "Year Of Study" = FIELD("Year Of Study");
                    DataItemTableView = WHERE(Taken = FILTER(true),
                                              "Old Unit" = FILTER(false));
                    column(Unit; "ACA-Student Units".Unit)
                    {
                    }
                    column(UnitDesc; "ACA-Student Units"."Unit Description")
                    {
                    }
                    column(Score; "ACA-Student Units"."Supp. Total Marks")
                    {
                    }
                    column(Final; "ACA-Student Units"."Supp. Total Marks")
                    {
                    }
                    column(Grade; "ACA-Student Units"."Supp. Grade")
                    {
                    }
                    column(Status; "ACA-Student Units"."Exam Status")
                    {
                    }
                    column(ScoreLabel; ScoreLabel)
                    {
                    }
                    column(Units; "ACA-Student Units".Units)
                    {
                    }
                    column(StageUnit; "ACA-Student Units".Stage)
                    {
                    }
                    column(counts; MksCounts.Serial)
                    {
                    }
                    column(SuppExists; SuppExists)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //--------------------------------------------------------------------------------------------------------------------------
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////
                        MksCounts.RESET;
                        MksCounts.SETRANGE(MksCounts."Student No.", "ACA-Student Units"."Student No.");
                        MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT("ACA-Course Registration"."Year Of Study"));
                        MksCounts.SETRANGE(MksCounts.Programme, "ACA-Course Registration".Programmes);
                        MksCounts.SETRANGE(MksCounts.Option, "ACA-Course Registration".Options);
                        MksCounts.SETRANGE(MksCounts."Academic Year", "ACA-Course Registration"."Graduation Academic Year");
                        MksCounts.SETRANGE(MksCounts."User Id", USERID);
                        IF NOT MksCounts.FIND('-') THEN BEGIN
                            //REPEAT
                            counts := counts + 1;
                            MksCounts.INIT;
                            MksCounts."Student No." := "ACA-Course Registration"."Student No.";
                            MksCounts."Year of Study" := FORMAT("ACA-Course Registration"."Year Of Study");
                            MksCounts.Programme := "ACA-Course Registration".Programmes;
                            MksCounts.Option := "ACA-Course Registration".Options;
                            MksCounts."Academic Year" := "ACA-Course Registration"."Graduation Academic Year";
                            MksCounts.Serial := counts;
                            MksCounts."User Id" := USERID;
                            MksCounts.INSERT;
                            //UNTIL MksCounts.NEXT=0;
                        END;
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////
                        MksCounts.RESET;
                        MksCounts.SETRANGE(MksCounts."Student No.", "ACA-Course Registration"."Student No.");
                        MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT("ACA-Course Registration"."Year Of Study"));
                        MksCounts.SETRANGE(MksCounts.Programme, "ACA-Course Registration".Programmes);
                        MksCounts.SETRANGE(MksCounts.Option, "ACA-Course Registration".Options);
                        MksCounts.SETRANGE(MksCounts."Academic Year", "ACA-Course Registration"."Academic Year");
                        MksCounts.SETRANGE(MksCounts."User Id", USERID);
                        IF MksCounts.FIND('-') THEN;// counts:=counts+1;
                        //--------------------------------------------------------------------------------------------------------------------------
                        CLEAR(ScoreLabel);
                        "ACA-Student Units".CALCFIELDS("ACA-Student Units"."CATs Marks Exists", "ACA-Student Units"."EXAMs Marks Exists");
                        IF (("ACA-Student Units"."CATs Marks Exists" = FALSE) AND ("ACA-Student Units"."EXAMs Marks Exists" = FALSE)) THEN BEGIN
                            ScoreLabel := 'X';
                        END ELSE BEGIN
                            ScoreLabel := FORMAT("ACA-Student Units"."Supp. Total Marks");
                            ScoreLabel := ScoreLabel + "ACA-Student Units"."Supp. Cons. Mark Pref.";

                        END;
                        //IF ("ACA-Student Units"."Total Marks"<>0)  THEN ScoreLabel:=FORMAT("ACA-Student Units"."Total Marks")
                        //ELSE
                        // "ACA-Student Units".CALCFIELDS("ACA-Student Units"."Supp. Total Score");
                        IF (("ACA-Course Registration"."Supp. Yearly Remarks" = 'EXPELLED') OR
                         ("ACA-Course Registration"."Supp. Yearly Remarks" = 'SUSPENDED') OR
                         ("ACA-Course Registration"."Supp. Yearly Remarks" = 'EXPULSION')) THEN
                            ScoreLabel := '-';
                        CLEAR(SuppExists);
                        // //   "ACA-Student Units".CALCFIELDS("ACA-Student Units"."No of Supplementaries");
                        // //   IF "ACA-Student Units"."No of Supplementaries">0 THEN SuppExists:=TRUE;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF "ACA-Course Registration".Options <> '' THEN BEGIN
                        ACAProgrammeOptions.RESET;
                        ACAProgrammeOptions.SETRANGE("Programme Code", "ACA-Course Registration".Programmes);
                        ACAProgrammeOptions.SETRANGE(Code, "ACA-Course Registration".Options);
                        IF ACAProgrammeOptions.FIND('-') THEN BEGIN
                        END;
                    END;

                    CLEAR(StudentNoAcademicYear);
                    IF STRLEN("ACA-Course Registration"."Student No.") > 2 THEN BEGIN
                        StudentNoAcademicYear := COPYSTR("ACA-Course Registration"."Student No.", ((STRLEN("ACA-Course Registration"."Student No.")) - 1), 2);
                    END;

                    CLEAR(YOSTewxt);
                    IF "ACA-Course Registration"."Year Of Study" = 1 THEN YOSTewxt := 'First Year';
                    IF "ACA-Course Registration"."Year Of Study" = 2 THEN YOSTewxt := 'Second Year';
                    IF "ACA-Course Registration"."Year Of Study" = 3 THEN YOSTewxt := 'Third Year';
                    IF "ACA-Course Registration"."Year Of Study" = 4 THEN YOSTewxt := 'Fourth Year';
                    IF "ACA-Course Registration"."Year Of Study" = 5 THEN YOSTewxt := 'Fifth Year';
                    IF "ACA-Course Registration"."Year Of Study" = 6 THEN YOSTewxt := 'Sixth Year';
                    IF "ACA-Course Registration"."Year Of Study" = 7 THEN YOSTewxt := 'Seventh Year';
                    CLEAR(SchoolName);
                    CLEAR(pName);
                    prog.RESET;
                    prog.SETRANGE(Code, "ACA-Course Registration".Programmes);
                    IF prog.FIND('-') THEN BEGIN
                        pName := prog.Description;
                        dimVal.RESET;
                        dimVal.SETRANGE(dimVal."Dimension Code", 'FACULTY');
                        dimVal.SETRANGE(dimVal.Code, prog."School Code");
                        IF dimVal.FIND('-') THEN BEGIN
                            SchoolName := dimVal.Name;
                        END;
                    END;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'DEPARTMENT');
                    dimVal.SETRANGE(dimVal.Code, prog."Department Code");
                    IF dimVal.FIND('-') THEN BEGIN
                        DeptName := dimVal.Name;
                        //   dimVal.CALCFIELDS(Signature);
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
                    /*
                    MksCounts.RESET;
                    IF MksCounts.FIND('+') THEN counts:=MksCounts.Serials+1
                    ELSE counts:=1; */

                    Sem.RESET;
                    Sem.SETRANGE(Sem.Code, "ACA-Course Registration".Semester);
                    IF Sem.FIND('-') THEN
                        acadyear := Sem."Academic Year";

                    ACAResultsStatus.RESET;
                    ACAResultsStatus.SETRANGE(Code, "ACA-Course Registration"."Supp. Yearly Remarks");
                    IF ACAResultsStatus.FIND('-') THEN;

                    IF (("ACA-Course Registration"."Yearly Remarks" = 'EXPELLED') OR
                     ("ACA-Course Registration"."Yearly Remarks" = 'SUSPENDED') OR
                     ("ACA-Course Registration"."Yearly Remarks" = 'EXPULSION')) THEN BEGIN
                        "ACA-Course Registration"."Supp. Yearly Total Units Taken" := 0;
                        "ACA-Course Registration"."Supp. Yearly Weighted Total" := 0;
                        "ACA-Course Registration"."Supp. Yearly Passed Units" := 0;
                        "ACA-Course Registration"."Supp. Yearly Failed Units" := 0;
                        "ACA-Course Registration"."Supp. Yearly CF% Failed" := 0;
                        "ACA-Course Registration"."Supp. Yearly Failed Courses" := 0;
                        "ACA-Course Registration"."Supp. Yearly Curr. Average" := 0;
                    END;

                    CLEAR(GenCourseSuppExists);
                    // // "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Supplementary Exists");
                    // // IF "ACA-Course Registration"."Supplementary Exists" THEN GenCourseSuppExists:=TRUE;

                end;

                trigger OnPostDataItem()
                begin
                    // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
                end;

                trigger OnPreDataItem()
                begin
                    cc := 0;
                    CLEAR(counts);
                    ACACourseRegistration.COPYFILTERS("ACA-Course Registration");
                    ACACourseRegistration.SETRANGE(Reversed, FALSE);
                    ACACourseRegistration.SETCURRENTKEY(ACACourseRegistration."Year of Admission", ACACourseRegistration."Student No.");
                    IF ACACourseRegistration.FIND('-') THEN BEGIN
                        MksCounts.RESET;
                        MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT(ACACourseRegistration."Year Of Study"));
                        MksCounts.SETRANGE(MksCounts.Programme, ACACourseRegistration.Programmes);
                        MksCounts.SETRANGE(MksCounts.Option, ACACourseRegistration.Options);
                        MksCounts.SETRANGE(MksCounts."Academic Year", ACACourseRegistration."Graduation Academic Year");
                        MksCounts.SETRANGE(MksCounts."User Id", USERID);
                        IF MksCounts.FIND('-') THEN MksCounts.DELETEALL;
                        /*REPEAT
                          BEGIN

                         END;
                         UNTIL ACACourseRegistration.NEXT=0;*/
                    END;
                    /* ELSE BEGIN
                     counts:=MksCounts.Serials;
                     END;*/
                    CLEAR(counts);
                    "ACA-Course Registration".SETCURRENTKEY("ACA-Course Registration"."Year of Admission", "ACA-Course Registration"."Student No.");

                end;
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
        ACAResultsStatus: Record 61739;
        ACACourseRegistration: Record 61532;
        StudentNoAcademicYear: Code[10];
        counts: Integer;
        MksCounts: Record 69264 temporary;
        pName: Text[250];

        YearOfStudy: Code[10];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];

        Sem: Record 61692;
        StudUnits: Record 61549;

        sName: Text[250];
        cust: Record 18;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record 61511;
        dimVal: Record 349;
        ProgStages: Record 61516;
        PassRemark: Text[200];

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
        ScoreLabel: Text[20];
        YOSTewxt: Text[20];
        cc: Integer;
        ACAProgrammeOptions: Record 61554;
        FacDesc: Code[20];
        SuppExists: Boolean;
        GenCourseSuppExists: Boolean;
}

