report 66626 "Final Deans Classification 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Final Deans Classification 2.rdl';
    Caption = 'Graduation List';

    dataset
    {
        dataitem(StudentsClassification; 66630)
        {
            CalcFields = "Status Students Count", "Prog. Exam Category", "Programme Option", "Prog. Option Name";
            DataItemTableView = WHERE("Final Classification Pass" = FILTER('Yes'),
                                      "Final Classification" = FILTER(<> ''));
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
            column(SaltedExamStatusDesc; 'In the  ' + StudentsClassification."Graduation Academic Year" + '  Academic Year, ' + SaltedExamStatusDesc)
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
            column(ProgCat; StudentsClassification."Program Group Order")
            {
            }
            column(ProgrammeOption; StudentsClassification."Programme Option")
            {
            }
            column(OptName; StudentsClassification."Prog. Option Name")
            {
            }
            column(NotClassified; Prog."Not Classified")
            {
            }
            column(ShowOption; Prog."Show Options on Graduation")
            {
            }
            column(StudentNo; Cust."No.")
            {
            }
            column(CourseCatOrder; CourseCatOrder)
            {
            }
            column(CourseCat; Prog.Category)
            {
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
                CLEAR(progName);
                Prog.RESET;
                Prog.SETRANGE(prog.Code, StudentsClassification.Programme);
                IF Prog.FIND('-') THEN BEGIN
                    progName := Prog.Description;
                    CourseCatOrder := 1;
                    CourseCat := 'BARCHELORS';
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
                    IF ACAResultsStatus."Include Class Variable 1" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg1" + ' ' + NoOfStudentInText + ' (' + FORMAT(NoOfStudents) + ') ' + ACAResultsStatus."Classification Msg2";
                    IF ACAResultsStatus."Include Class Variable 2" THEN SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc;
                    IF StudentsClassification."Program Group Order" = 1 THEN
                        SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg3"
                    ELSE
                        IF StudentsClassification."Program Group Order" = 2 THEN
                            SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg4"
                        ELSE
                            IF StudentsClassification."Program Group Order" = 3 THEN
                                SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg5";
                    //IF ACAResultsStatus."Include Class Variable 3" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+ACAResultsStatus."Classification Msg4";
                    //IF ACAResultsStatus."Include Class Variable 4" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+progName+' '+ClassHeader.Msg5;
                    // IF ACAResultsStatus."Include Class Variable 5" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc;//+' '+NextYear;
                    // IF ACAResultsStatus."Include Class Variable 6" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+ClassHeader.Msg6;
                    SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                END;

                Cust.RESET;
                Cust.SETRANGE(Cust."No.", StudentsClassification."Student Number");
                IF Cust.FIND('-') THEN;

                IF StudentsClassification."Final Classification" = 'DISTINCTION' THEN
                    StudentsClassification."Final Classification Order" := 1
                ELSE
                    IF StudentsClassification."Final Classification" = 'CREDIT' THEN StudentsClassification."Final Classification Order" := 2;

                IF StudentsClassification."Programme Option" <> '' THEN BEGIN
                    IF StudentsClassification."Prog. Option Name" = '' THEN StudentsClassification."Prog. Option Name" := StudentsClassification."Programme Option";
                    StudentsClassification."Prog. Option Name" := StudentsClassification."Prog. Option Name" + ' Option';
                END;
                IF Prog."Show Options on Graduation" = FALSE THEN BEGIN
                    StudentsClassification."Programme Option" := '';
                    StudentsClassification."Prog. Option Name" := '';
                END;
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
        ACASenateReportStatusBuff: Record 77718 temporary;
        CurrNo: Integer;
        YoS: Code[20];
        yosInt: Integer;
        ACAUnitsSubjects: Record 61517;
        ReoderElement: Code[10];
        ProgCat: Code[10];
        CourseCatOrder: Integer;
        CourseCat: Code[50];

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
        FormerCommonName: Text[250];
        OneSpaceFound: Boolean;
        Countings: Integer;
    begin
        CLEAR(OneSpaceFound);
        CLEAR(Countings);
        NewName := CommonName;
        CommonName := CONVERTSTR(CommonName, ',', ' ');
        FormerCommonName := '';
        REPEAT
        BEGIN
            Countings += 1;
            IF COPYSTR(CommonName, Countings, 1) = ' ' THEN BEGIN
                IF OneSpaceFound = FALSE THEN FormerCommonName := FormerCommonName + COPYSTR(CommonName, Countings, 1);
                OneSpaceFound := TRUE
            END ELSE BEGIN
                OneSpaceFound := FALSE;
                FormerCommonName := FormerCommonName + COPYSTR(CommonName, Countings, 1)
            END;
        END;
        UNTIL Countings = STRLEN(CommonName);
        CommonName := FormerCommonName;
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
