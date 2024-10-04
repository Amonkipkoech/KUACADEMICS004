/// <summary>
/// Report Senate Summary of Graduation (ID 78018).
/// </summary>
report 78018 "Senate Summary of Graduation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reporst/SSR/SenateSummaryofGraduation.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; 61532)
        {
            DataItemTableView = SORTING("Year of Admission", "Student No.")
                                ORDER(Ascending)
                                WHERE("Is Final Year Student" = FILTER(true),
                                      Reversed = FILTER(false),
                                      Status = FILTER(Registration | Current | Deceased),
                                      "Final Clasification" = FILTER(<> '' & <> 'INCOMPLETE'),
                                      "Final Stage" = FILTER(true));
            RequestFilterFields = Faculty, "Graduation Academic Year", Programmes, "Year Of Study";
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
            column(StatusOrderCompiled; StatusOrder)
            {
            }
            column(statusCompiled; statusCompiled)
            {
            }
            column(StatusCode; ResultsStatus3.Code)
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
            column(RegTrans; "ACA-Course Registration"."Reg. Transacton ID")
            {
            }
            column(StudNo; "ACA-Course Registration"."Student No.")
            {
            }
            column(Progs; "ACA-Course Registration".Programmes)
            {
            }
            column(ProgName; progName)
            {
            }
            column(Sems; "ACA-Course Registration".Semester)
            {
            }
            column(RegFor; "ACA-Course Registration"."Register for")
            {
            }
            column(CourseStage; "ACA-Course Registration".Stage)
            {
            }
            column(Units; "ACA-Course Registration".Unit)
            {
            }
            column(StudType; "ACA-Course Registration"."Student Type")
            {
            }
            column(EntryNo; "ACA-Course Registration"."Entry No.")
            {
            }
            column(CampusCode; "ACA-Course Registration"."Campus Code")
            {
            }
            column(ExamStatus; "ACA-Course Registration"."Exam Status")
            {
            }
            column(FailedUnits; "ACA-Course Registration"."Failed Unit")
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; "ACA-Course Registration"."Year Of Study")
            {
            }
            column(AcadYear; "ACA-Course Registration"."Graduation Academic Year")
            {
            }
            column(GraduationGroup; "ACA-Course Registration"."Graduation Group")
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
            column(YoA; "ACA-Course Registration"."Year of Admission")
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
            dataitem("ACA-Student Units"; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes);
                DataItemTableView = WHERE("Supp. Grade" = FILTER('E' | 'X' | 'X' | 'F' | ''),
                                          "Reg. Reversed" = FILTER(false));
                column(UnitCode; "ACA-Student Units".Unit)
                {
                }
                column(UnitDesc; "ACA-Student Units".Description)
                {
                }
                column(SpecialReason; SpecialReason)
                {
                }
                column(IsSpecialUnit; IsSpecialUnit)
                {
                }
                column(failExists; failExists)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(IsSpecialUnit);//IsSpecialUnit:=TRUE;
                    "ACA-Student Units".CALCFIELDS("ACA-Student Units"."No of Supplementaries", "ACA-Student Units"."Has Supplementary");
                    IF ((isSpecialOnly) OR (IsSpecialAndSupp)) THEN BEGIN
                        IF "ACA-Student Units"."Special Exam" <> "ACA-Student Units"."Special Exam"::" " THEN IsSpecialUnit := TRUE;
                        IF "ACA-Student Units"."No of Supplementaries" > 0 THEN IsSpecialUnit := TRUE;
                    END;
                    CLEAR(failExists);
                    IF "ACA-Student Units"."No of Supplementaries" > 0 THEN IsSpecialUnit := TRUE;
                    IF "ACA-Student Units"."Has Supplementary" THEN IsSpecialUnit := TRUE;
                    IF ("ACA-Student Units"."Supp. Grade" IN ['E', 'F', '']) THEN failExists := TRUE;
                    // IF failExists THEN UnitCodeLabel:='COURSE CODE & TITLE';
                    IF UnitCodeLabel = '' THEN CurrReport.SKIP;
                    //IF "ACA-Student Units".Grade<>'E' THEN CurrReport.SKIP;
                    CLEAR(SpecialReason);
                    IF "ACA-Student Units"."Reason for Special Exam/Susp." <> '' THEN
                        SpecialReason := "ACA-Student Units"."Reason for Special Exam/Susp."
                    ELSE
                        SpecialReason := 'SUPP';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(SpecialUnitReg);
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Special Exam Exists");
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Supp. Yearly Passed Units", "ACA-Course Registration"."Supp. Yearly Failed Units");
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Supp. Yearly Total Units Taken", "ACA-Course Registration"."Is Final Year Student");
                CLEAR(NextYear);
                CLEAR(YearOfStudyText);
                CLEAR(YoS);
                IF "ACA-Course Registration"."Year Of Study" <> 0 THEN BEGIN
                    IF "ACA-Course Registration"."Year Of Study" = 1 THEN BEGIN
                        YearOfStudyText := 'First Year (1)';
                        YoS := 'FIRST';
                        IF "ACA-Course Registration"."Yearly Failed Units" = 0 THEN
                            NextYear := 'SECOND'
                        ELSE
                            NextYear := 'FIRST';
                    END ELSE
                        IF "ACA-Course Registration"."Year Of Study" = 2 THEN BEGIN
                            YearOfStudyText := 'Second Year (2)';
                            YoS := 'SECOND';
                            IF "ACA-Course Registration"."Yearly Failed Units" = 0 THEN
                                NextYear := 'THIRD'
                            ELSE
                                NextYear := 'THIRD';
                        END ELSE
                            IF "ACA-Course Registration"."Year Of Study" = 3 THEN BEGIN
                                YearOfStudyText := 'Third Year (3)';
                                YoS := 'THIRD';
                                IF "ACA-Course Registration"."Yearly Failed Units" = 0 THEN
                                    NextYear := 'FOURTH'
                                ELSE
                                    NextYear := 'THIRD';
                            END ELSE
                                IF "ACA-Course Registration"."Year Of Study" = 4 THEN BEGIN
                                    YearOfStudyText := 'Fourth Year (4)';
                                    YoS := 'FOURTH';
                                    NextYear := 'FOUR';
                                END;
                END;
                CLEAR(IsaForthYear);
                CLEAR(statusCompiled);
                IsaForthYear := "ACA-Course Registration"."Is Final Year Student";
                // IF (("ACA-Course Registration".Stage='Y4S1') OR ("ACA-Course Registration".Stage='Y4S2')) THEN
                //   IsaForthYear:=TRUE;
                CLEAR(StatusOrder);
                IF "ACA-Course Registration"."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                    statusCompiled := 'INCOMPLETE RESULTS LIST';
                    StatusOrder := 2;
                END
                ELSE
                    IF "ACA-Course Registration"."Final Clasification" <> '' THEN BEGIN
                        statusCompiled := 'GRADUATION LIST';
                        StatusOrder := 1;
                    END;

                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(Code, "ACA-Course Registration".Programmes);
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
                Prog.SETRANGE(Code, "ACA-Course Registration".Programmes);
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


                IF Cust.GET("ACA-Course Registration"."Student No.") THEN;
                Names := Cust.Name;
                RegNo := "ACA-Course Registration"."Student No.";
                CLEAR(UnitCodeLabel);
                CLEAR(UnitDescriptionLabel);
                CLEAR(PercentageFailedCaption);
                CLEAR(NumberOfCoursesFailedCaption);
                CLEAR(PercentageFailedValue);
                CLEAR(NoOfCausesFailedValue);
                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, "ACA-Course Registration"."Final Clasification");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                        UnitCodeLabel := 'COURESE CODE & TITLE';
                        UnitDescriptionLabel := '';
                        IF "ACA-Course Registration"."Yearly Failed Units" > 0 THEN BEGIN
                            PercentageFailedCaption := '% Failed';
                            //NumberOfCoursesFailedCaption:='Courses Failed';
                            //NoOfCausesFailedValue:="ACA-Course Registration"."Yearly Failed Units";
                            IF (("ACA-Course Registration"."Supp. Yearly Failed Units" > 0) AND ("ACA-Course Registration"."Supp. Yearly Total Units Taken" > 0)) THEN
                                PercentageFailedValue := ROUND(((("ACA-Course Registration"."Supp. Yearly Failed Units") / ("ACA-Course Registration"."Supp. Yearly Total Units Taken")) * 100), 0.01, '=');

                        END;
                    END;
                END;
                // // // // // // //    "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Special Exam Exists");
                // // // // // // //    IF "ACA-Course Registration"."Special Exam Exists"<>"ACA-Course Registration"."Special Exam Exists"::" " THEN BEGIN
                // // // // // // //      NumberOfCoursesFailedCaption:='Reason';
                // // // // // // //      PercentageFailedCaption:='';
                // // // // // // //      END;
                Msg1 := ACAResultsStatus."Classification Msg1";
                Msg2 := ACAResultsStatus."Classification Msg2";
                Msg3 := ACAResultsStatus."Classification Msg3";
                Msg4 := ACAResultsStatus."Classification Msg4";
                //  IF  IsaForthYear THEN
                //   IF ACAResultsStatus."Final Year Comment"='' THEN IsaForthYear:=FALSE;
                Msg5 := ACAResultsStatus."Classification Msg5";
                Msg6 := ACAResultsStatus."Classification Msg6";
                CLEAR(SaltedExamStatus);
                CLEAR(SaltedExamStatusDesc);
                SaltedExamStatus := ACAResultsStatus.Code + facCode + Prog.Code +
                FORMAT("ACA-Course Registration"."Year Of Study") +
                "ACA-Course Registration"."Graduation Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);
                CReg.RESET;
                CReg.SETRANGE("Final Clasification", "ACA-Course Registration"."Final Clasification");
                CReg.SETRANGE("Graduation Academic Year", "ACA-Course Registration"."Graduation Academic Year");
                CReg.SETRANGE(Programmes, "ACA-Course Registration".Programmes);
                CReg.SETRANGE("Year Of Study", "ACA-Course Registration"."Year Of Study");
                CReg.SETFILTER("Supp. Yearly Total Units Taken", '>%1', 0);
                CReg.SETFILTER(Reversed, '%1', FALSE);
                CReg.SETFILTER("Is Final Year Student", '%1', TRUE);
                CReg.SETFILTER(Status, '%1|%2|%3', CReg.Status::Current, CReg.Status::Deceased, CReg.Status::Registration);
                IF CReg.FIND('-') THEN;// BEGIN
                                       // // // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)),1,'>'));
                                       // // // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                                       // // // // //    END;
                                       // // // // //  //NoOfStudents:=CReg.COUNT;
                                       // // // // //  END;
                                       //---------------------------------------------------------
                ACASenateReportCounts.RESET;
                ACASenateReportCounts.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                IF "ACA-Course Registration"."Final Clasification" = 'INCOMPLETE' THEN
                    ACASenateReportCounts.SETRANGE(StatusCode, 'INCOMPLETE') ELSE
                    ACASenateReportCounts.SETRANGE(StatusCode, 'PASS');

                ACASenateReportCounts.SETRANGE("Academic Year", "ACA-Course Registration"."Graduation Academic Year");
                ACASenateReportCounts.SETRANGE(YoS, "ACA-Course Registration"."Year Of Study");
                IF ACASenateReportCounts.FIND('-') THEN BEGIN
                    NoOfStudentsDecimal := FORMAT(ROUND(((ACASenateReportCounts.COUNT)), 1, '>'));
                    IF EVALUATE(NoOfStudents, NoOfStudentsDecimal) THEN;
                END;
                //---------------------------------------------------------

                SaltedExamStatusDesc := Msg1;
                CLEAR(NoOfStudentInText);
                IF NoOfStudents <> 0 THEN NoOfStudentInText := ConvertDecimalToText.InitiateConvertion(NoOfStudents);
                IF ACAResultsStatus."Include Class Variable 1" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + NoOfStudentInText + ' (' + FORMAT(NoOfStudents) + ') ' + Msg2;
                IF ACAResultsStatus."Include Class Variable 2" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc + ' ' + Msg3 + ' ' + progName + ' ' + Prog."Exam Category";
                IF ACAResultsStatus."Include Class Variable 3" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + Msg4;
                IF ACAResultsStatus."Include Class Variable 4" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + progName + ' ' + Msg5;
                IF ACAResultsStatus."Include Class Variable 5" THEN SaltedExamStatusDesc := SaltedExamStatusDesc;//+' '+NextYear;
                IF ACAResultsStatus."Include Class Variable 6" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + Msg6;
                SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                //END;
                CLEAR(CurrNo);
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, "ACA-Course Registration"."Final Clasification");
                ACASenateReportStatusBuff.SETRANGE("Academic Year", "ACA-Course Registration"."Graduation Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, "ACA-Course Registration"."Year Of Study");
                ACASenateReportStatusBuff.SETRANGE("Student No.", "ACA-Course Registration"."Student No.");
                IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                    ACASenateReportStatusBuff.INIT;
                    ACASenateReportStatusBuff."Prog. Code" := "ACA-Course Registration".Programmes;
                    ACASenateReportStatusBuff."Student No." := "ACA-Course Registration"."Student No.";
                    ACASenateReportStatusBuff.Counts := 1;
                    ACASenateReportStatusBuff.StatusCode := "ACA-Course Registration"."Final Clasification";
                    ACASenateReportStatusBuff.YoS := "ACA-Course Registration"."Year Of Study";
                    ACASenateReportStatusBuff."Academic Year" := "ACA-Course Registration"."Graduation Academic Year";
                    ACASenateReportStatusBuff.INSERT;
                END;
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, "ACA-Course Registration"."Final Clasification");
                ACASenateReportStatusBuff.SETRANGE("Academic Year", "ACA-Course Registration"."Graduation Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, "ACA-Course Registration"."Year Of Study");
                IF ACASenateReportStatusBuff.FIND('-') THEN CurrNo := ACASenateReportStatusBuff.COUNT;
                // CurrNo:=CurrNo+1;
                /* END ELSE BEGIN
                   CurrNo:=1;
                   ACASenateReportStatusBuff.INIT;
                   ACASenateReportStatusBuff."Prog. Code":="ACA-Course Registration".Programme;
                   ACASenateReportStatusBuff.Counts:=CurrNo;
                   ACASenateReportStatusBuff.StatusCode:="ACA-Course Registration"."Exam Status";
                   ACASenateReportStatusBuff.YoS:="ACA-Course Registration"."Year Of Study";
                   ACASenateReportStatusBuff."Academic Year":="ACA-Course Registration"."Academic Year";
                   ACASenateReportStatusBuff.INSERT;
                   END;*/

                ResultsStatus3.RESET;
                ResultsStatus3.SETRANGE(Code, "ACA-Course Registration"."Final Clasification");
                IF ResultsStatus3.FIND('-') THEN;
                CLEAR(SpecialUnitReg1);
                //SpecialUnitReg1:=TRUE;

                IF "ACA-Course Registration"."Special Exam Exists" <> "ACA-Course Registration"."Special Exam Exists"::" " THEN
                    SpecialUnitReg1 := TRUE;

                CLEAR(isSpecialOnly);
                CLEAR(IsSpecialAndSupp);
                IF ("ACA-Course Registration"."Supp. Yearly Remarks" = 'SPECIAL') THEN BEGIN
                    isSpecialOnly := TRUE;
                    PercentageFailedCaption := '';
                    PercentageFailedValue := 0;
                    NumberOfCoursesFailedCaption := 'Reason';
                END;
                IF ("ACA-Course Registration"."Supp. Yearly Remarks" = 'SUPP/SPECIAL') THEN BEGIN
                    IsSpecialAndSupp := TRUE;
                    PercentageFailedCaption := '% Failed';
                    NumberOfCoursesFailedCaption := 'Reason';
                END;

                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Exists Where Not Graduating");

                IF "ACA-Course Registration"."Exists Where Not Graduating" = TRUE THEN IsSpecialAndSupp := TRUE;
                NotSpecialNotSuppSpecial := FALSE;
                IF ((isSpecialOnly) OR (IsSpecialAndSupp)) THEN BEGIN
                    NotSpecialNotSuppSpecial := TRUE;
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration".Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage) <> '' THEN ERROR('Stage Filters are not allowed.');
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Graduation Academic Year") = '' THEN ERROR('Specify Graduation Academic Year');
                CLEAR(yosInt);
                CLEAR(statusCompiled);


                IF EVALUATE(yosInt, "ACA-Course Registration".GETFILTER("Year Of Study")) THEN;
                CReg.RESET;
                //CReg.SETRANGE("Supp. Yearly Remarks","ACA-Course Registration"."Supp. Yearly Remarks");
                CReg.SETRANGE("Graduation Academic Year", "ACA-Course Registration".GETFILTER("Graduation Academic Year"));
                CReg.SETRANGE(Programmes, "ACA-Course Registration".GETFILTER(Programmes));
                CReg.SETRANGE("Year Of Study", yosInt);
                //CReg.SETRANGE(Options,"ACA-Course Registration".GETFILTER(Options));
                CReg.SETFILTER("Final Graduating Average", '>%1', 0);
                CReg.SETFILTER(Reversed, '%1', FALSE);
                CReg.SETFILTER("Final Clasification", '<>%1', '');
                CReg.SETFILTER("Is Final Year Student", '%1', TRUE);
                CReg.SETFILTER(Status, '%1|%2|%3', CReg.Status::Current, CReg.Status::Deceased, CReg.Status::Registration);
                //CReg.SETFILTER("Supp. Yearly Remarks",'<>%1','');
                //CReg.SETFILTER("Supplementary Exists",'%1',TRUE);
                IF CReg.FIND('-') THEN BEGIN
                    ACASenateReportCounts.RESET;
                    ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                    //IF CReg."Final Clasification"='INCOMPLETE' THEN
                    ACASenateReportCounts.SETFILTER(StatusCode, 'INCOMPLETE|PASS');
                    //ELSE
                    //ACASenateReportCounts.SETRANGE(StatusCode,'PASS');
                    ACASenateReportCounts.SETRANGE("Academic Year", CReg."Graduation Academic Year");
                    ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                    IF ACASenateReportCounts.FIND('-') THEN ACASenateReportCounts.DELETEALL;
                    REPEAT
                    BEGIN
                        ACASenateReportCounts.RESET;
                        ACASenateReportCounts.SETRANGE("Prog. Code", CReg.Programmes);
                        IF CReg."Final Clasification" = 'INCOMPLETE' THEN
                            ACASenateReportCounts.SETRANGE(StatusCode, 'INCOMPLETE')
                        ELSE
                            ACASenateReportCounts.SETRANGE(StatusCode, 'PASS');
                        //ACASenateReportCounts.SETRANGE(StatusCode,CReg."Supp. Yearly Remarks");
                        ACASenateReportCounts.SETRANGE("Academic Year", CReg."Graduation Academic Year");
                        ACASenateReportCounts.SETRANGE(YoS, CReg."Year Of Study");
                        ACASenateReportCounts.SETRANGE("Student No.", CReg."Student No.");
                        IF NOT ACASenateReportCounts.FIND('-') THEN BEGIN
                            ACASenateReportCounts.INIT;
                            ACASenateReportCounts."Prog. Code" := CReg.Programmes;
                            ACASenateReportCounts."Student No." := CReg."Student No.";
                            IF CReg."Final Clasification" = 'INCOMPLETE' THEN
                                ACASenateReportCounts.StatusCode := 'INCOMPLETE'
                            ELSE
                                ACASenateReportCounts.StatusCode := 'PASS';
                            ACASenateReportCounts.YoS := CReg."Year Of Study";
                            ACASenateReportCounts."Academic Year" := CReg."Graduation Academic Year";
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

    trigger OnInitReport()
    begin
        CompInf.GET();
        CompInf.CALCFIELDS(CompInf.Picture);
    end;

    var
        SpecialReason: Text[150];
        failExists: Boolean;
        StatusOrder: Integer;
        statusCompiled: Code[50];
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

        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;

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
        ResultsStatus: Record 78011;
        ResultsStatus3: Record 78011;
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
        ACAResultsStatus: Record 78011;
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

        CReg: Record 61532;
        yosInt: Integer;
}

