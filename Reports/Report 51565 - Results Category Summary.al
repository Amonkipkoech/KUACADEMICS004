report 51565 "Results Category Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Results Category Summary.rdl';

    dataset
    {
        dataitem(AcaCoreg1; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE("Yearly Total Units Taken" = FILTER(> 0),
                                      "Yearly Remarks" = FILTER(<> ''),
                                      Reversed = FILTER(false));
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
            column(StatusCode; ResultsStatus3.Description)
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
            column(RegTrans; AcaCoreg1."Reg. Transacton ID")
            {
            }
            column(StudNo; AcaCoreg1."Student No.")
            {
            }
            column(Progs; AcaCoreg1.Programmes)
            {
            }
            column(ProgName; progName)
            {
            }
            column(Sems; AcaCoreg1.Semester)
            {
            }
            column(RegFor; AcaCoreg1."Register for")
            {
            }
            column(CourseStage; AcaCoreg1.Stage)
            {
            }
            column(Units; AcaCoreg1.Unit)
            {
            }
            column(StudType; AcaCoreg1."Student Type")
            {
            }
            column(EntryNo; AcaCoreg1."Entry No.")
            {
            }
            column(CampusCode; AcaCoreg1."Campus Code")
            {
            }
            column(ExamStatus; AcaCoreg1."Exam Status")
            {
            }
            column(FailedUnits; AcaCoreg1."Failed Unit")
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; AcaCoreg1."Year Of Study")
            {
            }
            column(AcadYear; AcaCoreg1."Academic Year")
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
            column(YoA; AcaCoreg1."Year of Admission")
            {
            }
            column(SpecialUnitReg; SpecialUnitReg1)
            {
            }
            column(TransitionValPercentage; ACASenateReportPercentages."Transition Percentage")
            {
            }
            column(TransitionVal; ACASenateReportPercentages."Transition Value")
            {
            }
            column(StatusPercentageValue; ACASenateReportPercentages."Status Percentage")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."), Programme = FIELD(programmes),
                               "Year Of Study" = FIELD("Year Of Study"),
                               "Academic Year" = FIELD("Academic Year");
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
                ACASenateReportPercentages.RESET;
                ACASenateReportPercentages.SETRANGE("Prog. Code", AcaCoreg1.Programmes);
                ACASenateReportPercentages.SETRANGE(StatusCode, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACASenateReportPercentages.SETRANGE(YoS, AcaCoreg1."Year Of Study");
                ACASenateReportPercentages.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                ACASenateReportPercentages.SETRANGE("User ID", USERID);
                IF ACASenateReportPercentages.FIND('-') THEN BEGIN
                    ACASenateReportPercentages.CALCFIELDS("Transition Value");
                END;

                AcaCoreg1.CALCFIELDS(AcaCoreg1."Special Exam Exists");
                AcaCoreg1.CALCFIELDS(AcaCoreg1."Yearly Passed Units", AcaCoreg1."Yearly Failed Units");
                AcaCoreg1.CALCFIELDS(AcaCoreg1."Yearly Total Units Taken");
                CLEAR(NextYear);
                CLEAR(YearOfStudyText);
                CLEAR(YoS);
                IF AcaCoreg1."Year Of Study" <> 0 THEN BEGIN
                    IF AcaCoreg1."Year Of Study" = 1 THEN BEGIN
                        YearOfStudyText := 'First Year (1)';
                        YoS := 'FIRST';
                        IF AcaCoreg1."Yearly Failed Units" = 0 THEN
                            NextYear := 'SECOND'
                        ELSE
                            NextYear := 'FIRST';
                    END ELSE
                        IF AcaCoreg1."Year Of Study" = 2 THEN BEGIN
                            YearOfStudyText := 'Second Year (2)';
                            YoS := 'SECOND';
                            IF AcaCoreg1."Yearly Failed Units" = 0 THEN
                                NextYear := 'THIRD'
                            ELSE
                                NextYear := 'THIRD';
                        END ELSE
                            IF AcaCoreg1."Year Of Study" = 3 THEN BEGIN
                                YearOfStudyText := 'Third Year (3)';
                                YoS := 'THIRD';
                                IF AcaCoreg1."Yearly Failed Units" = 0 THEN
                                    NextYear := 'FOURTH'
                                ELSE
                                    NextYear := 'THIRD';
                            END ELSE
                                IF AcaCoreg1."Year Of Study" = 4 THEN BEGIN
                                    YearOfStudyText := 'Fourth Year (4)';
                                    YoS := 'FOURTH';
                                    NextYear := 'FOUR';
                                END;
                END;
                CLEAR(IsaForthYear);
                IF ((AcaCoreg1.Stage = 'Y4S1') OR (AcaCoreg1.Stage = 'Y4S2')) THEN
                    IsaForthYear := TRUE;


                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(Code, AcaCoreg1.Programmes);
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
                Prog.SETRANGE(Code, AcaCoreg1.Programmes);
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


                IF Cust.GET(AcaCoreg1."Student No.") THEN;
                Names := Cust.Name;
                RegNo := AcaCoreg1."Student No.";
                CLEAR(UnitCodeLabel);
                CLEAR(UnitDescriptionLabel);
                CLEAR(PercentageFailedCaption);
                CLEAR(NumberOfCoursesFailedCaption);
                CLEAR(PercentageFailedValue);
                CLEAR(NoOfCausesFailedValue);

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACAResultsStatus.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                        UnitCodeLabel := 'Course Code';
                        UnitDescriptionLabel := 'Course Description';
                        IF AcaCoreg1."Yearly Failed Units" > 0 THEN BEGIN
                            PercentageFailedCaption := '% Failed';
                            //NumberOfCoursesFailedCaption:='Courses Failed';
                            //NoOfCausesFailedValue:=AcaCoreg1."Yearly Failed Units";
                            IF ((AcaCoreg1."Yearly Failed Units" > 0) AND (AcaCoreg1."Yearly Total Units Taken" > 0)) THEN
                                PercentageFailedValue := ROUND((((AcaCoreg1."Yearly Failed Units") / (AcaCoreg1."Yearly Total Units Taken")) * 100), 0.01, '=');

                        END;
                    END;
                END;
                AcaCoreg1.CALCFIELDS(AcaCoreg1."Special Exam Exists");
                IF AcaCoreg1."Special Exam Exists" <> AcaCoreg1."Special Exam Exists"::" " THEN BEGIN
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
                FORMAT(AcaCoreg1."Year Of Study") +
                AcaCoreg1."Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);
                // // CReg.RESET;
                // // CReg.SETRANGE("Yearly Remarks",COPYSTR(AcaCoreg1."Yearly Remarks",1,30));
                // // CReg.SETRANGE("Academic Year",AcaCoreg1."Academic Year");
                // // CReg.SETRANGE(Programme,AcaCoreg1.Programme);
                // // CReg.SETRANGE("Year Of Study",AcaCoreg1."Year Of Study");
                // // CReg.SETFILTER("Yearly Total Units Taken",'>%1',0);
                // // CReg.SETFILTER(Reversed,'%1',FALSE);
                // // IF CReg.FIND('-') THEN BEGIN
                // // // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)),1,'>'));
                // // // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                // // // // //    END;
                // // // // //  //NoOfStudents:=CReg.COUNT;
                // // // // //  END;
                //---------------------------------------------------------
                ACASenateReportCounts.RESET;
                ACASenateReportCounts.SETRANGE("Prog. Code", AcaCoreg1.Programmes);
                ACASenateReportCounts.SETRANGE(StatusCode, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACASenateReportCounts.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                ACASenateReportCounts.SETRANGE(YoS, AcaCoreg1."Year Of Study");
                ACASenateReportCounts.SETRANGE("User ID", USERID);
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
                //END;
                CLEAR(CurrNo);
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", AcaCoreg1.Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACASenateReportStatusBuff.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, AcaCoreg1."Year Of Study");
                ACASenateReportStatusBuff.SETRANGE("Student No.", AcaCoreg1."Student No.");
                IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                    ACASenateReportStatusBuff.INIT;
                    ACASenateReportStatusBuff."Prog. Code" := AcaCoreg1.Programmes;
                    ACASenateReportStatusBuff."Student No." := AcaCoreg1."Student No.";
                    ACASenateReportStatusBuff.Counts := 1;
                    ACASenateReportStatusBuff.StatusCode := COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30);
                    ACASenateReportStatusBuff.YoS := AcaCoreg1."Year Of Study";
                    ACASenateReportStatusBuff."Academic Year" := AcaCoreg1."Academic Year";
                    ACASenateReportStatusBuff.INSERT;
                END;
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", AcaCoreg1.Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACASenateReportStatusBuff.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, AcaCoreg1."Year Of Study");
                IF ACASenateReportStatusBuff.FIND('-') THEN;


                ACASenateReportCounts2.RESET;
                ACASenateReportCounts2.SETRANGE("Prog. Code", AcaCoreg1.Programmes);
                ACASenateReportCounts2.SETRANGE(StatusCode, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                ACASenateReportCounts2.SETRANGE("Academic Year", AcaCoreg1."Academic Year");
                ACASenateReportCounts2.SETRANGE(YoS, AcaCoreg1."Year Of Study");
                ACASenateReportCounts2.SETRANGE("Student No.", AcaCoreg1."Student No.");
                ACASenateReportCounts2.SETRANGE("User ID", USERID);

                IF ACASenateReportCounts2.FIND('-') THEN
                    CurrNo := ACASenateReportCounts2."Counted Recs";
                // CurrNo:=CurrNo+1;
                /* END ELSE BEGIN
                   CurrNo:=1;
                   ACASenateReportStatusBuff.INIT;
                   ACASenateReportStatusBuff."Prog. Code":=AcaCoreg1.Programme;
                   ACASenateReportStatusBuff.Counts:=CurrNo;
                   ACASenateReportStatusBuff.StatusCode:=AcaCoreg1."Exam Status";
                   ACASenateReportStatusBuff.YoS:=AcaCoreg1."Year Of Study";
                   ACASenateReportStatusBuff."Academic Year":=AcaCoreg1."Academic Year";
                   ACASenateReportStatusBuff.INSERT;
                   END;*/

                ResultsStatus3.RESET;
                ResultsStatus3.SETRANGE(Code, COPYSTR(AcaCoreg1."Yearly Remarks", 1, 30));
                IF ResultsStatus3.FIND('-') THEN;
                CLEAR(SpecialUnitReg1);
                //SpecialUnitReg1:=TRUE;

                IF AcaCoreg1."Special Exam Exists" <> AcaCoreg1."Special Exam Exists"::" " THEN
                    SpecialUnitReg1 := TRUE;

            end;

            trigger OnPreDataItem()
            var
                ACASenateReportCounts44: Record 77720;
                countedList: Integer;
            begin
                IF AcaCoreg1.GETFILTER(AcaCoreg1.Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                IF AcaCoreg1.GETFILTER(AcaCoreg1.Stage) <> '' THEN ERROR('Stage Filters are not allowed.');


                ACASenateReportCounts.RESET;
                ACASenateReportCounts.SETRANGE("User ID", USERID);
                IF ACASenateReportCounts.FIND('-') THEN ACASenateReportCounts.DELETEALL;

                CLEAR(yosInt);
                IF AcaCoreg1.GETFILTER("Academic Year") = '' THEN ERROR('Specify the academic year filter!');
                IF EVALUATE(yosInt, AcaCoreg1.GETFILTER("Year Of Study")) THEN;
                // // CReg.RESET;
                // // //CReg.SETRANGE("Yearly Remarks",AcaCoreg1."Yearly Remarks");
                // // CReg.SETRANGE("Academic Year",AcaCoreg1.GETFILTER("Academic Year"));
                // // IF AcaCoreg1.GETFILTER(Programme)<>'' THEN
                // //  CReg.SETRANGE(Programme,AcaCoreg1.GETFILTER(Programme));
                // // IF yosInt<>0 THEN
                // // CReg.SETRANGE("Year Of Study",yosInt);
                //CReg.SETRANGE(Options,AcaCoreg1.GETFILTER(Options));
                CReg.RESET;
                CReg.COPYFILTERS(AcaCoreg1);
                //CReg.SETFILTER("Yearly Total Units Taken",'>%1',0);
                //CReg.SETFILTER(Reversed,'%1',FALSE);
                //CReg.SETFILTER("Yearly Remarks",'<>%1','');
                IF CReg.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACASenateReportCounts.RESET;
                        ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                        ACASenateReportCounts.SETRANGE(StatusCode, COPYSTR(CReg."Yearly Remarks", 1, 30));
                        ACASenateReportCounts.SETRANGE("Academic Year", CReg."Academic Year");
                        ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                        ACASenateReportCounts.SETRANGE("Student No.", CReg."Student No.");
                        ACASenateReportCounts.SETRANGE("User ID", USERID);

                        IF NOT ACASenateReportCounts.FIND('-') THEN BEGIN
                            ACASenateReportCounts.INIT;
                            ACASenateReportCounts."Prog. Code" := CReg.Programmes;
                            ACASenateReportCounts."Student No." := CReg."Student No.";
                            ACASenateReportCounts.StatusCode := COPYSTR(CReg."Yearly Remarks", 1, 30);
                            ACASenateReportCounts.YoS := CReg."Year Of Study";
                            ACASenateReportCounts."Academic Year" := CReg."Academic Year";
                            ACASenateReportCounts."User ID" := USERID;
                            ACASenateReportCounts.INSERT;
                        END;
                    END;
                    UNTIL CReg.NEXT = 0;
                END;
                /////////////////////////////////////////////////////////// Update %ges
                ACASenateReportPercentages.RESET;
                ACASenateReportPercentages.SETRANGE("User ID", USERID);
                IF ACASenateReportPercentages.FIND('-') THEN ACASenateReportPercentages.DELETEALL;

                ACASenateReportCounts.RESET;
                ACASenateReportCounts.SETRANGE("User ID", USERID);
                IF ACASenateReportCounts.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACASenateReportPercentages.RESET;
                        ACASenateReportPercentages.SETRANGE("Prog. Code", ACASenateReportCounts."Prog. Code");
                        ACASenateReportPercentages.SETRANGE(StatusCode, ACASenateReportCounts.StatusCode);
                        ACASenateReportPercentages.SETRANGE(YoS, ACASenateReportCounts.YoS);
                        ACASenateReportPercentages.SETRANGE("Academic Year", ACASenateReportCounts."Academic Year");
                        ACASenateReportPercentages.SETRANGE("User ID", USERID);
                        IF NOT ACASenateReportPercentages.FIND('-') THEN BEGIN
                            ACASenateReportPercentages.INIT;
                            ACASenateReportPercentages."Prog. Code" := ACASenateReportCounts."Prog. Code";
                            ACASenateReportPercentages.StatusCode := ACASenateReportCounts.StatusCode;
                            ACASenateReportPercentages.YoS := ACASenateReportCounts.YoS;
                            ACASenateReportPercentages."Academic Year" := ACASenateReportCounts."Academic Year";
                            ACASenateReportPercentages."User ID" := USERID;
                            ACASenateReportPercentages.INSERT;
                            // Rank The Students in the Buffer
                            CLEAR(countedList);
                            ACASenateReportCounts2.RESET;
                            ACASenateReportCounts2.SETRANGE("Prog. Code", ACASenateReportCounts."Prog. Code");
                            ACASenateReportCounts2.SETRANGE(StatusCode, ACASenateReportCounts.StatusCode);
                            ACASenateReportCounts2.SETRANGE("Academic Year", ACASenateReportCounts."Academic Year");
                            ACASenateReportCounts2.SETRANGE(YoS, ACASenateReportCounts.YoS);
                            ACASenateReportCounts2.SETRANGE("User ID", USERID);

                            IF ACASenateReportCounts2.FIND('-') THEN BEGIN
                                REPEAT
                                    countedList := countedList + 1;
                                    ACASenateReportCounts2."Counted Recs" := countedList;
                                    ACASenateReportCounts2.MODIFY;
                                UNTIL ACASenateReportCounts2.NEXT = 0;
                            END;
                        END;
                    END;
                    UNTIL ACASenateReportCounts.NEXT = 0;
                END;

                ACASenateReportPercentages.RESET;
                ACASenateReportPercentages.SETRANGE("User ID", USERID);
                IF ACASenateReportPercentages.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ACASenateReportPercentages.CALCFIELDS("Transition Value", "Total Students", "Status Counted");
                        IF ACASenateReportPercentages."Total Students" > 0 THEN BEGIN
                            ACASenateReportPercentages."Transition Percentage" := (ACASenateReportPercentages."Transition Value" / ACASenateReportPercentages."Total Students") * 100;
                            ACASenateReportPercentages."Status Percentage" := (ACASenateReportPercentages."Status Counted" / ACASenateReportPercentages."Total Students") * 100;
                            ACASenateReportPercentages.MODIFY;
                        END;
                    END;
                    UNTIL ACASenateReportPercentages.NEXT = 0;
                END;
                /////////////////////////////////////////////////////////// End Updatting %ges

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
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;

    var
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record 77720;
        ACASenateReportCounts2: Record 77720;
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

        Prog: Record 61511;
        FacDesc: Code[100];

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
        ACAResultsStatus2: Record 61739;
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
        ACASenateReportPercentages: Record 77726;
}

