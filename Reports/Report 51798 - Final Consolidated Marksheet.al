report 51798 "Final Consolidated Marksheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Final Consolidated Marksheet.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61532)
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE(Reversed = FILTER('No'),
                                    "Yearly Total Units Taken" = FILTER(> 0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Year Of Study", "Academic Year", "Student No.", Programmes, Stage, Semester, Session, "Program Option (Flow)";
            column(counts; MksCounts.Serial)
            {
            }
            column(GroupingConcortion; "Academic Year" + Programmes + DeptName + SchoolName + "Program Option (Flow)" + FORMAT("Year Of Study"))
            {
            }
            column(ConcBackup; "Academic Year" + Programmes + DeptName + SchoolName + "Program Option (Flow)" + FORMAT("Year Of Study"))
            {
            }
            column(StudNo; "Student No.")
            {
            }
            column(StudentNoAcademicYear; StudentNoAcademicYear)
            {
            }
            column(CountedDistinct; "Student No." + "Yearly Remarks")
            {
            }
            column(Prog; Programmes)
            {
            }
            column(Sem; Semester)
            {
            }
            column(Stag; Stage)
            {
            }
            column(CumSc; "Cumm Score")
            {
            }
            column(CurrSem; "Current Cumm Score")
            {
            }
            column(Option; "Program Option (Flow)")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(YoS; "Year Of Study")
            {
            }
            column(TotalYearlyMarks; "Total Yearly Marks")
            {
            }
            column(YearlyAverage; "Yearly Average")
            {
            }
            column(YearlyGrade; "Yearly Grade")
            {
            }
            column(YearlyPassed; "Yearly Passed Units")
            {
            }
            column(YearlyFailed; "Yearly Failed Units")
            {
            }
            column(YearlyTotalUnits; "Yearly Total Units Taken")
            {
            }
            column(YearlyRemarks; "Yearly Remarks")
            {
            }
            column(TotalSemMarks; "Total Semester Marks")
            {
            }
            column(YearlyWeightedTotal; "Yearly Weighted Total")
            {
            }
            column(YearlyCFFailed; "Yearly CF% Failed")
            {
            }
            column(YearlyCurrAverage; "Yearly Curr. Average")
            {
            }
            column(SemAverage; "Semester Average")
            {
            }
            column(SemGrade; "Semester Grade")
            {
            }
            column(SemFailed; "Semester Failed Units")
            {
            }
            column(SemTotalUnits; "Semester Total Units Taken")
            {
            }
            column(SemRemarks; "Semester Remarks")
            {
            }
            column(SemUnitsPassed; "Semester Total Units Taken" - "Semester Failed Units")
            {
            }
            column(SemCurrAverage; "Semester Curr. Average")
            {
            }
            column(SemCFFailed; "Semester CF% Failed")
            {
            }
            column(SemWeifgtedTotal; "Semester Weighted Total")
            {
            }
            column(CommAverage; "Cummulative Average")
            {
            }
            column(CummGrade; "Cummulative Grade")
            {
            }
            column(CumScore; "Cummulative Score")
            {
            }
            column(CumUnits; "Cummulative Units Taken")
            {
            }
            column(CumUnits2; "Cummulative Units")
            {
            }
            column(CummMarks; "Cummulative Marks")
            {
            }
            column(CoursesFailed; "Yearly Failed Courses")
            {
            }
            column(CummAward; Award)
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
            // column(signedSignature;dimVal.Signature)
            // {
            // }
            // column(TranscriptSignatory;dimVal."HOD Names")
            // {
            // }
            // column(TransCriptTitle;dimVal.Titles)
            // {
            // }
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
            dataitem(StudUnitsz; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Unit Year of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE(Taken = FILTER('Yes'),
                                          "Old Unit" = FILTER('No'));
                column(Unit; StudUnitsz.Unit)
                {
                }
                column(UnitDesc; units_Subjects.Desription)
                {
                }
                column(Score; StudUnitsz."Supp. Total Marks")
                {
                }
                column(Final; StudUnitsz."Supp. Final Score")
                {
                }
                column(Grade; StudUnitsz."Supp. Grade")
                {
                }
                column(Status; StudUnitsz."Supp. Cons. Mark Pref.")
                {
                }
                column(ScoreLabel; ScoreLabel)
                {
                }
                column(Units; StudUnitsz.Units)
                {
                }
                column(StageUnit; StudUnitsz.Stage)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    units_Subjects.RESET;
                    units_Subjects.SETRANGE(Code, StudUnitsz.Unit);
                    units_Subjects.SETRANGE("Programme Code", StudUnitsz.Programme);
                    IF units_Subjects.FIND('-') THEN;

                    CLEAR(ScoreLabel);
                    StudUnitsz.CALCFIELDS(StudUnitsz."CATs Marks Exists", StudUnitsz."EXAMs Marks Exists");
                    IF ((StudUnitsz."CATs Marks Exists" = FALSE) AND (StudUnitsz."EXAMs Marks Exists" = FALSE)) THEN BEGIN
                        ScoreLabel := 'X';
                    END ELSE BEGIN
                        ScoreLabel := FORMAT(StudUnitsz."Total Marks");
                        ScoreLabel := ScoreLabel + StudUnitsz."Consolidated Mark Pref.";

                    END;
                    //IF ("ACA-Student Units"."Total Marks"<>0)  THEN ScoreLabel:=FORMAT("ACA-Student Units"."Total Marks")
                    //ELSE
                    StudUnitsz.CALCFIELDS(StudUnitsz."Total Score");
                    IF ((ScoreLabel = 'EXPELLED') OR
                     (ScoreLabel = 'SUSPENDED') OR
                     (ScoreLabel = 'EXPULSION')) THEN
                        ScoreLabel := '-'
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /* CALCFIELDS("Program Option (Flow)");
                 IF "Program Option (Flow)"<>'' THEN BEGIN
                   ACAProgrammeOptions.RESET;
                   ACAProgrammeOptions.SETRANGE("Programme Code",Programme);
                   ACAProgrammeOptions.SETRANGE(Code,"Program Option (Flow)");
                   IF ACAProgrammeOptions.FIND('-') THEN BEGIN
                     END;
                   END;*/

                CLEAR(StudentNoAcademicYear);
                IF STRLEN("Student No.") > 2 THEN BEGIN
                    StudentNoAcademicYear := COPYSTR("Student No.", ((STRLEN("Student No.")) - 1), 2);
                END;

                CLEAR(YOSTewxt);
                IF "Year Of Study" = 1 THEN YOSTewxt := 'First Year';
                IF "Year Of Study" = 2 THEN YOSTewxt := 'Second Year';
                IF "Year Of Study" = 3 THEN YOSTewxt := 'Third Year';
                IF "Year Of Study" = 4 THEN YOSTewxt := 'Fourth Year';
                IF "Year Of Study" = 5 THEN YOSTewxt := 'Fifth Year';
                IF "Year Of Study" = 6 THEN YOSTewxt := 'Sixth Year';
                IF "Year Of Study" = 7 THEN YOSTewxt := 'Seventh Year';
                CLEAR(SchoolName);
                CLEAR(pName);
                prog.RESET;
                prog.SETRANGE(Code, Programmes);
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
                dimVal.SETRANGE(dimVal."Dimension Code", 'Department');
                dimVal.SETRANGE(dimVal.Code, prog."Department Code");
                IF dimVal.FIND('-') THEN BEGIN
                    DeptName := dimVal.Name;
                    //   dimVal.CALCFIELDS(Signature);
                END;

                CLEAR(YearOfStudy);

                YearOfStudy := COPYSTR(Stage, 2, 1);


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", "Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;
                END;
                /*
                MksCounts.RESET;
                IF MksCounts.FIND('+') THEN counts:=MksCounts.Serials+1
                ELSE counts:=1; */

                Sem.RESET;
                Sem.SETRANGE(Sem.Code, Semester);
                IF Sem.FIND('-') THEN
                    acadyear := Sem."Academic Year";

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, "Yearly Remarks");
                IF ACAResultsStatus.FIND('-') THEN;

                IF (("Yearly Remarks" = 'EXPELLED') OR
                 ("Yearly Remarks" = 'SUSPENDED') OR
                 ("Yearly Remarks" = 'EXPULSION')) THEN BEGIN
                    "Yearly Total Units Taken" := 0;
                    "Yearly Weighted Total" := 0;
                    "Yearly Passed Units" := 0;
                    "Yearly Failed Units" := 0;
                    "Yearly CF% Failed" := 0;
                    "Yearly Failed Courses" := 0;
                    "Yearly Curr. Average" := 0;
                END;

                CALCFIELDS("Program Option (Flow)");
                //--------------------------------------------------------------------------------------------------------------------------
                //////////////////////////////////////////////////////////////////////////////////////////////////////////

                MksCounts.RESET;
                MksCounts.SETRANGE(MksCounts."Student No.", "Student No.");
                MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT("Year Of Study"));
                MksCounts.SETRANGE(MksCounts.Programme, Programmes);
                MksCounts.SETRANGE(MksCounts.Option, "Program Option (Flow)");
                MksCounts.SETRANGE(MksCounts."Academic Year", "Academic Year");
                MksCounts.SETRANGE(MksCounts."User Id", USERID);
                IF NOT MksCounts.FIND('-') THEN BEGIN
                    CLEAR(counts);
                    MksCounts2.RESET;
                    MksCounts2.SETRANGE(MksCounts2."Year of Study", FORMAT("Year Of Study"));
                    MksCounts2.SETRANGE(MksCounts2.Programme, Programmes);
                    MksCounts2.SETRANGE(MksCounts2.Option, "Program Option (Flow)");
                    MksCounts2.SETRANGE(MksCounts2."Academic Year", "Academic Year");
                    MksCounts2.SETRANGE(MksCounts2."User Id", USERID);
                    IF MksCounts2.FIND('-') THEN counts := MksCounts2.COUNT;
                    counts := counts + 1;
                    MksCounts.INIT;
                    MksCounts."Student No." := "Student No.";
                    MksCounts."Year of Study" := FORMAT("Year Of Study");
                    MksCounts.Programme := Programmes;
                    MksCounts.Option := "Program Option (Flow)";
                    MksCounts."Academic Year" := "Academic Year";
                    MksCounts."User Id" := USERID;
                    MksCounts.Serial := counts;
                    MksCounts.INSERT;
                END;
                //////////////////////////////////////////////////////////////////////////////////////////////////////////
                MksCounts.RESET;
                MksCounts.SETRANGE(MksCounts."Student No.", "Student No.");
                MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT("Year Of Study"));
                MksCounts.SETRANGE(MksCounts.Programme, Programmes);
                MksCounts.SETRANGE(MksCounts.Option, "Program Option (Flow)");
                MksCounts.SETRANGE(MksCounts."Academic Year", "Academic Year");
                MksCounts.SETRANGE(MksCounts."User Id", USERID);
                IF MksCounts.FIND('-') THEN;
                //--------------------------------------------------------------------------------------------------------------------------

            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration".""Student No."","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;

            trigger OnPreDataItem()
            begin
                cc := 0;
                CLEAR(counts);
                //ACACourseRegistration.COPYFILTERS("ACA-Course Registration");
                ACACourseRegistration.SETRANGE(Reversed, FALSE);
                ACACourseRegistration.SETCURRENTKEY(ACACourseRegistration."Year of Admission", "Student No.");
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    MksCounts.RESET;
                    // MksCounts.SETRANGE(MksCounts.""Year of Study"",FORMAT(ACACourseRegistration.""Year Of Study""));
                    // MksCounts.SETRANGE(MksCounts.Programme,ACACourseRegistration.Programme);
                    // MksCounts.SETRANGE(MksCounts.Option,ACACourseRegistration.Options);
                    MksCounts.SETRANGE(MksCounts."User Id", USERID);
                    //MksCounts.SETRANGE(MksCounts."Academic Year",ACACourseRegistration."Academic Year");
                    IF MksCounts.FIND('-') THEN MksCounts.DELETEALL;
                    /*REPEAT
                      BEGIN

                     END;
                     UNTIL ACACourseRegistration.NEXT=0;*/
                END;
                /* ELSE BEGIN
                 counts:=MksCounts.Serials;
                 END;*/
                CLEAR(counts)
                //SETCURRENTKEY("Year of Admission","Student No.");
                //IF GETFILTER(Options)<>'' THEN SETFILTER("Program Option (Flow)",'%1',
                //GETFILTER(Options));

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
        ACAResultsStatus: Record 61739;
        ACACourseRegistration: Record 61532;
        StudentNoAcademicYear: Code[10];
        counts: Integer;
        MksCounts: Record 69264;
        MksCounts2: Record 69264;
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Code[50];
        SchoolName: Text[250];
        ExamProcess: Codeunit 60276;
        EResults: Record 61548;
        UnitsR: Record "ACA-Units/Subjects";
        "Units/Subj": Record "ACA-Units/Subjects";
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
        sName: Text[250];
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
        ScoreLabel: Text[20];
        YOSTewxt: Text[20];
        cc: Integer;
        ACAProgrammeOptions: Record 61554;
}

