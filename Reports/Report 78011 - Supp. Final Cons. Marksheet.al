report 78011 "Supp. Final Cons. Marksheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Supp. Final Cons. Marksheet.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61532)
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE(Reversed = filter('No'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Year Of Study", "Academic Year", "Student No.", Programmes, Stage, Semester, Session, Options;
            column(GroupingConcortion; Reg."Academic Year" + Reg.Programmes + DeptName + SchoolName + Reg.Options + FORMAT(Reg."Year Of Study"))
            {
            }
            column(StudNo; Reg."Student No.")
            {
            }
            column(StudentNoAcademicYear; StudentNoAcademicYear)
            {
            }
            column(CountedDistinct; Reg."Student No." + Reg."Supp. Yearly Remarks")
            {
            }
            column(Prog; Reg.Programmes)
            {
            }
            column(Sem; Reg.Semester)
            {
            }
            column(Stag; Reg.Stage)
            {
            }
            column(CumSc; Reg."Cumm Score")
            {
            }
            column(CurrSem; Reg."Current Cumm Score")
            {
            }
            column(Option; ACAProgrammeOptions.Desription)
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(InfoName; CompanyInformation.Name)
            {
            }
            column(InfoPic; CompanyInformation."Phone No.")
            {
            }
            column(InfoAddress; CompanyInformation.Address)
            {
            }
            column(YoS; Reg."Year Of Study")
            {
            }
            column(TotalYearlyMarks; Reg."Supp. Total Yearly Marks")
            {
            }
            column(YearlyAverage; Reg."Supp. Yearly Average")
            {
            }
            column(YearlyGrade; Reg."Supp. Yearly Grade")
            {
            }
            column(YearlyPassed; Reg."Supp. Yearly Passed Units")
            {
            }
            column(YearlyFailed; Reg."Supp. Yearly Failed Units")
            {
            }
            column(YearlyTotalUnits; Reg."Supp. Yearly Total Units Taken")
            {
            }
            column(YearlyRemarks; Reg."Supp. Yearly Remarks")
            {
            }
            column(TotalSemMarks; Reg."Supp. Total Semester Marks")
            {
            }
            column(YearlyWeightedTotal; Reg."Supp. Yearly Weighted Total")
            {
            }
            column(YearlyCFFailed; Reg."Supp. Yearly CF% Failed")
            {
            }
            column(YearlyCurrAverage; Reg."Supp. Yearly Curr. Average")
            {
            }
            column(SemAverage; Reg."Semester Average")
            {
            }
            column(SemGrade; Reg."Semester Grade")
            {
            }
            column(SemFailed; Reg."Semester Failed Units")
            {
            }
            column(SemTotalUnits; Reg."Semester Total Units Taken")
            {
            }
            column(SemRemarks; Reg."Semester Remarks")
            {
            }
            column(SemUnitsPassed; Reg."Semester Total Units Taken" - Reg."Semester Failed Units")
            {
            }
            column(SemCurrAverage; Reg."Semester Curr. Average")
            {
            }
            column(SemCFFailed; Reg."Semester CF% Failed")
            {
            }
            column(SemWeifgtedTotal; Reg."Semester Weighted Total")
            {
            }
            column(CommAverage; Reg."Supp. Cummulative Average")
            {
            }
            column(CummGrade; Reg."Supp. Cummulative Grade")
            {
            }
            column(CumScore; Reg."Supp. Cummulative Marks")
            {
            }
            column(CumUnits; Reg."Supp. Yearly Total Units Taken")
            {
            }
            column(CumUnits2; Reg."Supp. Cummulative Units")
            {
            }
            column(CummMarks; Reg."Supp. Cummulative Marks")
            {
            }
            column(CoursesFailed; Reg."Supp. Yearly Failed Courses")
            {
            }
            column(CummAward; Reg.Award)
            {
            }
            column(cc; cc)
            {
            }
            column(YOSText; YOSTewxt)
            {
            }
            column(sName; FormatNames(sName))
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
            column(GenCourseSuppExists; GenCourseSuppExists)
            {
            }
            dataitem(DataItem1000000005; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Year Of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE(Taken = FILTER('Yes'),
                                          "Old Unit" = FILTER('No'));
                column(Unit; unitss.Unit)
                {
                }
                column(UnitDesc; unitss."Unit Description")
                {
                }
                column(Score; unitss."Supp. Total Marks")
                {
                }
                column(Final; unitss."Supp. Total Marks")
                {
                }
                column(Grade; unitss."Supp. Grade")
                {
                }
                column(Status; unitss."Exam Status")
                {
                }
                column(ScoreLabel; ScoreLabel)
                {
                }
                column(Units; unitss.Units)
                {
                }
                column(StageUnit; unitss.Stage)
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
                    MksCounts.SETRANGE(MksCounts."Student No.", unitss."Student No.");
                    MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT(Reg."Year Of Study"));
                    MksCounts.SETRANGE(MksCounts.Programme, unitss.Programme);
                    MksCounts.SETRANGE(MksCounts.Option, Reg.Options);
                    MksCounts.SETRANGE(MksCounts."Academic Year", Reg."Academic Year");
                    IF NOT MksCounts.FIND('-') THEN BEGIN
                        //REPEAT
                        counts := counts + 1;
                        MksCounts.INIT;
                        MksCounts."Student No." := Reg."Student No.";
                        MksCounts."Year of Study" := FORMAT(Reg."Year Of Study");
                        MksCounts.Programme := Reg.Programmes;
                        MksCounts.Option := Reg.Options;
                        MksCounts."Academic Year" := Reg."Academic Year";
                        MksCounts.Serial := counts;
                        MksCounts."User Id" := USERID;
                        IF NOT MksCounts.INSERT THEN;
                        //UNTIL MksCounts.NEXT=0;
                    END;
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////
                    MksCounts.RESET;
                    MksCounts.SETRANGE(MksCounts."Student No.", Reg."Student No.");
                    MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT(Reg."Year Of Study"));
                    MksCounts.SETRANGE(MksCounts.Programme, Reg.Programmes);
                    MksCounts.SETRANGE(MksCounts.Option, Reg.Options);
                    MksCounts.SETRANGE(MksCounts."Academic Year", Reg."Academic Year");
                    IF MksCounts.FIND('-') THEN;// counts:=counts+1;
                    //--------------------------------------------------------------------------------------------------------------------------
                    CLEAR(ScoreLabel);
                    unitss.CALCFIELDS(unitss."CATs Marks Exists", unitss."EXAMs Marks Exists");
                    IF ((unitss."CATs Marks Exists" = FALSE) AND (unitss."EXAMs Marks Exists" = FALSE)) THEN BEGIN
                        ScoreLabel := 'X';
                    END ELSE BEGIN
                        ScoreLabel := FORMAT(unitss."Supp. Total Marks");
                        ScoreLabel := ScoreLabel + unitss."Supp. Cons. Mark Pref.";

                    END;
                    //IF (unitss."Total Marks"<>0)  THEN ScoreLabel:=FORMAT(unitss."Total Marks")
                    //ELSE
                    // unitss.CALCFIELDS(unitss."Supp. Total Score");
                    IF ((Reg."Supp. Yearly Remarks" = 'EXPELLED') OR
                     (Reg."Supp. Yearly Remarks" = 'SUSPENDED') OR
                     (Reg."Supp. Yearly Remarks" = 'EXPULSION')) THEN
                        ScoreLabel := '-';
                    CLEAR(SuppExists);
                    unitss.CALCFIELDS(unitss."No of Supplementaries");
                    IF unitss."No of Supplementaries" > 0 THEN SuppExists := TRUE;
                    IF unitss."Special Exam" = unitss."Special Exam"::Special THEN SuppExists := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF Reg.Options <> '' THEN BEGIN
                    ACAProgrammeOptions.RESET;
                    ACAProgrammeOptions.SETRANGE("Programme Code", Reg.Programmes);
                    ACAProgrammeOptions.SETRANGE(Code, Reg.Options);
                    IF ACAProgrammeOptions.FIND('-') THEN BEGIN
                    END;
                END;

                CLEAR(StudentNoAcademicYear);
                IF STRLEN(Reg."Student No.") > 2 THEN BEGIN
                    StudentNoAcademicYear := COPYSTR(Reg."Student No.", ((STRLEN(Reg."Student No.")) - 1), 2);
                END;

                CLEAR(YOSTewxt);
                IF Reg."Year Of Study" = 1 THEN YOSTewxt := 'First Year';
                IF Reg."Year Of Study" = 2 THEN YOSTewxt := 'Second Year';
                IF Reg."Year Of Study" = 3 THEN YOSTewxt := 'Third Year';
                IF Reg."Year Of Study" = 4 THEN YOSTewxt := 'Fourth Year';
                IF Reg."Year Of Study" = 5 THEN YOSTewxt := 'Fifth Year';
                IF Reg."Year Of Study" = 6 THEN YOSTewxt := 'Sixth Year';
                IF Reg."Year Of Study" = 7 THEN YOSTewxt := 'Seventh Year';
                CLEAR(SchoolName);
                CLEAR(pName);
                prog.RESET;
                prog.SETRANGE(Code, Reg.Programmes);
                IF prog.FIND('-') THEN BEGIN
                    pName := prog.Description;
                    dimVal.RESET;
                    dimVal.SETRANGE(dimVal."Dimension Code", 'SCHOOL');
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

                YearOfStudy := COPYSTR(Reg.Stage, 2, 1);


                CLEAR(sName);
                CLEAR(YearOfAdmi);
                cust.RESET;
                cust.SETRANGE(cust."No.", Reg."Student No.");
                IF cust.FIND('-') THEN BEGIN
                    sName := cust.Name;
                END;
                /*
                MksCounts.RESET;
                IF MksCounts.FIND('+') THEN counts:=MksCounts.Serials+1
                ELSE counts:=1; */

                Sem.RESET;
                Sem.SETRANGE(Sem.Code, Reg.Semester);
                IF Sem.FIND('-') THEN
                    acadyear := Sem."Academic Year";

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, Reg."Supp. Yearly Remarks");
                IF ACAResultsStatus.FIND('-') THEN;

                IF ((Reg."Yearly Remarks" = 'EXPELLED') OR
                 (Reg."Yearly Remarks" = 'SUSPENDED') OR
                 (Reg."Yearly Remarks" = 'EXPULSION')) THEN BEGIN
                    Reg."Supp. Yearly Total Units Taken" := 0;
                    Reg."Supp. Yearly Weighted Total" := 0;
                    Reg."Supp. Yearly Passed Units" := 0;
                    Reg."Supp. Yearly Failed Units" := 0;
                    Reg."Supp. Yearly CF% Failed" := 0;
                    Reg."Supp. Yearly Failed Courses" := 0;
                    Reg."Supp. Yearly Curr. Average" := 0;
                END;

                CLEAR(GenCourseSuppExists);
                Reg.CALCFIELDS(Reg."Supplementary Exists", Reg."Special Exam Exists");
                IF (Reg."Supplementary Exists") THEN GenCourseSuppExists := TRUE;

            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;

            trigger OnPreDataItem()
            begin
                cc := 0;
                CLEAR(counts);
                ACACourseRegistration.COPYFILTERS(Reg);
                ACACourseRegistration.SETRANGE(Reversed, FALSE);
                ACACourseRegistration.SETCURRENTKEY(ACACourseRegistration."Year of Admission", ACACourseRegistration."Student No.");
                IF ACACourseRegistration.FIND('-') THEN BEGIN
                    MksCounts.RESET;
                    MksCounts.SETRANGE(MksCounts."Year of Study", FORMAT(ACACourseRegistration."Year Of Study"));
                    MksCounts.SETRANGE(MksCounts.Programme, ACACourseRegistration.Programmes);
                    MksCounts.SETRANGE(MksCounts.Option, ACACourseRegistration.Options);
                    MksCounts.SETRANGE(MksCounts."Academic Year", ACACourseRegistration."Academic Year");
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
                Reg.SETCURRENTKEY(Reg."Year of Admission", Reg."Student No.");

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
        MksCounts.RESET;
        MksCounts.SETRANGE(MksCounts."User Id", USERID);
        IF MksCounts.FIND('-') THEN MksCounts.DELETEALL;
    end;

    var
        unitss: record "ACA-Student Units";
        Reg: Record "ACA-Course Registration";
        ACAResultsStatus: Record 61739;
        ACACourseRegistration: Record 61532;
        StudentNoAcademicYear: Code[10];
        counts: Integer;
        MksCounts: Record 69264 temporary;
        pName: Text[250];
        units_Subjects: Record 61517;
        YearOfStudy: Code[10];
        YearOfAdmi: Code[50];
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
        FacDesc: Code[20];
        SuppExists: Boolean;
        GenCourseSuppExists: Boolean;

    local procedure FormatNames(CommonName: Text[250]) NewName: Text[250]
    var
        NamesSmall: Text[250];
        FirsName: Text[250];
        SpaceCount: Integer;
        SpaceFound: Boolean;
        Counts: Integer;
        Strlegnth: Integer;
        OtherNames: Text[250];
    begin
        CLEAR(NamesSmall);
        CLEAR(FirsName);
        CLEAR(SpaceCount);
        CLEAR(SpaceFound);
        CLEAR(OtherNames);
        IF STRLEN(CommonName) > 100 THEN CommonName := COPYSTR(CommonName, 1, 100);
        Strlegnth := STRLEN(CommonName);
        IF STRLEN(CommonName) > 4 THEN BEGIN
            NamesSmall := LOWERCASE(CommonName);
            REPEAT
            BEGIN
                SpaceCount += 1;
                IF ((COPYSTR(NamesSmall, SpaceCount, 1) = '') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ' ') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ',')) THEN SpaceFound := TRUE;
                IF NOT SpaceFound THEN BEGIN
                    FirsName := FirsName + UPPERCASE(COPYSTR(NamesSmall, SpaceCount, 1));
                END ELSE BEGIN
                    IF STRLEN(OtherNames) < 150 THEN BEGIN
                        IF ((COPYSTR(NamesSmall, SpaceCount, 1) = '') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ' ') OR (COPYSTR(NamesSmall, SpaceCount, 1) = ',')) THEN BEGIN
                            OtherNames := OtherNames + ' ';
                            SpaceCount += 1;
                            OtherNames := OtherNames + UPPERCASE(COPYSTR(NamesSmall, SpaceCount, 1));
                        END ELSE BEGIN
                            OtherNames := OtherNames + COPYSTR(NamesSmall, SpaceCount, 1);
                        END;

                    END;
                END;
            END;
            UNTIL ((SpaceCount = Strlegnth))
        END;
        CLEAR(NewName);
        NewName := FirsName + ',' + OtherNames;
    end;
}

