report 81800 "Results Category Summary 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ResultsCategorySummary2.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; 61532)
        {
            DataItemTableView = SORTING("Student No.")
                                ORDER(Ascending)
                                WHERE("Yearly Total Units Taken" = FILTER(> 0));
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
            column(ApprovalsClaimer; 'Approved by the board of the Examiners of the  ' + FacDesc + ' at a meeting held on:')
            {
            }
            column(N; N)
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
            column(YoA; "ACA-Course Registration"."Year of Admission")
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
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
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
            column(AcadYear; "ACA-Course Registration"."Academic Year")
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
            column(StatusCode; ACAResultsStatus.Code)
            {
            }
            column(StatusOrder; ACAResultsStatus."Order No")
            {
            }
            column(StatCodes; ACAResultsStatus.Code)
            {
            }
            column(SpecialUnitReg; SpecialUnitReg1)
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
            dataitem("ACA-Student Units"; 61549)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               Programme = FIELD(Programmes),
                               "Year Of Study" = FIELD("Year Of Study");
                DataItemTableView = WHERE(Grade = FILTER('E'),
                                          Reversed = FILTER(false));
                column(UnitCode; "ACA-Student Units".Unit)
                {
                }
                column(UnitDesc; "ACA-Student Units".Description)
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
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // // // // // // "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Yearly Passed Units","ACA-Course Registration"."Yearly Failed Units");
                // // // // // // "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Yearly Total Units Taken");
                // // // // // // CLEAR(NextYear);
                // // // // // // CLEAR(YearOfStudyText);
                // // // // // // CLEAR(YoS);
                // // // // // // IF "ACA-Course Registration"."Year Of Study"<>0 THEN BEGIN
                // // // // // //  IF "ACA-Course Registration"."Year Of Study"=1 THEN BEGIN
                // // // // // //    YearOfStudyText:='Year One (1)';
                // // // // // //    YoS:='FIRST';
                // // // // // //    IF "ACA-Course Registration"."Yearly Failed Units"=0 THEN NextYear:='TWO'
                // // // // // //     ELSE NextYear:='ONE';
                // // // // // //  END ELSE IF "ACA-Course Registration"."Year Of Study"=2 THEN BEGIN
                // // // // // //    YearOfStudyText:='Year Two (2)';
                // // // // // //    YoS:='SECOND';
                // // // // // //    IF "ACA-Course Registration"."Yearly Failed Units"=0 THEN NextYear:='THREE'
                // // // // // //     ELSE NextYear:='TWO';
                // // // // // //  END ELSE IF "ACA-Course Registration"."Year Of Study"=3 THEN BEGIN
                // // // // // //    YearOfStudyText:='Year Three (3)';
                // // // // // //    YoS:='THIRD';
                // // // // // //    IF "ACA-Course Registration"."Yearly Failed Units"=0 THEN NextYear:='FOUR'
                // // // // // //     ELSE NextYear:='THREE';
                // // // // // //  END ELSE IF "ACA-Course Registration"."Year Of Study"=4 THEN BEGIN
                // // // // // //    YearOfStudyText:='Year Four (4)';
                // // // // // //    YoS:='FOURTH';
                // // // // // //   NextYear:='FOUR';
                // // // // // //    END;
                // // // // // //  END;
                // // // // // //
                // // // // // //
                // // // // // // CLEAR(progName);
                // // // // // // Prog.RESET;
                // // // // // // Prog.SETRANGE(Code,"ACA-Course Registration".Programme);
                // // // // // // IF Prog.FIND('-') THEN BEGIN
                // // // // // //  progName:=Prog.Description;
                // // // // // //  END;
                // // // // // //  CLEAR(Msg0);
                // // // // // //  CLEAR(Msg1);
                // // // // // //  CLEAR(Msg2);
                // // // // // //  CLEAR(Msg3);
                // // // // // //  CLEAR(Msg4);
                // // // // // //  CLEAR(Msg5);
                // // // // // //  CLEAR(Msg6);
                // // // // // //
                // // // // // // //Get the Department
                // // // // // // CLEAR(FacDesc);
                // // // // // // CLEAR(facCode);
                // // // // // // Prog.RESET;
                // // // // // // Prog.SETRANGE("Department Code","ACA-Course Registration".Programme);
                // // // // // // Prog.SETFILTER("Department Code",'<>%1','');
                // // // // // // IF Prog.FIND('-') THEN BEGIN
                // // // // // // Dimensions2.RESET;
                // // // // // // Dimensions2.SETFILTER("Dimension Code",'%1|%2','DEPARTMENT','DEPARTMENTS');
                // // // // // // Dimensions2.SETRANGE(Code,Prog."Department Code");
                // // // // // // IF Dimensions2.FIND('-') THEN BEGIN
                // // // // // //  FacDesc:=Dimensions2.Name;
                // // // // // //  facCode:=Dimensions2.Code;
                // // // // // //  END;
                // // // // // // END;
                // // // // // //
                // // // // // //  IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                // // // // // //  Names:=Cust.Name;
                // // // // // //  RegNo:="ACA-Course Registration"."Student No.";
                // // // // // //  CLEAR(UnitCodeLabel);
                // // // // // //  CLEAR(UnitDescriptionLabel);
                // // // // // //    CLEAR(PercentageFailedCaption);
                // // // // // //  CLEAR(NumberOfCoursesFailedCaption);
                // // // // // //  CLEAR(PercentageFailedValue);
                // // // // // //  CLEAR(NoOfCausesFailedValue);
                // // // // // // ACAResultsStatus.RESET;
                // // // // // // ACAResultsStatus.SETRANGE(Code,"ACA-Course Registration"."Yearly Remarks");
                // // // // // // ACAResultsStatus.SETRANGE("Academic Year","ACA-Course Registration"."Academic Year");
                // // // // // // IF ACAResultsStatus.FIND('-') THEN BEGIN
                // // // // // //  IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                // // // // // //    UnitCodeLabel:='Course Code';
                // // // // // //    UnitDescriptionLabel:='Course Description';
                // // // // // //    IF "ACA-Course Registration"."Yearly Failed Units">0 THEN BEGIN
                // // // // // //       PercentageFailedCaption:='% Failed';
                // // // // // //      //NumberOfCoursesFailedCaption:='Courses Failed';
                // // // // // //      //NoOfCausesFailedValue:="ACA-Course Registration"."Yearly Failed Units";
                // // // // // //      IF (("ACA-Course Registration"."Yearly Failed Units">0) AND ("ACA-Course Registration"."Yearly Total Units Taken">0)) THEN
                // // // // // //      PercentageFailedValue:=ROUND(((("ACA-Course Registration"."Yearly Failed Units")/("ACA-Course Registration"."Yearly Total Units Taken"))*100),0.01,'=');
                // // // // // //
                // // // // // //      END;
                // // // // // //    END;
                // // // // // //    END;
                // // // // // //    "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Special Exam Exists");
                // // // // // //    IF "ACA-Course Registration"."Special Exam Exists"<>"ACA-Course Registration"."Special Exam Exists"::" " THEN BEGIN
                // // // // // //      NumberOfCoursesFailedCaption:='Reason';
                // // // // // //      PercentageFailedCaption:='';
                // // // // // //      END;
                // // // // // // // // // ACAResultsStatus.RESET;
                // // // // // // // // // ACAResultsStatus.SETRANGE(Code,"ACA-Course Registration"."Exam Status");
                // // // // // // // // // IF ACAResultsStatus.FIND('-') THEN BEGIN
                // // // // // // // // //  IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                // // // // // // // // //    UnitCodeLabel:='Unit';
                // // // // // // // // //    UnitDescriptionLabel:='Description';
                // // // // // // // // //    END;
                // // // // // //    IF ACAResultsStatus."Include Academic Year Caption" THEN
                // // // // // //      IF ACAResultsStatus."Academic Year"<>'' THEN
                // // // // // //        Msg0:=ACAResultsStatus."Academic Year";
                // // // // // //  Msg1:=ACAResultsStatus."Status Msg1";
                // // // // // //  Msg2:=ACAResultsStatus."Status Msg2";
                // // // // // //  Msg3:=ACAResultsStatus."Status Msg3";
                // // // // // //  Msg4:=ACAResultsStatus."Status Msg4";
                // // // // // //  Msg5:=ACAResultsStatus."Status Msg5";
                // // // // // //  Msg6:=ACAResultsStatus."Status Msg6";
                // // // // // // CLEAR(SaltedExamStatus);
                // // // // // // CLEAR(SaltedExamStatusDesc);
                // // // // // // SaltedExamStatus:=ACAResultsStatus.Code+facCode+Prog.Code+
                // // // // // // FORMAT("ACA-Course Registration"."Year Of Study")+
                // // // // // // "ACA-Course Registration"."Academic Year";
                // // // // // // CLEAR(NoOfStudents);
                // // // // // // CLEAR(NoOfStudentsDecimal);
                // // // // // // CReg.RESET;
                // // // // // // CReg.SETRANGE("Exam Status","ACA-Course Registration"."Exam Status");
                // // // // // // CReg.SETRANGE("Academic Year","ACA-Course Registration"."Academic Year");
                // // // // // // CReg.SETRANGE(Programme,"ACA-Course Registration".Programme);
                // // // // // // CReg.SETRANGE("Year Of Study","ACA-Course Registration"."Year Of Study");
                // // // // // // CReg.SETFILTER("Yearly Total Units Taken",'>%1',0);
                // // // // // // //CReg.SETFILTER("Exam Status",'<>%1','');
                // // // // // // IF CReg.FIND('-') THEN BEGIN
                // // // // // //  NoOfStudentsDecimal:=FORMAT(ROUND(((CReg.COUNT)/2),1,'>'));
                // // // // // //  IF EVALUATE(NoOfStudents,NoOfStudentsDecimal) THEN BEGIN
                // // // // // //    END;
                // // // // // //  //NoOfStudents:=CReg.COUNT;
                // // // // // //  END;
                // // // // // //  IF Msg0<>'' THEN SaltedExamStatusDesc:=Msg0+' '+Msg1
                // // // // // //  ELSE SaltedExamStatusDesc:=Msg1;
                // // // // // // IF ACAResultsStatus."IncludeVariable 1" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+FORMAT(NoOfStudents)+' '+Msg2;
                // // // // // // IF  ACAResultsStatus."IncludeVariable 2" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc +' '+FacDesc+' '+Msg3;
                // // // // // // IF ACAResultsStatus."IncludeVariable 3" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+YearOfStudyText+' '+Msg4;
                // // // // // // IF ACAResultsStatus."IncludeVariable 4" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+progName+' '+Msg5;
                // // // // // // IF ACAResultsStatus."IncludeVariable 5" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+NextYear;
                // // // // // // IF ACAResultsStatus."IncludeVariable 6" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+Msg6;
                // // // // // //
                // // // // // //  CLEAR(CurrNo);
                // // // // // // ACASenateReportStatusBuff.RESET;
                // // // // // // ACASenateReportStatusBuff.SETRANGE("Prog. Code","ACA-Course Registration".Programme);
                // // // // // // ACASenateReportStatusBuff.SETRANGE(StatusCode,"ACA-Course Registration"."Exam Status");
                // // // // // // ACASenateReportStatusBuff.SETRANGE("Academic Year","ACA-Course Registration"."Academic Year");
                // // // // // // ACASenateReportStatusBuff.SETRANGE(YoS,"ACA-Course Registration"."Year Of Study");
                // // // // // // ACASenateReportStatusBuff.SETRANGE("Student No.","ACA-Course Registration"."Student No.");
                // // // // // // IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                // // // // // //    ACASenateReportStatusBuff.INIT;
                // // // // // //    ACASenateReportStatusBuff."Prog. Code":="ACA-Course Registration".Programme;
                // // // // // //    ACASenateReportStatusBuff."Student No.":="ACA-Course Registration"."Student No.";
                // // // // // //    ACASenateReportStatusBuff.Counts:=1;
                // // // // // //    ACASenateReportStatusBuff.StatusCode:="ACA-Course Registration"."Exam Status";
                // // // // // //    ACASenateReportStatusBuff.YoS:="ACA-Course Registration"."Year Of Study";
                // // // // // //    ACASenateReportStatusBuff."Academic Year":="ACA-Course Registration"."Academic Year";
                // // // // // //    ACASenateReportStatusBuff.INSERT;
                // // // // // //    END;
                // // // // // // ACASenateReportStatusBuff.RESET;
                // // // // // // ACASenateReportStatusBuff.SETRANGE("Prog. Code","ACA-Course Registration".Programme);
                // // // // // // ACASenateReportStatusBuff.SETRANGE(StatusCode,"ACA-Course Registration"."Exam Status");
                // // // // // // ACASenateReportStatusBuff.SETRANGE("Academic Year","ACA-Course Registration"."Academic Year");
                // // // // // // ACASenateReportStatusBuff.SETRANGE(YoS,"ACA-Course Registration"."Year Of Study");
                // // // // // // IF  ACASenateReportStatusBuff.FIND('-') THEN   CurrNo:=ACASenateReportStatusBuff.COUNT;
                // // // // // // // CurrNo:=CurrNo+1;
                // // // // // // { END ELSE BEGIN
                // // // // // //    CurrNo:=1;
                // // // // // //    ACASenateReportStatusBuff.INIT;
                // // // // // //    ACASenateReportStatusBuff."Prog. Code":="ACA-Course Registration".Programme;
                // // // // // //    ACASenateReportStatusBuff.Counts:=CurrNo;
                // // // // // //    ACASenateReportStatusBuff.StatusCode:="ACA-Course Registration"."Exam Status";
                // // // // // //    ACASenateReportStatusBuff.YoS:="ACA-Course Registration"."Year Of Study";
                // // // // // //    ACASenateReportStatusBuff."Academic Year":="ACA-Course Registration"."Academic Year";
                // // // // // //    ACASenateReportStatusBuff.INSERT;
                // // // // // //    END;}
                // // // // // //
                // // // // // //  CLEAR(SpecialUnitReg1);
                // // // // // // //SpecialUnitReg1:=TRUE;
                // // // // // //
                // // // // // // IF "ACA-Course Registration"."Special Exam Exists"<>"ACA-Course Registration"."Special Exam Exists"::" " THEN
                // // // // // // SpecialUnitReg1:=TRUE;
                CLEAR(SpecialUnitReg);
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Special Exam Exists");
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Yearly Passed Units", "ACA-Course Registration"."Yearly Failed Units");
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Yearly Total Units Taken");
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
                IF (("ACA-Course Registration".Stage = 'Y4S1') OR ("ACA-Course Registration".Stage = 'Y4S2')) THEN
                    IsaForthYear := TRUE;


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
                ACAResultsStatus.SETRANGE(Code, COPYSTR("ACA-Course Registration"."Yearly Remarks", 1, 50));
                ACAResultsStatus.SETRANGE("Academic Year", "ACA-Course Registration"."Academic Year");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Failed Units Headers" THEN BEGIN
                        UnitCodeLabel := 'Course Code';
                        UnitDescriptionLabel := 'Course Description';
                        IF "ACA-Course Registration"."Yearly Failed Units" > 0 THEN BEGIN
                            PercentageFailedCaption := '% Failed';
                            //NumberOfCoursesFailedCaption:='Courses Failed';
                            //NoOfCausesFailedValue:="ACA-Course Registration"."Yearly Failed Units";
                            IF (("ACA-Course Registration"."Yearly Failed Units" > 0) AND ("ACA-Course Registration"."Yearly Total Units Taken" > 0)) THEN
                                PercentageFailedValue := ROUND(((("ACA-Course Registration"."Yearly Failed Units") / ("ACA-Course Registration"."Yearly Total Units Taken")) * 100), 0.01, '=');

                        END;
                    END;
                END;
                "ACA-Course Registration".CALCFIELDS("ACA-Course Registration"."Special Exam Exists");
                IF "ACA-Course Registration"."Special Exam Exists" <> "ACA-Course Registration"."Special Exam Exists"::" " THEN BEGIN
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
                FORMAT("ACA-Course Registration"."Year Of Study") +
                "ACA-Course Registration"."Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);
                CReg.RESET;
                CReg.SETRANGE("Yearly Remarks", "ACA-Course Registration"."Yearly Remarks");
                CReg.SETRANGE("Academic Year", "ACA-Course Registration"."Academic Year");
                CReg.SETRANGE(Programmes, "ACA-Course Registration".Programmes);
                CReg.SETRANGE("Year Of Study", "ACA-Course Registration"."Year Of Study");
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
                    ACASenateReportCounts.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                    ACASenateReportCounts.SETRANGE(StatusCode, "ACA-Course Registration"."Yearly Remarks");
                    ACASenateReportCounts.SETRANGE("Academic Year", "ACA-Course Registration"."Academic Year");
                    ACASenateReportCounts.SETRANGE(YoS, "ACA-Course Registration"."Year Of Study");
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
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, COPYSTR("ACA-Course Registration"."Yearly Remarks", 1, 30));
                ACASenateReportStatusBuff.SETRANGE("Academic Year", "ACA-Course Registration"."Academic Year");
                ACASenateReportStatusBuff.SETRANGE(YoS, "ACA-Course Registration"."Year Of Study");
                ACASenateReportStatusBuff.SETRANGE("Student No.", "ACA-Course Registration"."Student No.");
                IF NOT ACASenateReportStatusBuff.FIND('-') THEN BEGIN
                    ACASenateReportStatusBuff.INIT;
                    ACASenateReportStatusBuff."Prog. Code" := "ACA-Course Registration".Programmes;
                    ACASenateReportStatusBuff."Student No." := "ACA-Course Registration"."Student No.";
                    ACASenateReportStatusBuff.Counts := 1;
                    ACASenateReportStatusBuff.StatusCode := COPYSTR("ACA-Course Registration"."Yearly Remarks", 1, 30);
                    ACASenateReportStatusBuff.YoS := "ACA-Course Registration"."Year Of Study";
                    ACASenateReportStatusBuff."Academic Year" := "ACA-Course Registration"."Academic Year";
                    ACASenateReportStatusBuff.INSERT;
                END;
                ACASenateReportStatusBuff.RESET;
                ACASenateReportStatusBuff.SETRANGE("Prog. Code", "ACA-Course Registration".Programmes);
                ACASenateReportStatusBuff.SETRANGE(StatusCode, COPYSTR("ACA-Course Registration"."Yearly Remarks", 1, 30));
                ACASenateReportStatusBuff.SETRANGE("Academic Year", "ACA-Course Registration"."Academic Year");
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
                ResultsStatus3.SETRANGE(Code, COPYSTR("ACA-Course Registration"."Yearly Remarks", 1, 50));
                IF ResultsStatus3.FIND('-') THEN;
                CLEAR(SpecialUnitReg1);
                //SpecialUnitReg1:=TRUE;

                IF "ACA-Course Registration"."Special Exam Exists" <> "ACA-Course Registration"."Special Exam Exists"::" " THEN
                    SpecialUnitReg1 := TRUE;

            end;

            trigger OnPreDataItem()
            begin
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration".Semester) <> '' THEN ERROR('Semester Filters are not allowed.');
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage) <> '' THEN ERROR('Stage Filters are not allowed.');
                CLEAR(yosInt);
                IF "ACA-Course Registration".GETFILTER("Academic Year") = '' THEN ERROR('Specify the academic year filter!');
                IF EVALUATE(yosInt, "ACA-Course Registration".GETFILTER("Year Of Study")) THEN;
                CReg.RESET;
                //CReg.SETRANGE("Yearly Remarks","ACA-Course Registration"."Yearly Remarks");
                CReg.SETRANGE("Academic Year", "ACA-Course Registration".GETFILTER("Academic Year"));
                IF "ACA-Course Registration".GETFILTER(Programmes) <> '' THEN
                    CReg.SETRANGE(Programmes, "ACA-Course Registration".GETFILTER(Programmes));
                IF yosInt <> 0 THEN
                    CReg.SETRANGE("Year Of Study", yosInt);
                //CReg.SETRANGE(Options,"ACA-Course Registration".GETFILTER(Options));
                CReg.SETFILTER("Yearly Total Units Taken", '>%1', 0);
                CReg.SETFILTER(Reversed, '%1', FALSE);
                CReg.SETFILTER("Yearly Remarks", '<>%1', '');
                IF CReg.FIND('-') THEN BEGIN
                    ACASenateReportCounts.RESET;
                    IF "ACA-Course Registration".GETFILTER(Programmes) <> '' THEN
                        ACASenateReportCounts.SETRANGE("Prog. Code", "ACA-Course Registration".GETFILTER(Programmes));
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
        UnitCodes: array[30] of Text[100];
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

        N: Integer;
        Grd: Code[20];
        Marks: Decimal;
        Dimensions2: Record 349;

        UnitsDesc: Text[100];
        UnitsHeader: Text[100];
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
        ACAResultsStatus: Record 61739;
        Msg0: Text[250];
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
        ResultsStatus3: Record 61739;
}

