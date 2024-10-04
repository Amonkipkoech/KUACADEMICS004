report 74575 "Results Category Summary33"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Results Category Summary33.rdl';

    dataset
    {
        dataitem("ACA-Results Status"; 61739)
        {
            column(StatusCode; resstus.Code)
            {
            }
            column(StausDesc; resstus.Description)
            {
            }
            column(SummaryPageCaption; resstus."Summary Page Caption")
            {
            }
            column(StdCounts; resstus."Students Count")
            {
            }
            dataitem(DataItem2901; 61532)
            {
                DataItemLink = "Academic Year" = FIELD("Academic Year"),
                               "Exam Status" = FIELD(Code);
                DataItemTableView = SORTING("Year of Admission", "Student No.")
                                    ORDER(Ascending)
                                    WHERE("Yearly Total Units Taken" = FILTER(> 0),
                                          "Yearly Remarks" = FILTER(<> ''),
                                          Reversed = FILTER('No'));
                RequestFilterFields = Faculty, "Academic Year", Programmes, "Year Of Study";
                column(RegNo; RegNo)
                {
                }
                column(Names; Names)
                {
                }
                column(Compname; UPPERCASE(CompInf.Name))
                {
                }
                column(Pics; CompInf.Picture)
                {
                }
                column(StatusDesc; ResultsStatus.Description)
                {
                }
                column(StatusOrder; ACAResultsStatus."Order No")
                {
                }
                column(StatCodes; ACAResultsStatus.Code)
                {
                }
                column(ApprovalsClaimer; 'Approved by the board of the Examiners of the  ' + FacDesc + ' at a meeting held on:')
                {
                }
                column(RegTrans; coursereg."Reg. Transacton ID")
                {
                }
                column(StudNo; coursereg."Student No.")
                {
                }
                column(Progs; coursereg.Programmes)
                {
                }
                column(ProgName; progName)
                {
                }
                column(Sems; coursereg.Semester)
                {
                }
                column(RegFor; coursereg."Register for")
                {
                }
                column(CourseStage; coursereg.Stage)
                {
                }
                column(Units; coursereg.Unit)
                {
                }
                column(StudType; coursereg."Student Type")
                {
                }
                column(EntryNo; coursereg."Entry No.")
                {
                }
                column(CampusCode; coursereg."Campus Code")
                {
                }
                column(ExamStatus; coursereg."Exam Status")
                {
                }
                column(FailedUnits; coursereg."Failed Unit")
                {
                }
                column(facCode; facCode)
                {
                }
                column(FacDesc; FacDesc)
                {
                }
                column(YoS; coursereg."Year Of Study")
                {
                }
                column(AcadYear; coursereg."Academic Year")
                {
                }
                column(YearOfStudyText; YearOfStudyText)
                {
                }
                column(NextYear; NextYear)
                {
                }
                column(SaltedExamStatusDesc; SaltedExamStatusDesc)
                {
                }
                column(SaltedExamStatus; SaltedExamStatus)
                {
                }
                column(counts; CurrNo)
                {
                }
                column(YoSTexed; YoS)
                {
                }
                column(UnitCodeLabel; UnitCodeLabel)
                {
                }
                column(UnitDescriptionLabel; UnitDescriptionLabel)
                {
                }
                column(PercentageFailedCaption; PercentageFailedCaption)
                {
                }
                column(NumberOfCoursesFailedCaption; NumberOfCoursesFailedCaption)
                {
                }
                column(PercentageFailedValue; PercentageFailedValue)
                {
                }
                column(NoOfCausesFailedValue; NoOfCausesFailedValue)
                {
                }
                column(YoA; coursereg."Year of Admission")
                {
                }
                column(SpecialUnitReg; SpecialUnitReg1)
                {
                }
                dataitem("ACA-Student Units"; 61549)
                {
                    DataItemLink = "Student No." = FIELD("Student No."),
                                   Programme = FIELD(Programmes),
                                   "Year Of Study" = FIELD("Year Of Study");
                    DataItemTableView = WHERE(Grade = FILTER('E' | 'X' | 'X' | 'F' | ''));
                    column(UnitCode; "ACA-Student Units".Unit)
                    {
                    }
                    column(UnitDesc; UnitsRec.Desription)
                    {
                    }
                    column(SpecialReason; "ACA-Student Units"."Reason for Special Exam/Susp.")
                    {
                    }
                    column(IsSpecialUnit; IsSpecialUnit)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(IsSpecialUnit);//IsSpecialUnit:=TRUE;
                        IF "ACA-Student Units"."Special Exam" <> "ACA-Student Units"."Special Exam"::" " THEN IsSpecialUnit := TRUE;
                        IF UnitCodeLabel = '' THEN CurrReport.SKIP;
                        UnitsRec.RESET;
                        UnitsRec.SETRANGE("Programme Code", "ACA-Student Units".Programme);
                        UnitsRec.SETRANGE(Code, "ACA-Student Units".Unit);
                        IF UnitsRec.FIND('-') THEN BEGIN
                        END;
                        //IF "ACA-Student Units".Grade<>'E' THEN CurrReport.SKIP;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    CLEAR(SpecialUnitReg);
                    coursereg.CALCFIELDS(coursereg."Special Exam Exists");
                    coursereg.CALCFIELDS(coursereg."Yearly Passed Units", coursereg."Yearly Failed Units");
                    coursereg.CALCFIELDS(coursereg."Yearly Total Units Taken");
                    CLEAR(NextYear);
                    CLEAR(YearOfStudyText);
                    CLEAR(YoS);
                    IF coursereg."Year Of Study" <> 0 THEN BEGIN
                        IF coursereg."Year Of Study" = 1 THEN BEGIN
                            YearOfStudyText := 'First Year (1)';
                            YoS := 'FIRST';
                            IF coursereg."Yearly Failed Units" = 0 THEN
                                NextYear := 'SECOND'
                            ELSE
                                NextYear := 'FIRST';
                        END ELSE
                            IF coursereg."Year Of Study" = 2 THEN BEGIN
                                YearOfStudyText := 'Second Year (2)';
                                YoS := 'SECOND';
                                IF coursereg."Yearly Failed Units" = 0 THEN
                                    NextYear := 'THIRD'
                                ELSE
                                    NextYear := 'THIRD';
                            END ELSE
                                IF coursereg."Year Of Study" = 3 THEN BEGIN
                                    YearOfStudyText := 'Third Year (3)';
                                    YoS := 'THIRD';
                                    IF coursereg."Yearly Failed Units" = 0 THEN
                                        NextYear := 'FOURTH'
                                    ELSE
                                        NextYear := 'THIRD';
                                END ELSE
                                    IF coursereg."Year Of Study" = 4 THEN BEGIN
                                        YearOfStudyText := 'Fourth Year (4)';
                                        YoS := 'FOURTH';
                                        NextYear := 'FOUR';
                                    END;
                    END;
                    CLEAR(IsaForthYear);
                    IF ((coursereg.Stage = 'Y4S1') OR (coursereg.Stage = 'Y4S2')) THEN
                        IsaForthYear := TRUE;


                    CLEAR(progName);
                    Prog.RESET;
                    Prog.SETRANGE(Code, coursereg.Programmes);
                    IF Prog.FIND('-') THEN BEGIN
                        progName := Prog.Description;
                    END;
                    CLEAR(Msg1);
                    CLEAR(Msg2);
                    CLEAR(Msg3);
                    CLEAR(Msg4);
                    CLEAR(Msg5);
                    CLEAR(Msg6);

                    //Get the Department
                    CLEAR(FacDesc);
                    CLEAR(facCode);
                    FacDesc := '';
                    Prog.RESET;
                    Prog.SETRANGE(Code, coursereg.Programmes);
                    Prog.SETFILTER("School Code", '<>%1', '');
                    IF Prog.FIND('-') THEN BEGIN
                        Dimensions2.RESET;
                        Dimensions2.SETRANGE("Dimension Code", 'FACULTY');
                        Dimensions2.SETRANGE(Code, Prog."School Code");
                        IF Dimensions2.FIND('-') THEN BEGIN
                            FacDesc := Dimensions2.Name;
                            facCode := Dimensions2.Code;
                        END;
                    END;


                    IF Cust.GET(coursereg."Student No.") THEN;
                    Names := Cust.Name;
                    RegNo := coursereg."Student No.";
                    CLEAR(UnitCodeLabel);
                    CLEAR(UnitDescriptionLabel);
                    CLEAR(PercentageFailedCaption);
                    CLEAR(NumberOfCoursesFailedCaption);
                    CLEAR(PercentageFailedValue);
                    CLEAR(NoOfCausesFailedValue);
                    ACAResultsStatus.RESET;
                    ACAResultsStatus.SETRANGE(Code, coursereg."Yearly Remarks");
                    ACAResultsStatus.SETRANGE("Academic Year", coursereg."Academic Year");
                    IF ACAResultsStatus.FIND('-') THEN BEGIN
                        IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                            UnitCodeLabel := 'Course Code';
                            UnitDescriptionLabel := 'Course Description';
                            IF coursereg."Yearly Failed Units" > 0 THEN BEGIN
                                PercentageFailedCaption := '% Failed';
                                //NumberOfCoursesFailedCaption:='Courses Failed';
                                //NoOfCausesFailedValue:=coursereg."Yearly Failed Units";
                                IF ((coursereg."Yearly Failed Units" > 0) AND (coursereg."Yearly Total Units Taken" > 0)) THEN
                                    PercentageFailedValue := ROUND((((coursereg."Yearly Failed Units") / (coursereg."Yearly Total Units Taken")) * 100), 0.01, '=');

                            END;
                        END;
                    END;
                    coursereg.CALCFIELDS(coursereg."Special Exam Exists");
                    IF coursereg."Special Exam Exists" <> coursereg."Special Exam Exists"::" " THEN BEGIN
                        NumberOfCoursesFailedCaption := 'Reason';
                        PercentageFailedCaption := '';
                    END;

                    IF ACAResultsStatus."Include Academic Year Caption" THEN
                        IF ACAResultsStatus."Academic Year Text" <> '' THEN
                            Msg1 := ACAResultsStatus."Academic Year Text" + ' ' + ACAResultsStatus."Status Msg1" ELSE
                            Msg1 := ACAResultsStatus."Status Msg1";
                    Msg2 := ACAResultsStatus."Status Msg2";
                    Msg3 := ACAResultsStatus."Status Msg3";
                    Msg4 := ACAResultsStatus."Status Msg4";
                    IF IsaForthYear THEN
                        IF ACAResultsStatus."Final Year Comment" = '' THEN IsaForthYear := FALSE;
                    Msg5 := ACAResultsStatus."Status Msg5";
                    Msg6 := ACAResultsStatus."Status Msg6";
                    CLEAR(SaltedExamStatus);
                    CLEAR(SaltedExamStatusDesc);
                    SaltedExamStatus := ACAResultsStatus.Code + facCode + Prog.Code +
                    FORMAT(coursereg."Year Of Study") +
                    coursereg."Academic Year";
                    CLEAR(NoOfStudents);
                    CLEAR(NoOfStudentsDecimal);
                    CReg.RESET;
                    CReg.SETRANGE("Yearly Remarks", coursereg."Yearly Remarks");
                    CReg.SETRANGE("Academic Year", coursereg."Academic Year");
                    CReg.SETRANGE(Programmes, coursereg.Programmes);
                    CReg.SETRANGE("Year Of Study", coursereg."Year Of Study");
                    CReg.SETFILTER("Yearly Total Units Taken", '>%1', 0);
                    CReg.SETFILTER(Reversed, '%1', FALSE);
                    IF CReg.FIND('-') THEN BEGIN
                        // // // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)),1,'>'));
                        // // // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                        // // // // //    END;
                        // // // // //  //NoOfStudents:=CReg.COUNT;
                        // // // // //  END;
                        //---------------------------------------------------------
                        ACASenateReportCounts.RESET;
                        ACASenateReportCounts.SETRANGE("Prog. Code", coursereg.Programmes);
                        ACASenateReportCounts.SETRANGE(StatusCode, coursereg."Yearly Remarks");
                        ACASenateReportCounts.SETRANGE("Academic Year", coursereg."Academic Year");
                        ACASenateReportCounts.SETRANGE(YoS, coursereg."Year Of Study");
                        IF ACASenateReportCounts.FIND('-') THEN BEGIN
                            NoOfStudentsDecimal := FORMAT(ROUND(((ACASenateReportCounts.COUNT)), 1, '>'));
                            IF EVALUATE(NoOfStudents, NoOfStudentsDecimal) THEN;
                        END;
                        //---------------------------------------------------------

                        SaltedExamStatusDesc := Msg1;
                        CLEAR(NoOfStudentInText);
                        IF NoOfStudents <> 0 THEN NoOfStudentInText := ConvertDecimalToText.InitiateConvertion(NoOfStudents);
                        IF ACAResultsStatus."IncludeVariable 1" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + NoOfStudentInText + ' (' + FORMAT(NoOfStudents) + ') ' + Msg2;
                        IF ACAResultsStatus."IncludeVariable 2" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc + ' ' + Msg3;
                        IF ACAResultsStatus."IncludeVariable 3" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + YearOfStudyText + ' ' + Msg4 + ' ' + progName;
                        IF IsaForthYear = FALSE THEN BEGIN
                            IF ACAResultsStatus."IncludeVariable 4" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + Msg5;
                            IF ACAResultsStatus."IncludeVariable 5" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + NextYear;
                            IF ACAResultsStatus."IncludeVariable 6" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + Msg6;
                        END ELSE
                            SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                    END;
                    CLEAR(CurrNo);
                    ACASenateReportStatusBuff.RESET;
                    ACASenateReportStatusBuff.SETRANGE("Prog. Code", coursereg.Programmes);
                    ACASenateReportStatusBuff.SETRANGE(StatusCode, coursereg."Yearly Remarks");
                    ACASenateReportStatusBuff.SETRANGE("Academic Year", coursereg."Academic Year");
                    ACASenateReportStatusBuff.SETRANGE(YoS, coursereg."Year Of Study");
                    ACASenateReportStatusBuff.SETRANGE("Student No.", coursereg."Student No.");
                    IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                        ACASenateReportStatusBuff.INIT;
                        ACASenateReportStatusBuff."Prog. Code" := coursereg.Programmes;
                        ACASenateReportStatusBuff."Student No." := coursereg."Student No.";
                        ACASenateReportStatusBuff.Counts := 1;
                        ACASenateReportStatusBuff.StatusCode := coursereg."Yearly Remarks";
                        ACASenateReportStatusBuff.YoS := coursereg."Year Of Study";
                        ACASenateReportStatusBuff."Academic Year" := coursereg."Academic Year";
                        ACASenateReportStatusBuff.INSERT;
                    END;
                    ACASenateReportStatusBuff.RESET;
                    ACASenateReportStatusBuff.SETRANGE("Prog. Code", coursereg.Programmes);
                    ACASenateReportStatusBuff.SETRANGE(StatusCode, coursereg."Yearly Remarks");
                    ACASenateReportStatusBuff.SETRANGE("Academic Year", coursereg."Academic Year");
                    ACASenateReportStatusBuff.SETRANGE(YoS, coursereg."Year Of Study");
                    IF ACASenateReportStatusBuff.FIND('-') THEN CurrNo := ACASenateReportStatusBuff.COUNT;
                    // CurrNo:=CurrNo+1;
                    /* END ELSE BEGIN
                       CurrNo:=1;
                       ACASenateReportStatusBuff.INIT;
                       ACASenateReportStatusBuff."Prog. Code":=coursereg.Programme;
                       ACASenateReportStatusBuff.Counts:=CurrNo;
                       ACASenateReportStatusBuff.StatusCode:=coursereg."Exam Status";
                       ACASenateReportStatusBuff.YoS:=coursereg."Year Of Study";
                       ACASenateReportStatusBuff."Academic Year":=coursereg."Academic Year";
                       ACASenateReportStatusBuff.INSERT;
                       END;*/

                    ResultsStatus3.RESET;
                    ResultsStatus3.SETRANGE(Code, coursereg."Yearly Remarks");
                    IF ResultsStatus3.FIND('-') THEN;
                    CLEAR(SpecialUnitReg1);
                    //SpecialUnitReg1:=TRUE;

                    IF coursereg."Special Exam Exists" <> coursereg."Special Exam Exists"::" " THEN
                        SpecialUnitReg1 := TRUE;

                end;

                trigger OnPreDataItem()
                begin
                    IF coursereg.GETFILTER(coursereg.Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                    IF coursereg.GETFILTER(coursereg.Stage) <> '' THEN ERROR('Stage Filters are not allowed.');
                    CLEAR(yosInt);
                    IF coursereg.GETFILTER("Academic Year") = '' THEN ERROR('Specify the academic year filter!');
                    IF EVALUATE(yosInt, coursereg.GETFILTER("Year Of Study")) THEN;
                    CReg.RESET;
                    //CReg.SETRANGE("Yearly Remarks",coursereg."Yearly Remarks");
                    CReg.SETRANGE("Academic Year", coursereg.GETFILTER("Academic Year"));
                    IF coursereg.GETFILTER(Programmes) <> '' THEN
                        CReg.SETRANGE(Programmes, coursereg.GETFILTER(Programmes));
                    IF yosInt <> 0 THEN
                        CReg.SETRANGE("Year Of Study", yosInt);
                    //CReg.SETRANGE(Options,coursereg.GETFILTER(Options));
                    CReg.SETFILTER("Yearly Total Units Taken", '>%1', 0);
                    CReg.SETFILTER(Reversed, '%1', FALSE);
                    CReg.SETFILTER("Yearly Remarks", '<>%1', '');
                    IF CReg.FIND('-') THEN BEGIN
                        ACASenateReportCounts.RESET;
                        IF coursereg.GETFILTER(Programmes) <> '' THEN
                            ACASenateReportCounts.SETRANGE("Prog. Code", coursereg.GETFILTER(Programmes));
                        //ACASenateReportCounts.SETRANGE(StatusCode,CReg."Yearly Remarks");
                        ACASenateReportCounts.SETRANGE("Academic Year", CReg."Academic Year");
                        IF yosInt <> 0 THEN
                            ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                        IF ACASenateReportCounts.FIND('-') THEN ACASenateReportCounts.DELETEALL;
                        REPEAT
                        BEGIN
                            ACASenateReportCounts.RESET;
                            ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                            ACASenateReportCounts.SETRANGE(StatusCode, COPYSTR(CReg."Yearly Remarks", 1, 50));
                            ACASenateReportCounts.SETRANGE("Academic Year", CReg."Academic Year");
                            ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                            ACASenateReportCounts.SETRANGE("Student No.", CReg."Student No.");
                            IF NOT ACASenateReportCounts.FIND('-') THEN BEGIN
                                ACASenateReportCounts.INIT;
                                ACASenateReportCounts."Prog. Code" := CReg.Programmes;
                                ACASenateReportCounts."Student No." := CReg."Student No.";
                                ACASenateReportCounts.StatusCode := COPYSTR(CReg."Yearly Remarks", 1, 50);
                                ACASenateReportCounts.YoS := CReg."Year Of Study";
                                ACASenateReportCounts."Academic Year" := CReg."Academic Year";
                                ACASenateReportCounts.INSERT;
                            END;
                            // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)),1,'>'));
                            // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                            // // //    END;
                            //NoOfStudents:=CReg.COUNT;
                        END;
                        UNTIL CReg.NEXT = 0;
                    END;
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
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;

    var
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record 77720;
        NoOfStudentInText: Text[250];
        ConvertDecimalToText: Codeunit "Convert Decimal To Text ACA";
        PercentageFailedCaption: Text[100];
        NumberOfCoursesFailedCaption: Text[100];
        PercentageFailedValue: Decimal;
        NoOfCausesFailedValue: Integer;
        NoOfStudentsDecimal: Text;
        ACAStudentUnits: Record 61549;
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        StudUnits: Record 61549;
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record 18;
        Semesters: Record 61692;
        Dimensions: Record 349;
        Prog: Record 61511;
        FacDesc: Code[100];
        Depts: Record 349;
        Stages: Record 61516;
        StudentsL: Text[250];
        N: Integer;
        Grd: Code[20];
        Marks: Decimal;
        Dimensions2: Record 349;
        ResultsStatus: Record 61739;
        ResultsStatus3: Record 61739;
        UnitsRec: Record 61517;
        UnitsDesc: Text[100];
        UnitsHeader: Text[50];
        FailsDesc: Text[200];
        Nx: Integer;
        RegNo: Code[20];
        Names: Text[100];
        Ucount: Integer;
        RegNox: Code[20];
        Namesx: Text[100];
        Nxx: Text[30];
        SemYear: Code[20];
        ShowSem: Boolean;
        SemDesc: Code[100];
        CREG2: Record 61532;
        ExamsProcessing: Codeunit 60110;
        CompInf: Record 79;
        YearDesc: Text[30];
        MaxYear: Code[20];
        MaxSem: Code[20];
        CummScore: Decimal;
        CurrScore: Decimal;
        mDate: Date;

        IntakeDesc: Text[100];
        SemFilter: Text[100];
        StageFilter: Text[100];
        MinYear: Code[20];
        MinSem: Code[20];
        StatusNarrations: Text[1000];
        NextYear: Code[20];
        facCode: Code[20];
        progName: Code[150];
        ACAResultsStatus: Record 61739;
        Msg1: Text[250];
        Msg2: Text[250];
        Msg3: Text[250];
        Msg4: Text[250];
        Msg5: Text[250];
        Msg6: Text[250];
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        ACASenateReportStatusBuff: Record 77718 temporary;
        CurrNo: Integer;
        YoS: Code[20];
        CReg33: Record 61532;
        CReg: Record 61532;
        yosInt: Integer;
        resstus: Record "ACA-Results Status";
        coursereg: Record "ACA-Course Registration";
}

