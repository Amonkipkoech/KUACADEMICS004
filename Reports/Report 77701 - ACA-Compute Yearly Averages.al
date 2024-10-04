report 77701 "ACA-Compute Yearly Averages"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(CoursesRegz; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false));

            trigger OnAfterGetRecord()
            var
                SuppExists: Boolean;
                ACAUnitsSubjects: Record 61517;
                ACAProgrammez: Record 61511;
                examCat: Code[20];
                ACAExamGraddingSetup: Record 61599;
            begin
                // CoursesRegz."Yearly Remarks":='';
                ACAProgrammez.RESET;
                ACAProgrammez.SETRANGE(Code, CoursesRegz.Programmes);
                IF ACAProgrammez.FIND('-') THEN;

                ACAStudentUnitsz.RESET;
                ACAStudentUnitsz.SETRANGE(Reversed, FALSE);
                ACAStudentUnitsz.SETRANGE("Student No.", CoursesRegz."Student No.");
                ACAStudentUnitsz.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACAUnitsSubjects.RESET;
                        ACAUnitsSubjects.SETRANGE("Programme Code", CoursesRegz.Programmes);
                        ACAUnitsSubjects.SETRANGE(Code, ACAStudentUnitsz.Unit);
                        IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                            IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                                examCat := ACAUnitsSubjects."Default Exam Category"
                            ELSE
                                examCat := ACAProgrammez."Exam Category";
                            ACAExamGraddingSetup.RESET;
                            ACAExamGraddingSetup.SETRANGE(Category, examCat);
                            ACAExamGraddingSetup.SETRANGE(Grade, ACAStudentUnitsz.Grade);
                            IF ACAExamGraddingSetup.FIND('-') THEN;
                            ACAStudentUnitsz.Failed := ACAExamGraddingSetup.Failed;
                        END;
                        ACAStudentUnitsz.MODIFY;
                    END;
                    UNTIL ACAStudentUnitsz.NEXT = 0;
                END;
                progress.UPDATE(1, CoursesRegz."Student No.");
                progress.UPDATE(2, CoursesRegz.Programmes);
                progress.UPDATE(3, CoursesRegz.Semester);
                progress.UPDATE(4, CoursesRegz.Stage);
                CLEAR(YearlyReMarks);
                CLEAR(TotalYearlyMarks);
                CLEAR(HighestYearlyRepeats);
                CLEAR(YearlyAverage);
                CLEAR(YearlyGrade);
                CLEAR(YearlyFailedUnits);
                CLEAR(YearlyTotalUnits);
                CLEAR(SemesterReMarks);
                CLEAR(TotalSemesterMarks);
                CLEAR(SemesterAverage);
                CLEAR(SemesterGrade);
                CLEAR(SemesterFailedUnits);
                CLEAR(SemesterTotalUnits);
                CLEAR(CummulativeReMarks);
                CLEAR(TotalCummulativeMarks);
                CLEAR(CummulativeAverage);
                CLEAR(CummulativeGrade);
                CLEAR(CummulativeFailedUnits);
                CLEAR(CummulativeTotalUnits);
                CLEAR(FailedUnits);
                CLEAR(StatusRemarks);

                CoursesRegz.CALCFIELDS(CoursesRegz."Total Yearly Marks",
                CoursesRegz."Yearly Failed Units", CoursesRegz."Yearly Total Units Taken",
                CoursesRegz."Total Semester Marks",
                CoursesRegz."Semester Failed Units", CoursesRegz."Semester Total Units Taken",
                CoursesRegz."Cummulative Marks", CoursesRegz."Cummulative Units", CoursesRegz."Yearly Weighted Total",
                CoursesRegz."Semester Weighted Total", CoursesRegz."Special Exam Exists", CoursesRegz."Highest Yearly Repeats",
                CoursesRegz."Number of Acedemic Year Repeat");

                //Year Computations
                CoursesRegz.CALCFIELDS(CoursesRegz."Yearly Failed Cores", CoursesRegz."Yearly Total Cores");
                // // // YearlyFailedUnits:=CoursesRegz."Yearly Failed Units";
                // // // YearlyTotalUnits:=CoursesRegz."Yearly Total Units Taken";
                YearlyFailedUnits := CoursesRegz."Yearly Failed Units";
                YearlyTotalUnits := CoursesRegz."Yearly Total Units Taken";
                CLEAR(YearlyCfFail);
                CLEAR(SemesterCfFail);
                CLEAR(CummCFFauil);
                IF YearlyTotalUnits <> 0 THEN BEGIN
                    YearlyCfFail := (YearlyFailedUnits / YearlyTotalUnits) * 100;
                    //YearlyFailedUnits:=(YearlyFailedUnits/YearlyTotalUnits)*100;
                END;// ELSE YearlyFailedUnits:=0;
                //YearlyCfFail:=ROUND(YearlyCfFail,0.01,'=');



                CoursesRegz."Yearly CF% Failed" := YearlyCfFail;
                IF YearlyTotalUnits <> 0 THEN
                    IF CoursesRegz."Yearly Total Units Taken" <> 0 THEN
                        CoursesRegz."Yearly Curr. Average" := (CoursesRegz."Yearly Weighted Total" / CoursesRegz."Yearly Total Units Taken");
                IF YearlyTotalUnits = 0 THEN CurrReport.SKIP;
                TotalYearlyMarks := CoursesRegz."Yearly Weighted Total";

                IF ((TotalYearlyMarks > 0) AND (YearlyTotalUnits > 0)) THEN BEGIN
                    YearlyAverage := ROUND(TotalYearlyMarks / YearlyTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CoursesRegz.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    CoursesRegz."Special Programme Class" := ACAProgramme."Special Programme Class";
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', YearlyAverage, YearlyAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', YearlyAverage, YearlyAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        YearlyGrade := ACAGradingSystemSetup.Grade;
                    END;
                END;
                IF YearlyGrade = '' THEN YearlyReMarks := 'No marks captured';
                CLEAR(LubricIdentified);
                CLEAR(YearlyReMarks);
                IF CoursesRegz."Student No." = 'MN/00029/018' THEN
                    Customer.RESET;
                Customer.RESET;
                Customer.SETRANGE("No.", CoursesRegz."Student No.");
                IF Customer.FIND('-') THEN BEGIN
                    IF ((Customer.Status = Customer.Status::Registration) OR (Customer.Status = Customer.Status::Current)) THEN BEGIN
                        CLEAR(LubricIdentified);
                        CoursesRegz.CALCFIELDS("Yearly Failed Cores", "Yearly Failed Electives", "Yearly Total Cores", "Yearly Total Electives",
                        "Yearly Failed Units", "Yearly Total Units Taken", "Resits Registered and Failed", CoursesRegz."Highest Yearly Repeats");
                        IF CoursesRegz."Yearly Total Cores" > 0 THEN
                            CoursesRegz."Yearly Failed Cores %" := (CoursesRegz."Yearly Failed Cores" / CoursesRegz."Yearly Total Cores") * 100;
                        IF CoursesRegz."Yearly Total Electives" > 0 THEN
                            CoursesRegz."Yearly Failed Electives %" := (CoursesRegz."Yearly Failed Electives" / CoursesRegz."Yearly Total Electives") * 100;
                        IF ((CoursesRegz."Yearly Total Electives" + CoursesRegz."Yearly Total Cores") > 0) THEN
                            CoursesRegz."Yearly Failed Units %" := ((CoursesRegz."Yearly Failed Electives" + CoursesRegz."Yearly Failed Cores") /
                          (CoursesRegz."Yearly Total Electives" + CoursesRegz."Yearly Total Cores")) * 100;

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETFILTER("Manual Status Processing", '%1', FALSE);
                        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                        // ACAResultsStatus.SETFILTER("Min. Unit Repeat Counts",'=%1|<%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                        // ACAResultsStatus.SETFILTER("Max. Unit Repeat Counts",'=%1|>%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                        ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', YearlyFailedUnits, YearlyFailedUnits);
                        ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', YearlyFailedUnits, YearlyFailedUnits);
                        // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                        // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                        IF ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                            ACAResultsStatus.SETFILTER("Minimum Core Fails", '=%1|<%2', CoursesRegz."Yearly Failed Cores %", CoursesRegz."Yearly Failed Cores %");
                            ACAResultsStatus.SETFILTER("Maximum Core Fails", '=%1|>%2', CoursesRegz."Yearly Failed Cores %", CoursesRegz."Yearly Failed Cores %");
                            ACAResultsStatus.SETFILTER("Minimum None-Core Fails", '=%1|<%2', CoursesRegz."Yearly Failed Electives %", CoursesRegz."Yearly Failed Electives %");
                            ACAResultsStatus.SETFILTER("Maximum None-Core Fails", '=%1|>%2', CoursesRegz."Yearly Failed Electives %", CoursesRegz."Yearly Failed Electives %");
                        END ELSE BEGIN
                            ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', YearlyFailedUnits, YearlyFailedUnits);
                            ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', YearlyFailedUnits, YearlyFailedUnits);
                        END;
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                StatusRemarks := ACAResultsStatus.Code;
                                IF ACAResultsStatus."Lead Status" <> '' THEN
                                    StatusRemarks := ACAResultsStatus."Lead Status";
                                YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                                LubricIdentified := TRUE;
                            END;
                            UNTIL ((ACAResultsStatus.NEXT = 0) OR (LubricIdentified = TRUE))
                        END;
                    END ELSE BEGIN

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETRANGE(Status, Customer.Status);
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            IF ((Customer.Status <> Customer.Status::Current) AND (Customer.Status <> Customer.Status::Registration)) THEN
                                StatusRemarks := ACAResultsStatus.Code;
                            YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        END;
                    END;
                END;
                CoursesRegz."Transcript Remarks" := YearlyReMarks;
                CoursesRegz."Yearly Average" := YearlyAverage;
                CoursesRegz."Yearly Grade" := YearlyGrade;
                CoursesRegz."Yearly Remarks" := StatusRemarks;
                CoursesRegz."Exam Status" := StatusRemarks;

                //Semester Computations
                SemesterFailedUnits := CoursesRegz."Semester Failed Units";
                SemesterTotalUnits := CoursesRegz."Semester Total Units Taken";
                TotalSemesterMarks := CoursesRegz."Total Semester Marks";
                IF SemesterTotalUnits <> 0 THEN
                    SemesterCfFail := (SemesterFailedUnits / SemesterTotalUnits) * 100;
                CoursesRegz."Semester CF% Failed" := SemesterCfFail;
                IF SemesterTotalUnits <> 0 THEN
                    CoursesRegz."Semester Curr. Average" := (CoursesRegz."Semester Weighted Total" / SemesterTotalUnits);
                IF ((TotalSemesterMarks > 0) AND (SemesterTotalUnits > 0)) THEN BEGIN
                    SemesterAverage := ROUND(TotalSemesterMarks / SemesterTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CoursesRegz.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', SemesterAverage, SemesterAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', SemesterAverage, SemesterAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        SemesterGrade := ACAGradingSystemSetup.Grade;
                    END;
                END;
                IF SemesterGrade = '' THEN SemesterReMarks := 'No marks captured';
                IF ((SemesterFailedUnits > 0) AND (SemesterFailedUnits < 5)) THEN SemesterReMarks := 'TO  PROCEED  TO NEXT YEAR OF STUDY  BUT RESIT COURSE(S) FAILED WHEN NEXT OFFERED';
                IF ((SemesterFailedUnits > 0) AND (SemesterFailedUnits > 5)) THEN SemesterReMarks := 'REPEAT ' + FORMAT(CoursesRegz."Year Of Study");
                IF (SemesterFailedUnits = 0) THEN SemesterReMarks := 'TO  PROCEED TO NEXT YEAR OF STUDY';
                IF SemesterGrade = 'E' THEN
                    SemesterReMarks := 'FAIL'
                ELSE
                    SemesterReMarks := 'PASS';

                CoursesRegz."Semester Average" := SemesterAverage;
                CoursesRegz."Semester Grade" := SemesterGrade;
                CoursesRegz."Semester Remarks" := StatusRemarks;


                //Cummulative Computations
                CummulativeTotalUnits := CoursesRegz."Cummulative Units";
                TotalCummulativeMarks := CoursesRegz."Cummulative Marks";

                IF ((TotalCummulativeMarks > 0) AND (CummulativeTotalUnits > 0)) THEN BEGIN
                    CummulativeAverage := ROUND(TotalCummulativeMarks / CummulativeTotalUnits, 0.01, '=');
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, CoursesRegz.Programmes);
                IF ACAProgramme.FIND('-') THEN BEGIN
                    ACAGradingSystemSetup.RESET;
                    IF ACAProgramme."Exam Category" = '' THEN
                        ACAGradingSystemSetup.SETRANGE(Category, 'DEFAULT')
                    ELSE
                        ACAGradingSystemSetup.SETRANGE(Category, ACAProgramme."Exam Category");
                    ACAGradingSystemSetup.SETFILTER("Lower Limit", '=%1|<%2', CummulativeAverage, CummulativeAverage);
                    ACAGradingSystemSetup.SETFILTER("Upper Limit", '=%1|>%2', CummulativeAverage, CummulativeAverage);
                    IF ACAGradingSystemSetup.FIND('-') THEN BEGIN
                        CummulativeGrade := ACAGradingSystemSetup.Grade;
                        CummulativeReMarks := ACAGradingSystemSetup.Award;
                    END;
                END;

                CLEAR(incompleteExists);
                CLEAR(SuppExists);

                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.", CoursesRegz."Student No.");
                ACAStudentUnits2.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                ACAStudentUnits2.SETRANGE(Reversed, FALSE);
                ACAStudentUnits2.SETFILTER("Consolidated Mark Pref.", '%1', '^');
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                    SuppExists := TRUE;
                END;

                //IF NOT CoursesRegz.Reversed THEN BEGIN
                ACAStudentUnitsz.RESET;
                ACAStudentUnitsz.SETRANGE(Reversed, FALSE);
                ACAStudentUnitsz.SETRANGE("Student No.", CoursesRegz."Student No.");
                //ACAStudentUnitsz.SETRANGE(Programme,CoursesRegz.Programme);
                ACAStudentUnitsz.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                //ACAStudentUnitsz.SETRANGE("Academic Year",CoursesRegz."Academic Year");
                ACAStudentUnitsz.SETFILTER("Consolidated Mark Pref.", '%1', 'x');
                IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                    CoursesRegz."Yearly Remarks" := 'MISSED';
                END;

                ACAStudentUnitsz.RESET;
                ACAStudentUnitsz.SETRANGE(Reversed, FALSE);
                ACAStudentUnitsz.SETRANGE("Student No.", CoursesRegz."Student No.");
                ACAStudentUnitsz.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                ACAStudentUnitsz.SETFILTER("Consolidated Mark Pref.", '%1', 'x');
                IF NOT ACAStudentUnitsz.FIND('-') THEN BEGIN
                    ACAStudentUnitsz.RESET;
                    ACAStudentUnitsz.SETRANGE(Reversed, FALSE);
                    ACAStudentUnitsz.SETRANGE("Student No.", CoursesRegz."Student No.");
                    ACAStudentUnitsz.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                    ACAStudentUnitsz.SETFILTER("Consolidated Mark Pref.", '%1', 'c');
                    ACAStudentUnitsz.SETFILTER("Special Exam", '<>%1', ACAStudentUnitsz."Special Exam"::" ");
                    IF ACAStudentUnitsz.FIND('-') THEN BEGIN
                        IF ACAStudentUnitsz."Special Exam" = ACAStudentUnitsz."Special Exam"::Special THEN
                            CoursesRegz."Yearly Remarks" := 'SPECIAL';
                        IF ACAStudentUnitsz."Special Exam" = ACAStudentUnitsz."Special Exam"::Suspension THEN
                            CoursesRegz."Yearly Remarks" := 'SUSPENDED';
                    END;
                END;

                Customer2.RESET;
                Customer2.SETRANGE("No.", CoursesRegz."Student No.");
                IF Customer2.FIND('-') THEN BEGIN
                    IF NOT ((Customer2.Status = Customer2.Status::Registration)) THEN
                        IF NOT ((Customer2.Status = Customer2.Status::Current)) THEN BEGIN
                            // IF ((Customer2.Status<>Customer2.Status::Current) AND  (Customer2.Status<>Customer2.Status::Registration)) THEN
                            CoursesRegz."Yearly Remarks" := FORMAT(Customer2.Status);
                        END;
                END;

                CoursesRegz."Cummulative Average" := CummulativeAverage;
                CoursesRegz."Cummulative Grade" := CummulativeGrade;
                CoursesRegz.Award := CummulativeReMarks;


                ACAStudentUnits2.RESET;
                ACAStudentUnits2.SETRANGE("Student No.", CoursesRegz."Student No.");
                ACAStudentUnits2.SETRANGE(Reversed, FALSE);
                ACAStudentUnits2.SETRANGE("Unit Year of Study", CoursesRegz."Year Of Study");
                ACAStudentUnits2.SETRANGE("CATs Marks Exists", FALSE);
                ACAStudentUnits2.SETRANGE("EXAMs Marks Exists", FALSE);
                IF ACAStudentUnits2.FIND('-') THEN BEGIN
                END;
                CoursesRegz.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                //"ACA-Exam Results".SETRANGE("ACA-Exam Results"."User Name",UserID);

                //Reset Exam Status
                ACACourseRegistration.RESET;
                ACACourseRegistration.COPYFILTERS(CoursesRegz);
                //IF (CoursesRegz.GETFILTER(CoursesRegz."Academic Year"))<>'' THEN
                //  ACACourseRegistration.SETRANGE("Academic Year",(CoursesRegz.GETFILTER(CoursesRegz."Academic Year")));
                IF ACACourseRegistration.FIND('-') THEN
                    REPEAT
                        ACACourseRegistration."Exam Status" := '';
                        ACACourseRegistration."Yearly Remarks" := '';
                        ACACourseRegistration.MODIFY;
                    UNTIL ACACourseRegistration.NEXT = 0;
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

    trigger OnPostReport()
    begin
        progress.CLOSE;
    end;

    trigger OnPreReport()
    begin
        progress.OPEN('Processing 4 of 7.\Computing Yearly Averages......\No.: #1########################################' +
        '\Prog.: #2########################################\Sem.: #3########################################\Stage: #4########################################');
    end;

    var
        incompleteExists: Boolean;
        ACAStudentUnitsz: Record 61549;
        progress: Dialog;
        ACAStudentUnits: Record 61549;
        TotalYearlyMarks: Decimal;
        YearlyAverage: Decimal;
        YearlyGrade: Code[2];
        YearlyFailedUnits: Integer;
        YearlyTotalUnits: Integer;
        YearlyFailedCoreUnits: Integer;
        YearlyTotalCoreUnits: Integer;
        YearlyFailedElectiveUnits: Integer;
        YearlyTotalElectiveUnits: Integer;
        YearlyReMarks: Code[250];
        ACAGradingSystemSetup: Record 61599;
        ACAProgramme: Record 61511;
        TotalSemesterMarks: Decimal;
        SemesterFailedUnits: Integer;
        SemesterTotalUnits: Integer;
        SemesterAverage: Decimal;
        SemesterGrade: Code[2];
        SemesterReMarks: Code[250];
        TotalCummulativeMarks: Decimal;
        CummulativeFailedUnits: Integer;
        CummulativeTotalUnits: Integer;
        CummulativeAverage: Decimal;
        CummulativeGrade: Code[2];
        CummulativeReMarks: Code[250];
        FailedUnits: Text[250];
        StatusRemarks: Text[20];
        ACAStudentUnits2: Record 61549;
        ACAResultsStatus: Record 61739;
        Customer: Record 18;
        LubricIdentified: Boolean;
        ACACourseRegistration: Record 61532;
        YearlyCfFail: Decimal;
        SemesterCfFail: Decimal;
        CummCFFauil: Decimal;
        Customer2: Record 18;
        HighestYearlyRepeats: Integer;
}

