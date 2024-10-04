/// <summary>
/// Report Supp. Results Category Summary (ID 78010).
/// </summary>
report 78010 "Supp. Results Category Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Supp. Results Category Summary.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE("Supp. Yearly Total Units Taken" = FILTER(<> 0),
                                      "Supp. Yearly Remarks" = FILTER(<> ''),
                                      Reversed = FILTER('No'),
                                      "Supplementary Exists" = FILTER('Yes'));
            RequestFilterFields = Faculty, "Academic Year", Programmes, "Year Of Study";
            column(Student_No_; "Student No.")
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
            column(StatusCode; ResultsStatus3."Supp. Lubric Caption 6")
            {
            }
            column(StatusDesc; ResultsStatus.Description)
            {
            }
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
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
            column(RegTrans; reg."Reg. Transacton ID")
            {
            }
            column(StudNo; reg."Student No.")
            {
            }
            column(Progs; reg.Programmes)
            {
            }
            column(ProgName; progName)
            {
            }
            column(Sems; reg.Semester)
            {
            }
            column(RegFor; reg."Register for")
            {
            }
            column(CourseStage; reg.Stage)
            {
            }
            column(Units; reg.Unit)
            {
            }
            column(StudType; reg."Student Type")
            {
            }
            column(EntryNo; reg."Entry No.")
            {
            }
            column(CampusCode; reg."Campus Code")
            {
            }
            column(ExamStatus; reg."Exam Status")
            {
            }
            column(FailedUnits; reg."Failed Unit")
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; reg."Year Of Study")
            {
            }
            column(AcadYear; reg."Academic Year")
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
            column(YoA; reg."Year of Admission")
            {
            }
            column(SpecialUnitReg; SpecialUnitReg1)
            {
            }
            column(IsSpecialAndSupp; IsSpecialAndSupp)
            {
            }
            column(IsSpecialOnly; isSpecialOnly)
            {
            }
            column(NotSpecialNotSuppSpecial; NotSpecialNotSuppSpecial)
            {
            }
            dataitem(DataItem1000000014; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               "Year Of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE(Grade = FILTER('E|X|X|F|'));
                column(UnitCode; unitss.unit)
                {
                }
                column(UnitDesc; unitss.Description)
                {
                }
                column(SpecialReason; unitss."Reason for Special Exam/Susp.")
                {
                }
                column(IsSpecialUnit; IsSpecialUnit)
                {
                }


                trigger OnAfterGetRecord()
                begin
                    CLEAR(IsSpecialUnit);//IsSpecialUnit:=TRUE;
                    IF ((isSpecialOnly) OR (IsSpecialAndSupp)) THEN BEGIN
                        IF unitss."Special Exam" <> unitss."Special Exam"::" " THEN IsSpecialUnit := TRUE;
                        IF unitss.Grade IN ['E', 'X', 'F', ''] THEN IsSpecialUnit := TRUE;
                    END;
                    IF UnitCodeLabel = '' THEN CurrReport.SKIP;
                    //IF unitss.Grade<>'E' THEN CurrReport.SKIP;
                end;
            }


            trigger OnAfterGetRecord()
            begin

                CLEAR(SpecialUnitReg);
                reg.CALCFIELDS(reg."Special Exam Exists");
                reg.CALCFIELDS(reg."Supp. Yearly Passed Units", reg."Supp. Yearly Failed Units");
                reg.CALCFIELDS(reg."Supp. Yearly Total Units Taken");
                CLEAR(NextYear);
                CLEAR(YearOfStudyText);
                CLEAR(YoS);
                IF reg."Year Of Study" <> 0 THEN BEGIN
                    IF reg."Year Of Study" = 1 THEN BEGIN
                        YearOfStudyText := 'First Year (1)';
                        YoS := 'FIRST';
                        IF reg."Yearly Failed Units" = 0 THEN
                            NextYear := 'SECOND'
                        ELSE
                            NextYear := 'FIRST';
                    END ELSE
                        IF reg."Year Of Study" = 2 THEN BEGIN
                            YearOfStudyText := 'Second Year (2)';
                            YoS := 'SECOND';
                            IF reg."Yearly Failed Units" = 0 THEN
                                NextYear := 'THIRD'
                            ELSE
                                NextYear := 'THIRD';
                        END ELSE
                            IF reg."Year Of Study" = 3 THEN BEGIN
                                YearOfStudyText := 'Third Year (3)';
                                YoS := 'THIRD';
                                IF reg."Yearly Failed Units" = 0 THEN
                                    NextYear := 'FOURTH'
                                ELSE
                                    NextYear := 'THIRD';
                            END ELSE
                                IF reg."Year Of Study" = 4 THEN BEGIN
                                    YearOfStudyText := 'Fourth Year (4)';
                                    YoS := 'FOURTH';
                                    NextYear := 'FOUR';
                                END;
                END;
                CLEAR(IsaForthYear);
                IF ((reg.Stage = 'Y4S1') OR (reg.Stage = 'Y4S2')) THEN
                    IsaForthYear := TRUE;


                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(Code, reg.Programmes);
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
                Prog.SETRANGE(Code, reg.Programmes);
                Prog.SETFILTER("School Code", '<>%1', '');
                IF Prog.FIND('-') THEN BEGIN
                    Dimensions2.RESET;
                    Dimensions2.SETRANGE("Dimension Code", 'SCHOOL');
                    Dimensions2.SETRANGE(Code, Prog."School Code");
                    IF Dimensions2.FIND('-') THEN BEGIN
                        FacDesc := Dimensions2.Name;
                        facCode := Dimensions2.Code;
                    END;
                END;


                IF Cust.GET(reg."Student No.") THEN;
                Names := Cust.Name;
                RegNo := reg."Student No.";
                CLEAR(UnitCodeLabel);
                CLEAR(UnitDescriptionLabel);
                CLEAR(PercentageFailedCaption);
                CLEAR(NumberOfCoursesFailedCaption);
                CLEAR(PercentageFailedValue);
                CLEAR(NoOfCausesFailedValue);
                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, "Supp. Yearly Remarks");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                        UnitCodeLabel := 'Course Code';
                        UnitDescriptionLabel := 'Course Title';
                        IF reg."Yearly Failed Units" > 0 THEN BEGIN
                            PercentageFailedCaption := '% Failed';
                            //NumberOfCoursesFailedCaption:='Courses Failed';
                            //NoOfCausesFailedValue:=reg."Yearly Failed Units";
                            IF ((reg."Supp. Yearly Failed Units" > 0) AND (reg."Supp. Yearly Total Units Taken" > 0)) THEN
                                PercentageFailedValue := ROUND((((reg."Supp. Yearly Failed Units") / (reg."Supp. Yearly Total Units Taken")) * 100), 0.01, '=');

                        END;
                    END;
                END;
                // // // // // // //    reg.CALCFIELDS(reg."Special Exam Exists");
                // // // // // // //    IF reg."Special Exam Exists"<>reg."Special Exam Exists"::" " THEN BEGIN
                // // // // // // //      NumberOfCoursesFailedCaption:='Reason';
                // // // // // // //      PercentageFailedCaption:='';
                // // // // // // //      END;
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
                FORMAT(reg."Year Of Study") +
                reg."Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);
                CReg.RESET;
                CReg.SETRANGE("Supp. Yearly Remarks", reg."Supp. Yearly Remarks");
                CReg.SETRANGE("Academic Year", reg."Academic Year");
                CReg.SETRANGE(Programmes, reg.Programmes);
                CReg.SETRANGE("Year Of Study", reg."Year Of Study");
                CReg.SETFILTER("Supp. Yearly Total Units Taken", '>%1', 0);
                CReg.SETFILTER(Reversed, '%1', FALSE);
                IF CReg.FIND('-') THEN BEGIN
                    // // // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)),1,'>'));
                    // // // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                    // // // // //    END;
                    // // // // //  //NoOfStudents:=CReg.COUNT;
                    // // // // //  END;
                    //---------------------------------------------------------
                    ACASenateReportCounts.RESET;
                    ACASenateReportCounts.SETRANGE("Prog. Code", reg.Programmes);
                    ACASenateReportCounts.SETRANGE(StatusCode, reg."Supp. Yearly Remarks");
                    ACASenateReportCounts.SETRANGE("Academic Year", reg."Academic Year");
                    ACASenateReportCounts.SETRANGE(YoS, reg."Year Of Study");
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
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", reg.Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, reg."Supp. Yearly Remarks");
                ACASenateReportStatusBuff.SETRANGE("Academic Year", reg."Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, reg."Year Of Study");
                ACASenateReportStatusBuff.SETRANGE("Student No.", reg."Student No.");
                IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                    ACASenateReportStatusBuff.INIT;
                    ACASenateReportStatusBuff."Prog. Code" := reg.Programmes;
                    ACASenateReportStatusBuff."Student No." := reg."Student No.";
                    ACASenateReportStatusBuff.Counts := 1;
                    ACASenateReportStatusBuff.StatusCode := reg."Supp. Yearly Remarks";
                    ACASenateReportStatusBuff.YoS := reg."Year Of Study";
                    ACASenateReportStatusBuff."Academic Year" := reg."Academic Year";
                    ACASenateReportStatusBuff.INSERT;
                END;
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", reg.Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, reg."Supp. Yearly Remarks");
                ACASenateReportStatusBuff.SETRANGE("Academic Year", reg."Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, reg."Year Of Study");
                IF ACASenateReportStatusBuff.FIND('-') THEN CurrNo := ACASenateReportStatusBuff.COUNT;
                // CurrNo:=CurrNo+1;
                /* END ELSE BEGIN
                   CurrNo:=1;
                   ACASenateReportStatusBuff.INIT;
                   ACASenateReportStatusBuff."Prog. Code":=reg.Programme;
                   ACASenateReportStatusBuff.Counts:=CurrNo;
                   ACASenateReportStatusBuff.StatusCode:=reg."Exam Status";
                   ACASenateReportStatusBuff.YoS:=reg."Year Of Study";
                   ACASenateReportStatusBuff."Academic Year":=reg."Academic Year";
                   ACASenateReportStatusBuff.INSERT;
                   END;*/

                ResultsStatus3.RESET;
                ResultsStatus3.SETRANGE(Code, reg."Supp. Yearly Remarks");
                IF ResultsStatus3.FIND('-') THEN;
                CLEAR(SpecialUnitReg1);
                //SpecialUnitReg1:=TRUE;

                IF reg."Special Exam Exists" <> reg."Special Exam Exists"::" " THEN
                    SpecialUnitReg1 := TRUE;

                CLEAR(isSpecialOnly);
                CLEAR(IsSpecialAndSupp);
                IF (reg."Supp. Yearly Remarks" = 'SPECIAL') THEN BEGIN
                    isSpecialOnly := TRUE;
                    PercentageFailedCaption := '';
                    PercentageFailedValue := 0;
                    NumberOfCoursesFailedCaption := 'Reason';
                END;
                IF (reg."Supp. Yearly Remarks" = 'SUPP/SPECIAL') THEN BEGIN
                    IsSpecialAndSupp := TRUE;
                    PercentageFailedCaption := '% Failed';
                    NumberOfCoursesFailedCaption := 'Reason';
                END;
                NotSpecialNotSuppSpecial := FALSE;
                IF ((isSpecialOnly) OR (IsSpecialAndSupp)) THEN BEGIN
                    NotSpecialNotSuppSpecial := TRUE;
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF reg.GETFILTER(reg.Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                IF reg.GETFILTER(reg.Stage) <> '' THEN ERROR('Stage Filters are not allowed.');
                CLEAR(yosInt);
                IF EVALUATE(yosInt, reg.GETFILTER("Year Of Study")) THEN;
                CReg.RESET;
                //CReg.SETRANGE("Supp. Yearly Remarks",reg."Supp. Yearly Remarks");
                CReg.SETRANGE("Academic Year", reg.GETFILTER("Academic Year"));
                CReg.SETRANGE(Programmes, reg.GETFILTER(Programmes));
                CReg.SETRANGE("Year Of Study", yosInt);
                //CReg.SETRANGE(Options,reg.GETFILTER(Options));
                CReg.SETFILTER("Supp. Yearly Total Units Taken", '>%1', 0);
                CReg.SETFILTER(Reversed, '%1', FALSE);
                CReg.SETFILTER("Supp. Yearly Remarks", '<>%1', '');
                CReg.SETFILTER("Supplementary Exists", '%1', TRUE);
                IF CReg.FIND('-') THEN BEGIN
                    ACASenateReportCounts.RESET;
                    ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                    //ACASenateReportCounts.SETRANGE(StatusCode,CReg."Supp. Yearly Remarks");
                    ACASenateReportCounts.SETRANGE("Academic Year", CReg."Academic Year");
                    ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                    IF ACASenateReportCounts.FIND('-') THEN ACASenateReportCounts.DELETEALL;
                    REPEAT
                    BEGIN
                        ACASenateReportCounts.RESET;
                        ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                        ACASenateReportCounts.SETRANGE(StatusCode, CReg."Supp. Yearly Remarks");
                        ACASenateReportCounts.SETRANGE("Academic Year", CReg."Academic Year");
                        ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                        ACASenateReportCounts.SETRANGE("Student No.", CReg."Student No.");
                        IF NOT ACASenateReportCounts.FIND('-') THEN BEGIN
                            ACASenateReportCounts.INIT;
                            ACASenateReportCounts."Prog. Code" := CReg.Programmes;
                            ACASenateReportCounts."Student No." := CReg."Student No.";
                            ACASenateReportCounts.StatusCode := CReg."Supp. Yearly Remarks";
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
    var
        unitss: Record "ACA-Student Units";
        reg: Record "ACA-Course Registration";
        NotSpecialNotSuppSpecial: Boolean;
        isSpecialOnly: Boolean;
        IsSpecialAndSupp: Boolean;
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
        IntakeRec: Record 61383;
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

    trigger OnInitReport()
    begin
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;



}

