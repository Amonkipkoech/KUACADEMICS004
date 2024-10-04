report 66612 "Final GraduationList"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Final GraduationList.rdl';

    dataset
    {
        dataitem(ClassHeader; 66612)
        {
            CalcFields = "Pass Status Count", "Total Number of Students";
            DataItemTableView = WHERE("Pass Status" = FILTER('PASS'),
                                      "Pass Status Count" = FILTER(> 0),
                                      "Classification Count" = FILTER(> 0));
            RequestFilterFields = "Graduation Academic Year", "Programme Code";
            column(ClassCode; ClassHeader."Classification Code")
            {
            }
            column(GradAcademicYear; ClassHeader."Graduation Academic Year")
            {
            }
            column(ProgCode; ClassHeader."Programme Code")
            {
            }
            column(PassStatus; ClassHeader."Pass Status")
            {
            }
            column(PassStatusOrder; ClassHeader."Pass Status Order")
            {
            }
            column(ClassOrders; ClassHeader."Classification Order")
            {
            }
            column(YearOfStudy; ClassHeader."Year of Study")
            {
            }
            column(PassCount; ClassHeader."Pass Status Count")
            {
            }
            column(PassOrder; ClassHeader."Pass Status Order")
            {
            }
            column(ClassCount; ClassHeader."Classification Count")
            {
            }
            column(ClassOrder; ClassHeader."Classification Order")
            {
            }
            column(TotalNumber; ClassHeader."Total Number of Students")
            {
            }
            column(Users; ClassHeader."User ID")
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
            column(StatusCode; ClassHeader."Classification Code")
            {
            }
            column(StatusDesc; ACAResultsStatus.Description)
            {
            }
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
            {
            }
            column(StatusOrder; ClassHeader."Classification Order")
            {
            }
            column(StatCodes; ACAResultsStatus.Code)
            {
            }
            column(ApprovalsClaimer; 'Approved by the board of the Examiners of the  ' + FacDesc + ' at a meeting held on:')
            {
            }
            column(ProgName; progName)
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; ClassHeader."Year of Study")
            {
            }
            column(AcadYear; ClassHeader."Graduation Academic Year")
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
            column(YoSTexed; YoS)
            {
            }
            column(ExamStatus; ClassHeader."Classification Code")
            {
            }
            dataitem(ClassDet2; 66613)
            {
                DataItemLink = "User ID" = FIELD("User ID"),
                              "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                               "Year of Study" = FIELD("Year of Study"),
                               "Programme Code" = FIELD("Programme Code"),
                               "Classification Code" = FIELD("Classification Code");
                DataItemTableView = SORTING("Student Name", "Pass Status")
                                    ORDER(Ascending)
                                    WHERE("Programme Code" = FILTER(<> ''),
                                          "Graduation Academic Year" = FILTER(<> ''),
                                          "Classification Code" = FILTER(<> ''),
                                          "Pass Status" = FILTER('PASS'));
                column(RegNo; ClassDet2."Student No.")
                {
                }
                column(ReoderElement; ReoderElement)
                {
                }
                column(Names; FormatNames(Names))
                {
                }
                column(Compname; UPPERCASE(CompInf.Name))
                {
                }
                column(RegTrans; ACACourseRegistration741."Reg. Transacton ID")
                {
                }
                column(StudNo; ClassDet2."Student No.")
                {
                }
                column(Progs; ACACourseRegistration741.Programmes)
                {
                }
                column(Sems; ACACourseRegistration741.Semester)
                {
                }
                column(RegFor; ACACourseRegistration741."Register for")
                {
                }
                column(CourseStage; ACACourseRegistration741.Stage)
                {
                }
                column(Units; ACACourseRegistration741.Unit)
                {
                }
                column(StudType; ACACourseRegistration741."Settlement Type")
                {
                }
                column(EntryNo; ACACourseRegistration741."Reg. Transacton ID")
                {
                }
                column(CampusCode; ACACourseRegistration741."Campus Code")
                {
                }
                column(FailedUnits; ACACourseRegistration741."Failed Unit")
                {
                }
                column(GraduationGroup; ACACourseRegistration741."Graduation Group")
                {
                }
                column(counts; ClassDet2."Graduation Serial")
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
                column(YoA; ACACourseRegistration741."Year of Admission")
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

                trigger OnAfterGetRecord()
                var
                    ACADGradStudPresidence: Record 66600;
                begin
                    ACACourseRegistration741.RESET;
                    ACACourseRegistration741.SETRANGE("Student No.", ClassDet2."Student No.");
                    ACACourseRegistration741.SETRANGE("Graduation Academic Year", ClassDet2."Graduation Academic Year");
                    ACACourseRegistration741.SETRANGE("Year Of Study", ClassDet2."Year of Study");
                    ACACourseRegistration741.SETRANGE("programmes", ClassDet2."Programme Code");
                    IF ACACourseRegistration741.FIND('-') THEN;
                    CLEAR(SpecialUnitReg);

                    IF Cust.GET(ACACourseRegistration741."Student No.") THEN;
                    Names := Cust.Name;
                    RegNo := ACACourseRegistration741."Student No.";
                    CLEAR(ReoderElement);
                    ReoderElement := COPYSTR(ClassDet2."Student No.", STRLEN(ClassDet2."Student No.") - 2, 3);
                end;

                trigger OnPreDataItem()
                var
                    ACADGradStudPresidence: Record 66600;
                begin
                    CLEAR(yosInt);


                    yosInt := ClassHeader."Year of Study";
                    ClassDet2.SETFILTER("User ID", USERID);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(NextYear);
                CLEAR(YearOfStudyText);
                CLEAR(YoS);
                YoS := ClassHeader."Year of Study Text";
                YearOfStudyText := ClassHeader."Year of Study Text";
                // // IF ClassHeader."Year Of Study"<>0 THEN BEGIN
                // //  IF ClassHeader."Year Of Study"=1 THEN BEGIN
                // //    YearOfStudyText:='First Year (1)';
                // //    YoS:='FIRST';
                // //    IF ClassHeader."Yearly Failed Units"=0 THEN NextYear:='SECOND'
                // //     ELSE NextYear:='FIRST';
                // //  END ELSE IF ClassHeader."Year Of Study"=2 THEN BEGIN
                // //    YearOfStudyText:='Second Year (2)';
                // //    YoS:='SECOND';
                // //    IF ClassHeader."Yearly Failed Units"=0 THEN NextYear:='THIRD'
                // //     ELSE NextYear:='THIRD';
                // //  END ELSE IF ClassHeader."Year Of Study"=3 THEN BEGIN
                // //    YearOfStudyText:='Third Year (3)';
                // //    YoS:='THIRD';
                // //    IF ClassHeader."Yearly Failed Units"=0 THEN NextYear:='FOURTH'
                // //     ELSE NextYear:='THIRD';
                // //  END ELSE IF ClassHeader."Year Of Study"=4 THEN BEGIN
                // //    YearOfStudyText:='Fourth Year (4)';
                // //    YoS:='FOURTH';
                // //   NextYear:='FOUR';
                // //    END;
                // //  END;
                CLEAR(IsaForthYear);
                IsaForthYear := TRUE;
                CLEAR(statusCompiled);
                // IsaForthYear:=ACACourseRegistration741."Is Final Year Student";
                // IF ((ACACourseRegistration741.Stage='Y4S1') OR (ACACourseRegistration741.Stage='Y4S2')) THEN
                //   IsaForthYear:=TRUE;
                CLEAR(StatusOrder);
                IF ClassHeader."Pass Status" = 'INCOMPLETE' THEN BEGIN
                    statusCompiled := 'INCOMPLETE RESULTS LIST';
                    StatusOrder := 2;
                END
                ELSE
                    IF ClassHeader."Pass Status" <> '' THEN BEGIN
                        statusCompiled := 'CLASSIFICATION LIST';
                        StatusOrder := 1;
                    END;

                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(prog.code, ClassHeader."Programme Code");
                IF Prog.FIND('-') THEN BEGIN
                    progName := Prog.Description;
                END;

                //Get the Department
                CLEAR(FacDesc);
                CLEAR(facCode);
                FacDesc := '';
                Prog.RESET;
                Prog.SETRANGE(Prog.Code, "Programme Code");
                Prog.SETFILTER(prog."School Code", '<>%1', '');
                IF Prog.FIND('-') THEN BEGIN
                    Dimensions2.RESET;
                    Dimensions2.SETRANGE(Dimensions2."Dimension Code", 'FACULTY');
                    //Dimensions2.SETRANGE(Prog."School Code");
                    IF Dimensions2.FIND('-') THEN BEGIN
                        FacDesc := Dimensions2.Name;
                        facCode := Dimensions2.Code;
                    END;
                END;

                CLEAR(SaltedExamStatus);
                CLEAR(SaltedExamStatusDesc);
                SaltedExamStatus := ACAResultsStatus.Code + facCode + Prog.Code +
                FORMAT(ClassHeader."Year of Study") +
                ClassHeader."Graduation Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Code, ClassHeader."Classification Code");
                SaltedExamStatusDesc := ClassHeader.Msg1;
                CLEAR(NoOfStudentInText);
                NoOfStudents := ClassHeader."Pass Status Count";
                IF NoOfStudents <> 0 THEN NoOfStudentInText := ConvertDecimalToText.InitiateConvertion(NoOfStudents);
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Class Variable 1" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + NoOfStudentInText + ' (' + FORMAT(NoOfStudents) + ') ' + ClassHeader.Msg2;
                    IF ACAResultsStatus."Include Class Variable 2" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc + ' ' + ClassHeader.Msg3 + ' ' + progName + ' ' + Prog."Exam Category";
                    IF ACAResultsStatus."Include Class Variable 3" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ClassHeader.Msg4;
                    IF ACAResultsStatus."Include Class Variable 4" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + progName + ' ' + ClassHeader.Msg5;
                    IF ACAResultsStatus."Include Class Variable 5" THEN SaltedExamStatusDesc := SaltedExamStatusDesc;//+' '+NextYear;
                    IF ACAResultsStatus."Include Class Variable 6" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ClassHeader.Msg6;
                    SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                END;
            end;

            trigger OnPreDataItem()
            begin
                ClassHeader.SETFILTER("User ID", USERID);
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

    trigger OnPreReport()
    var
        ACAGraduationReportPicker: Record 66610;
        GradAcdYear: Code[1024];
        YearOfStudy: Option " ","1","2","3","4","5","6","7";
        ProgFilters: Code[1024];
        ACACourseRegistration: Record 61532;
        ITmCourseReg: Record 61532;
        ACAProgramme: Record 61511;
        ACAProgrammeStages: Record 61516;
        YoSComputed: Integer;
        ACAClassificationHeader: Record 66612;
        ACAClassificationDetails: Record 66613;
        ACAClassificationDetails2: Record 66613;
        ACAClassGradRubrics: Record 78011;
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
        CReg33: Record 61532;
        CReg: Record 61532;
        yosInt: Integer;
        ACAUnitsSubjects: Record 61517;
        incounts: Integer;
    begin
        IF ClassHeader.GETFILTER("Graduation Academic Year") = '' THEN ERROR('Missing Academic years Filter');
        IF ClassHeader.GETFILTER("Programme Code") = '' THEN ERROR('Missing Program Filter');
        IF ClassHeader.GETFILTER(Faculty) <> '' THEN ERROR('School Filter is not allowed on this report');

        ACACourseRegistration.RESET;
        ACAClassificationHeader.RESET;
        IF ClassHeader.GETFILTER("Graduation Academic Year") <> '' THEN BEGIN
            ACAClassificationHeader.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
            ACACourseRegistration.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
        END;
        IF ClassHeader.GETFILTER("Programme Code") <> '' THEN BEGIN
            ACACourseRegistration.SETRANGE(Programmes, ClassHeader.GETFILTER("Programme Code"));
            ACAClassificationHeader.SETRANGE("Programme Code", ClassHeader.GETFILTER("Programme Code"));
            ACAProgrammeStages.RESET;
            ACAProgrammeStages.SETRANGE("Programme Code", ClassHeader.GETFILTER("Programme Code"));
            ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
            IF ACAProgrammeStages.FIND('+') THEN BEGIN
                CLEAR(yosInt);
                IF EVALUATE(yosInt, COPYSTR(ACAProgrammeStages.Code, 2, 1)) THEN BEGIN
                    ACAClassificationHeader.SETRANGE("Year of Study", yosInt);
                    ACACourseRegistration.SETRANGE("Year Of Study", yosInt);
                END;
            END;
        END;
        IF ACACourseRegistration.FIND('-') THEN;
        IF ACAClassificationHeader.FIND('-') THEN;
        CLEAR(YoSComputed);
        Prog.RESET;
        Prog.SETRANGE(Code, ClassHeader.GETFILTER("Programme Code"));
        IF Prog.FIND('-') THEN BEGIN
            ACAProgrammeStages.RESET;
            ACAProgrammeStages.SETRANGE("Programme Code", Prog.Code);
            ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
            IF ACAProgrammeStages.FIND('-') THEN BEGIN
                IF ((COPYSTR(ACAProgrammeStages.Code, 2, 1)) IN ['1', '2', '3', '4', '5', '6', '7']) THEN
                    EVALUATE(YoSComputed, COPYSTR(ACAProgrammeStages.Code, 2, 1))
                ELSE
                    ERROR('Final Stage of study has an invalid format!');
            END ELSE
                ERROR('Programme last stage is not defined!');
        END ELSE
            ERROR('Programme not Found!');


        ClassHeader.SETFILTER("Year of Study", '%1', YoSComputed);
        ClassHeader.SETFILTER("User ID", USERID);
        ACAClassificationHeader.RESET;
        ACAClassificationHeader.SETRANGE("User ID", USERID);
        ACAClassificationHeader.SETRANGE("Programme Code", ClassHeader.GETFILTER("Programme Code"));
        ACAClassificationHeader.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
        IF ACAClassificationHeader.FIND('-') THEN ACAClassificationHeader.DELETEALL;
        ACAClassificationDetails.RESET;
        ACAClassificationDetails.SETRANGE("User ID", USERID);
        ACAClassificationDetails.SETRANGE("Programme Code", ClassHeader.GETFILTER("Programme Code"));
        ACAClassificationDetails.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
        IF ACAClassificationDetails.FIND('-') THEN ACAClassificationDetails.DELETEALL;
        ACAClassGradRubrics.RESET;
        IF ACAClassGradRubrics.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                ACAClassificationHeader.INIT;
                ACAClassificationHeader."User ID" := USERID;
                ACAClassificationHeader."Graduation Academic Year" := ClassHeader.GETFILTER("Graduation Academic Year");
                ACAClassificationHeader."Classification Code" := ACAClassGradRubrics.Code;
                ACAClassificationHeader."Classification Order" := ACAClassGradRubrics."Order No";
                ACAClassificationHeader."Programme Code" := ClassHeader.GETFILTER("Programme Code");
                IF ACAClassGradRubrics.Code = 'INCOMPLETE' THEN BEGIN
                    ACAClassificationHeader."Pass Status" := 'INCOMPLETE';
                    ACAClassificationHeader."Pass Status Order" := 2;
                END ELSE BEGIN
                    ACAClassificationHeader."Pass Status" := 'PASS';
                    ACAClassificationHeader."Pass Status Order" := 1;
                END;
                ACAClassificationHeader."Year of Study" := YoSComputed;
                ACAClassificationHeader."Year of Study Text" := GetYearofStudyText(YoSComputed);
                ACAClassificationHeader.Msg1 := ACAClassGradRubrics."Classification Msg1";
                ACAClassificationHeader.Msg2 := ACAClassGradRubrics."Classification Msg2";
                ACAClassificationHeader.Msg3 := ACAClassGradRubrics."Classification Msg3";
                ACAClassificationHeader.Msg4 := ACAClassGradRubrics."Classification Msg4";
                ACAClassificationHeader.Msg5 := ACAClassGradRubrics."Classification Msg5";
                ACAClassificationHeader.Msg6 := ACAClassGradRubrics."Classification Msg6";
                ACAClassificationHeader."Final Year Comment" := ACAClassGradRubrics."Final Year Comment";
                ACAClassificationHeader.INSERT;
            END;
            UNTIL ACAClassGradRubrics.NEXT = 0;
        END;
        CLEAR(ITmCourseReg);
        ITmCourseReg.RESET;
        ITmCourseReg.SETFILTER(Status, '%1|%2|%3', ITmCourseReg.Status::Current, ITmCourseReg.Status::Registration, ITmCourseReg.Status::Deceased);
        ITmCourseReg.SETRANGE(Programmes, ClassHeader.GETFILTER("Programme Code"));
        ITmCourseReg.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
        ITmCourseReg.SETRANGE(ITmCourseReg.Reversed, FALSE);
        ITmCourseReg.SETRANGE(ITmCourseReg."Year Of Study", YoSComputed);
        // ITmCourseReg.COPYFILTERS(ACACourseRegistration);
        IF ITmCourseReg.FIND('-') THEN BEGIN
            // // // // // IF ACACourseRegistration.FIND('-') THEN BEGIN
            // // // // //    REPORT.RUN(66610,FALSE,FALSE,ACACourseRegistration);
            // // // // //  END;
            //// Update Graduation Parameters
            REPEAT
            BEGIN
                // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Special Exam Exists");
                // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Passed Units",ITmCourseReg."Supp. Yearly Failed Units");
                // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Total Units Taken",ITmCourseReg."Is Final Year Student",
                // // // ITmCourseReg."Graduation Status Count");
                //////////////////..........................................................................

                ACAClassificationHeader.RESET;
                ACAClassificationHeader.SETRANGE("User ID", USERID);
                ACAClassificationHeader.SETRANGE("Programme Code", ClassHeader.GETFILTER("Programme Code"));
                ACAClassificationHeader.SETRANGE("Graduation Academic Year", ClassHeader.GETFILTER("Graduation Academic Year"));
                ACAClassificationHeader.SETRANGE("Classification Code", ITmCourseReg."Final Clasification");
                IF ACAClassificationHeader.FIND('-') THEN;
                IF Cust.GET(ITmCourseReg."Student No.") THEN;

                ACAClassificationDetails.RESET;
                ACAClassificationDetails.SETRANGE("User ID", USERID);
                ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.Programmes);
                ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg."Graduation Academic Year");
                ACAClassificationDetails.SETRANGE("Student No.", ITmCourseReg."Student No.");
                IF NOT ACAClassificationDetails.FIND('-') THEN BEGIN

                    ACAClassificationDetails.INIT;
                    ACAClassificationDetails."User ID" := USERID;
                    ACAClassificationDetails."Graduation Academic Year" := ITmCourseReg."Graduation Academic Year";
                    ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                    ACAClassificationDetails."Programme Code" := ITmCourseReg.Programmes;
                    ACAClassificationDetails."Student No." := ITmCourseReg."Student No.";
                    ACAClassificationDetails."Student Name" := Cust.Name;
                    IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                        ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                    END ELSE BEGIN
                        ACAClassificationDetails."Pass Status" := 'PASS';
                    END;
                    ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                    ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                    IF ACAClassificationDetails."Classification Code" <> '' THEN ACAClassificationDetails.INSERT;
                END ELSE BEGIN
                    ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                    IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                        ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                    END ELSE BEGIN
                        ACAClassificationDetails."Pass Status" := 'PASS';
                    END;
                    ACAClassificationDetails."Student Name" := Cust.Name;
                    ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                    ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                    ACAClassificationDetails.MODIFY;
                END;
            END;
            UNTIL ITmCourseReg.NEXT = 0;
        END;
        //Update Serials
        /*
              CLEAR(incounts);
                ACAClassificationDetails.RESET;
                ACAClassificationDetails.SETRANGE("User ID",USERID);
                ACAClassificationDetails.SETRANGE("Programme Code",ClassHeader.GETFILTER("Programme Code"));
                ACAClassificationDetails.SETRANGE("Graduation Academic Year",ClassHeader.GETFILTER("Graduation Academic Year"));
                ACAClassificationDetails.SETRANGE("Pass Status",'PASS');
                ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student Name",ACAClassificationDetails."Pass Status",
                ACAClassificationDetails."Classification Code",ACAClassificationDetails."Class Order");
                IF ACAClassificationDetails.FIND('-') THEN BEGIN
                  CLEAR(incounts);
                  REPEAT
                    BEGIN
                     incounts+=1;
                     ACAClassificationDetails."Graduation Serial":=incounts;
                     ACAClassificationDetails.MODIFY;
                    END;
                    UNTIL ACAClassificationDetails.NEXT=0;
                  END;
        
        ACAClassificationHeader.RESET;
        ACAClassificationHeader.SETRANGE("User ID",USERID);
        ACAClassificationHeader.SETRANGE("Programme Code",ClassHeader.GETFILTER("Programme Code"));
        ACAClassificationHeader.SETRANGE("Graduation Academic Year",ClassHeader.GETFILTER("Graduation Academic Year"));
        IF ACAClassificationHeader.FIND('-') THEN BEGIN
            REPEAT
              BEGIN//Updating Graduation Numbering
                  /// Update Classification Numbering
              CLEAR(incounts);
                ACAClassificationDetails.RESET;
                ACAClassificationDetails.SETRANGE("User ID",USERID);
                ACAClassificationDetails.SETRANGE("Programme Code",ClassHeader.GETFILTER("Programme Code"));
                ACAClassificationDetails.SETRANGE("Graduation Academic Year",ClassHeader.GETFILTER("Graduation Academic Year"));
                ACAClassificationDetails.SETRANGE("Classification Code",ACAClassificationHeader."Classification Code");
                ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student No.",ACAClassificationDetails."Classification Code");
                IF ACAClassificationDetails.FIND('-') THEN BEGIN
                  REPEAT
                    BEGIN
                     incounts+=1;
                     ACAClassificationDetails."Classification Serial":=incounts;
                     ACAClassificationDetails.MODIFY;
                    END;
                    UNTIL ACAClassificationDetails.NEXT=0;
                  END;
        
              END;
                UNTIL ACAClassificationHeader.NEXT=0;
          END;
          */

    end;

    var
        ACACourseRegistration741: Record 61532;
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
        ACAResultsStatus: Record 78011;
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        ACASenateReportStatusBuff: Record 77718;
        CurrNo: Integer;
        YoS: Code[20];
        yosInt: Integer;
        ACAUnitsSubjects: Record 61517;
        ReoderElement: Code[10];


    local procedure GetYearofStudyText(Yos: Integer) YosText: Text[150]
    begin
        CLEAR(YosText);
        IF Yos = 1 THEN YosText := 'FIRST';
        IF Yos = 2 THEN YosText := 'SECOND';
        IF Yos = 3 THEN YosText := 'THIRD';
        IF Yos = 4 THEN YosText := 'FORTH';
        IF Yos = 5 THEN YosText := 'FIFTH';
        IF Yos = 6 THEN YosText := 'SIXTH';
        IF Yos = 7 THEN YosText := 'SEVENTH';
    end;

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

