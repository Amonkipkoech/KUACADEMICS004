report 66628 "Cummulative Failed Units"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Cummulative Failed Units.rdl';

    dataset
    {
        dataitem(StudentsClassification; 66630)
        {
            CalcFields = "Status Students Count";
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Graduation Academic Year", "School Code";
            column(ClassCode; StudentsClassification."Final Classification")
            {
            }
            column(GradAcademicYear; StudentsClassification."Graduation Academic Year")
            {
            }
            column(ProgCode; StudentsClassification.Programme)
            {
            }
            column(PassStatus; StudentsClassification."Final Classification Pass")
            {
            }
            column(PassStatusOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(ClassOrders; StudentsClassification."Final Classification Order")
            {
            }
            column(ClassOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(YearOfStudy; StudentsClassification."Year of Study")
            {
            }
            column(PassOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(Pics; CompInf.Picture)
            {
            }
            column(Compname; UPPERCASE(CompInf.Name))
            {
            }
            column(StatusOrderCompiled; StatusOrder)
            {
            }
            column(statusCompiled; statusCompiled)
            {
            }
            column(StatusCode; StudentsClassification."Final Classification")
            {
            }
            column(StatusDesc; ACAResultsStatus.Description)
            {
            }
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
            {
            }
            column(StatusOrder; StudentsClassification."Final Classification Order")
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
            column(YoS; StudentsClassification."Year of Study")
            {
            }
            column(AcadYear; StudentsClassification."Graduation Academic Year")
            {
            }
            column(YearOfStudyText; YearOfStudyText)
            {
            }
            column(NextYear; NextYear)
            {
            }
            column(SaltedExamStatusDesc; 'In the year ' + StudentsClassification."Graduation Academic Year" + ' ' + SaltedExamStatusDesc)
            {
            }
            column(SaltedExamStatus; SaltedExamStatus)
            {
            }
            column(YoSTexed; YoS)
            {
            }
            column(ExamStatus; StudentsClassification."Final Classification")
            {
            }
            column(Names; Cust.Name)
            {
            }
            column(StudNo; StudentsClassification."Student Number")
            {
            }
            column(Required; StudentsClassification."Required Stage Units")
            {
            }
            column(Attained; StudentsClassification."Attained Stage Units")
            {
            }
            column(Filtesr; StudentsClassification.GETFILTERS)
            {
            }
            dataitem(GradUnits; 66632)
            {
                DataItemLink = "Student No." = FIELD("Student Number"),
                               "Graduation Academic Year" = FIELD("Graduation Academic Year");
                DataItemTableView = WHERE(Pass = FILTER('No'));
                column(UnitCode; GradUnits."Unit Code")
                {
                }
                column(UnitDescription; GradUnits."Unit Description")
                {
                }
                column(CAtScore; GradUnits."CAT Score")
                {
                }
                column(ExamScore; GradUnits."Exam Score")
                {
                }
                column(TotalScore; GradUnits."Total Score")
                {
                }
                column(Grade; GradUnits.Grade)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(NextYear);
                CLEAR(YearOfStudyText);
                CLEAR(YoS);
                YoS := GetYearofStudyText(StudentsClassification."Year of Study");
                YearOfStudyText := YoS;
                CLEAR(IsaForthYear);
                IsaForthYear := TRUE;
                CLEAR(statusCompiled);
                // IsaForthYear:=ACACourseRegistration741."Is Final Year Student";
                // IF ((ACACourseRegistration741.Stage='Y4S1') OR (ACACourseRegistration741.Stage='Y4S2')) THEN
                //   IsaForthYear:=TRUE;
                // // CLEAR(StatusOrder);
                // // IF StudentsClassification."Final Classification Pass" = FALSE THEN BEGIN
                // // statusCompiled:='INCOMPLETE RESULTS LIST';
                // //  StatusOrder:=2;
                // //  END
                // // ELSE IF ClassHeader."Pass Status"<>'' THEN BEGIN
                // // statusCompiled:='CLASSIFICATION LIST';
                // //  StatusOrder:=1;
                // //  END;

                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(prog.Code, StudentsClassification.Programme);
                IF Prog.FIND('-') THEN BEGIN
                    progName := Prog.Description;
                END;

                //Get the Department
                CLEAR(FacDesc);
                CLEAR(facCode);
                FacDesc := StudentsClassification."School Name";
                facCode := StudentsClassification."School Code";


                CLEAR(SaltedExamStatus);
                CLEAR(SaltedExamStatusDesc);
                SaltedExamStatus := ACAResultsStatus.Code + facCode + Prog.Code +
                FORMAT(StudentsClassification."Year of Study") +
                StudentsClassification."Graduation Academic Year";
                CLEAR(NoOfStudents);
                CLEAR(NoOfStudentsDecimal);

                ACAResultsStatus.RESET;

                ACAResultsStatus.SETRANGE(ACAResultsStatus.Code, 'PASS');
                //SaltedExamStatusDesc:=ClassHeader.Msg1;
                CLEAR(NoOfStudentInText);
                StudentsClassification.CALCFIELDS("Status Students Count");
                NoOfStudents := StudentsClassification."Status Students Count";
                IF NoOfStudents <> 0 THEN NoOfStudentInText := ConvertDecimalToText.InitiateConvertion(NoOfStudents);
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    IF ACAResultsStatus."Include Class Variable 1" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + NoOfStudentInText + ' (' + FORMAT(NoOfStudents) + ') ' + ACAResultsStatus."Classification Msg2";
                    IF ACAResultsStatus."Include Class Variable 2" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc + ' ' + ACAResultsStatus."Classification Msg3";///+' '+progName+' '+Prog."Exam Category";
                    IF ACAResultsStatus."Include Class Variable 3" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg4";
                    //IF ACAResultsStatus."Include Class Variable 4" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+progName+' '+ClassHeader.Msg5;
                    // IF ACAResultsStatus."Include Class Variable 5" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc;//+' '+NextYear;
                    // IF ACAResultsStatus."Include Class Variable 6" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+ClassHeader.Msg6;
                    SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                END;

                Cust.RESET;
                Cust.SETRANGE(Cust."No.", StudentsClassification."Student Number");
                IF Cust.FIND('-') THEN;
            end;

            trigger OnPreDataItem()
            begin
                //ClassHeader.SETFILTER("User ID",USERID);
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
        ACACourseRegistration: Record 66630;
        ITmCourseReg: Record 66630;
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
        ACAStudentUnits: Record 66632;
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        StudUnits: Record 66632;
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
        CREG2: Record 66630;
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
        CReg33: Record 66630;
        CReg: Record 66630;
        yosInt: Integer;
        ACAUnitsSubjects: Record 61517;
        incounts: Integer;
    begin
        IF StudentsClassification.GETFILTER("Graduation Academic Year") = '' THEN ERROR('Missing Academic years Filter');
        IF StudentsClassification.GETFILTER("School Code") = '' THEN ERROR('Missing Faculty');
        // //
        // // ACAClassificationHeader.RESET;
        // // ACAClassificationHeader.SETRANGE("User ID",USERID);
        // // IF ACAClassificationHeader.FIND('-') THEN ACAClassificationHeader.DELETEALL;
        // //
        // // ACAClassificationDetails.RESET;
        // // ACAClassificationDetails.SETRANGE("User ID",USERID);
        // // IF ACAClassificationDetails.FIND('-') THEN ACAClassificationDetails.DELETEALL;
        // //
        // // Prog.RESET;
        // // Prog.SETRANGE("School Code",ClassHeader.GETFILTER(Faculty));
        // // IF Prog.FIND('-') THEN BEGIN
        // //  REPEAT
        // //    BEGIN
        // //    CLEAR(yosInt);
        // //    CLEAR(YoSComputed);
        // //  ACAProgrammeStages.RESET;
        // //  ACAProgrammeStages.SETRANGE("Programme Code",Prog.Code);
        // //  ACAProgrammeStages.SETRANGE("Final Stage",TRUE);
        // //  IF ACAProgrammeStages.FIND('-') THEN BEGIN
        // //      IF ((COPYSTR(ACAProgrammeStages.Code,2,1)) IN ['1','2','3','4','5','6','7']) THEN BEGIN
        // //        IF EVALUATE(YoSComputed,COPYSTR(ACAProgrammeStages.Code,2,1)) THEN BEGIN
        // // // Truth
        // // ACAClassGradRubrics.RESET;
        // // IF ACAClassGradRubrics.FIND('-') THEN BEGIN
        // //    REPEAT
        // //        BEGIN
        // //          ACAClassificationHeader.INIT;
        // //          ACAClassificationHeader."User ID":=USERID;
        // //          ACAClassificationHeader."Graduation Academic Year":=ClassHeader.GETFILTER("Graduation Academic Year");
        // //          ACAClassificationHeader."Classification Code":=ACAClassGradRubrics.Code;
        // //          ACAClassificationHeader."Classification Order":=ACAClassGradRubrics."Order No";
        // //          ACAClassificationHeader."Programme Code":=Prog.Code;
        // //          ACAClassificationHeader.Faculty:=ClassHeader.GETFILTER(Faculty);
        // //          IF ACAClassGradRubrics.Code='INCOMPLETE' THEN BEGIN
        // //          ACAClassificationHeader."Pass Status":='INCOMPLETE';
        // //          ACAClassificationHeader."Pass Status Order":=2;
        // //          END ELSE BEGIN
        // //          ACAClassificationHeader."Pass Status":='PASS';
        // //          ACAClassificationHeader."Pass Status Order":=1;
        // //          END;
        // //          ACAClassificationHeader."Year of Study":=YoSComputed;
        // //          ACAClassificationHeader."Year of Study Text":=GetYearofStudyText(YoSComputed);
        // //          ACAClassificationHeader.Msg1:=ACAClassGradRubrics."Classification Msg1";
        // //          ACAClassificationHeader.Msg2:=ACAClassGradRubrics."Classification Msg2";
        // //          ACAClassificationHeader.Msg3:=ACAClassGradRubrics."Classification Msg3";
        // //          ACAClassificationHeader.Msg4:=ACAClassGradRubrics."Classification Msg4";
        // //          ACAClassificationHeader.Msg5:=ACAClassGradRubrics."Classification Msg5";
        // //          ACAClassificationHeader.Msg6:=ACAClassGradRubrics."Classification Msg6";
        // //          ACAClassificationHeader."Final Year Comment":=ACAClassGradRubrics."Final Year Comment";
        // //         IF  ACAClassificationHeader.INSERT THEN;
        // //        END;
        // //      UNTIL ACAClassGradRubrics.NEXT=0;
        // //  END;
        // // CLEAR(ITmCourseReg);
        // // ITmCourseReg.RESET;
        // // ITmCourseReg.SETRANGE(Programme,Prog.Code);
        // // ITmCourseReg.SETRANGE("Graduation Academic Year",ClassHeader.GETFILTER("Graduation Academic Year"));
        // // IF ITmCourseReg.FIND('-') THEN  BEGIN
        // // //// Update Graduation Parameters
        // // REPEAT
        // //  BEGIN
        // // //////////////////..........................................................................
        // //
        // // ACAClassificationHeader.RESET;
        // // ACAClassificationHeader.SETRANGE("User ID",USERID);
        // // ACAClassificationHeader.SETRANGE("Programme Code",Prog.Code);
        // // ACAClassificationHeader.SETRANGE("Graduation Academic Year",ClassHeader.GETFILTER("Graduation Academic Year"));
        // // ACAClassificationHeader.SETRANGE("Classification Code",ITmCourseReg."Final Classification");
        // // IF ACAClassificationHeader.FIND('-') THEN;
        // // IF Cust.GET(ITmCourseReg."Student Number") THEN;
        // //
        // // ACAClassificationDetails.RESET;
        // // ACAClassificationDetails.SETRANGE("User ID",USERID);
        // // ACAClassificationDetails.SETRANGE("Programme Code",ITmCourseReg.Programme);
        // // ACAClassificationDetails.SETRANGE("Graduation Academic Year",ITmCourseReg."Graduation Academic Year");
        // // ACAClassificationDetails.SETRANGE("Student No.",ITmCourseReg."Student Number");
        // // IF NOT ACAClassificationDetails.FIND('-') THEN BEGIN
        // //
        // //          ACAClassificationDetails.INIT;
        // //          ACAClassificationDetails."User ID":=USERID;
        // //          ACAClassificationDetails."Graduation Academic Year":=ITmCourseReg."Graduation Academic Year";
        // //          ACAClassificationDetails."Classification Code":=ITmCourseReg."Final Classification";
        // //          ACAClassificationDetails."Programme Code":=ITmCourseReg.Programme;
        // //          ACAClassificationDetails.Faculty:=ClassHeader.GETFILTER(Faculty);
        // //          ACAClassificationDetails."Student No.":=ITmCourseReg."Student Number";
        // //       //   ACAClassificationDetails.
        // //          ACAClassificationDetails."Student Name":=Cust.Name;
        // //          IF ITmCourseReg."Final Classification"='INCOMPLETE' THEN BEGIN
        // //          ACAClassificationDetails."Pass Status":='INCOMPLETE';
        // //          END ELSE BEGIN
        // //          ACAClassificationDetails."Pass Status":='PASS';
        // //          END;
        // //          ACAClassificationDetails."Year of Study":=ITmCourseReg."Year of Study";
        // //          ACAClassificationDetails."Class Order":=ACAClassificationHeader."Classification Order";
        // //          IF ACAClassificationDetails."Classification Code"<>'' THEN ACAClassificationDetails.INSERT;
        // //  END ELSE BEGIN
        // //          ACAClassificationDetails."Classification Code":=ITmCourseReg."Final Classification";
        // //          IF ITmCourseReg."Final Classification"='INCOMPLETE' THEN BEGIN
        // //          ACAClassificationDetails."Pass Status":='INCOMPLETE';
        // //          END ELSE BEGIN
        // //          ACAClassificationDetails."Pass Status":='PASS';
        // //          END;
        // //          ACAClassificationDetails."Student Name":=Cust.Name;
        // //          ACAClassificationDetails."Year of Study":=ITmCourseReg."Year of Study";
        // //          ACAClassificationDetails."Class Order":=ACAClassificationHeader."Classification Order";
        // //          ACAClassificationDetails.MODIFY;
        // //    END;
        // //    END;
        // //    UNTIL ITmCourseReg.NEXT=0;
        // // END;
        // //      END;
        // //    END;
        // //  END;
        // //  END;
        // //  UNTIL Prog.NEXT=0;
        // //  END;
    end;

    var
        ACACourseRegistration741: Record 66631;
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
        StudUnits: Record 66632;
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

