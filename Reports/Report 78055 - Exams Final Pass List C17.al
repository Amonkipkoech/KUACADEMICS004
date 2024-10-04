report 78055 "Exams Final Pass List C17"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exams Final Pass List C17.rdl';

    dataset
    {
        dataitem(SenateHeaders; 66654)
        {
            CalcFields = School_AcadYearTrans_Count, School_AcadYear_Count, School_AcadYear_Status_Count, SchCat_AcadYear_BarcCo, SchCat_AcadYear_Status_BarcCo, SchCat_AcadYearTrans_BarcCo, SchCat_AcadYear_MasCo, SchCat_AcadYear_Status_MasCo, SchCat_AcadYearTrans_MascCo, SchCat_AcadYear_DipCo, SchCat_AcadYear_Status_DipCo, SchCat_AcadYearTrans_DipCo, SchCat_AcadYear_CertCo, SchCat_AcadYear_Status_CertCo, SchCat_AcadYearTrans_CertCo, "School Classification Count", Category;
            DataItemTableView = SORTING("Programme Code", "Academic Year", "Year of Study")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Academic Year", "School Code", "Year of Study", Category;
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ',' + CompanyInformation.City)
            {
            }
            column(Phones; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(pics; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(YoSText; YoSText + ' YEAR')
            {
            }
            column(ProgCategory; SenateHeaders.Category)
            {
            }
            column(School_AcadYear_Status_Count; SenateHeaders.School_AcadYear_Status_Count)
            {
            }
            column(School_AcadYear_Count; SenateHeaders.School_AcadYear_Count)
            {
            }
            column(StatusPercentage; StatusPercentage)
            {
            }
            column(TransRate; TransRate)
            {
            }
            column(Transition; SenateHeaders.School_AcadYearTrans_Count)
            {
            }
            column(BarcCo; SenateHeaders.SchCat_AcadYear_BarcCo)
            {
            }
            column(Status_BarcCo; SenateHeaders.SchCat_AcadYear_Status_BarcCo)
            {
            }
            column(Trans_BarcCo; SenateHeaders.SchCat_AcadYearTrans_BarcCo)
            {
            }
            column(TransRateBarch; TransRateBarch)
            {
            }
            column(ShowRateBarch; ShowRateBarch)
            {
            }
            column(StatusPercentageBarchelors; StatusPercentageBarchelors)
            {
            }
            column(MasCo; SenateHeaders.SchCat_AcadYear_MasCo)
            {
            }
            column(Status_MasCo; SenateHeaders.SchCat_AcadYear_Status_MasCo)
            {
            }
            column(Trans_MascCo; SenateHeaders.SchCat_AcadYearTrans_MascCo)
            {
            }
            column(TransRateMasters; TransRateMasters)
            {
            }
            column(ShowRateMasters; ShowRateMasters)
            {
            }
            column(StatusPercentageMasters; StatusPercentageMasters)
            {
            }
            column(DipCo; SenateHeaders.SchCat_AcadYear_DipCo)
            {
            }
            column(Status_DipCo; SenateHeaders.SchCat_AcadYear_Status_DipCo)
            {
            }
            column(Trans_DipCo; SenateHeaders.SchCat_AcadYearTrans_DipCo)
            {
            }
            column(TransRateDiploma; TransRateDiploma)
            {
            }
            column(ShowRateDiploma; ShowRateDiploma)
            {
            }
            column(StatusPercentageDiploma; StatusPercentageDiploma)
            {
            }
            column(CertCo; SenateHeaders.SchCat_AcadYear_CertCo)
            {
            }
            column(Status_CertCo; SenateHeaders.SchCat_AcadYear_Status_CertCo)
            {
            }
            column(Trans_CertCo; SenateHeaders.SchCat_AcadYearTrans_CertCo)
            {
            }
            column(TransRateCertificate; TransRateCertificate)
            {
            }
            column(ShowRateCertificate; ShowRateCertificate)
            {
            }
            column(StatusPercentageCert; StatusPercentageCert)
            {
            }
            dataitem(ExamsCoreg; 66651)
            {
                DataItemLink = Programme = FIELD("Programme Code"),
                               "School Code" = FIELD("School Code"),
                               "Academic Year" = FIELD("Academic Year"),
                               Classification = FIELD("Classification Code"),
                               "Year of Study" = FIELD("Year of Study");
                DataItemTableView = SORTING(Programme, "Programme Option", "Student Number", "Category Order")
                                    ORDER(Ascending);
                column(ProgOptions; ExamsCoreg."Programme Option")
                {
                }
                column(CatOrder; ExamsCoreg."Category Order")
                {
                }
                column(seqSequence; ExamsCoreg."Rubric Number")
                {
                }
                column(seq; ExamsCoreg."Record Count")
                {
                }
                column(SchNames; ExamsCoreg."School Name")
                {
                }
                column(ProgNames; ACAProgramme.Description)
                {
                }
                column(DisplAyOrder; DisplAyOrder)
                {
                }
                column(FinalTexts; FinalTexts)
                {
                }
                column(ShowRate; ShowRate)
                {
                }
                column(Messages1; ACAResultsStatusez."Grad. Status Msg 1")
                {
                }
                column(Messages2; ACAResultsStatusez."Grad. Status Msg 2")
                {
                }
                column(Messages3; ACAResultsStatusez."Grad. Status Msg 3")
                {
                }
                column(Messages4; ACAResultsStatusez."Grad. Status Msg 4")
                {
                }
                column(Messages5; ACAResultsStatusez."Grad. Status Msg 5")
                {
                }
                column(Messages6; ACAResultsStatusez."Grad. Status Msg 6")
                {
                }
                column(RubAcadYear; RubAcadYear)
                {
                }
                column(RubNumberText; RubNumberText)
                {
                }
                column(Schoolz; Schoolz)
                {
                }
                column(YearText2; YearText2)
                {
                }
                column(AcadYear; SenateHeaders."Academic Year")
                {
                }
                column(SchCode; SenateHeaders."School Code")
                {
                }
                column(ClassificationCode; SenateHeaders."Classification Code")
                {
                }
                column(ProgCode; SenateHeaders."Programme Code")
                {
                }
                column(DeptCode; SenateHeaders."Department Code")
                {
                }
                column(SchPerc_Passed; SenateHeaders."School % Passed")
                {
                }
                column(SchPerc_Failed; SenateHeaders."School % Failed")
                {
                }
                column(ClassCaption; SenateHeaders."Calss Caption")
                {
                }
                column(ProgPerc_Passed; SenateHeaders."Programme % Passed")
                {
                }
                column(ProgPerc_Failed; SenateHeaders."Programme % Failed")
                {
                }
                column(ProgClassPerc_Value; SenateHeaders."Prog. Class % Value")
                {
                }
                column(SchClassPerc_Value; SenateHeaders."Sch. Class % Value")
                {
                }
                column(SummaryPageCaption; SenateHeaders."Summary Page Caption")
                {
                }
                column(INCLUDEfailedUnitsHeader; SenateHeaders."Include Failed Units Headers")
                {
                }
                column(RubricOrder; SenateHeaders."Rubric Order")
                {
                }
                column(SchClassCount; IntCount)
                {
                }
                column(SchClassCountText; ConvertDecimalToText.InitiateConvertion(SenateHeaders."School Classification Count"))
                {
                }
                column(SchTotPassed; SenateHeaders."School Total Passed")
                {
                }
                column(SchTotFailed; SenateHeaders."School Total Failed")
                {
                }
                column(ProgClassCount; SenateHeaders."Programme Classification Count")
                {
                }
                column(ProgTotPassed; SenateHeaders."Programme Total Passed")
                {
                }
                column(ProgTotFailed; SenateHeaders."Programme Total Failed")
                {
                }
                column(SchTotal; SenateHeaders."School Total Count")
                {
                }
                column(ProgTotal; SenateHeaders."Prog. Total Count")
                {
                }
                column(IncludeYear; SenateHeaders."Include Academic Year Caption")
                {
                }
                column(YearText; SenateHeaders."Academic Year Text")
                {
                }
                column(IncludeVar1; SenateHeaders."IncludeVariable 1")
                {
                }
                column(Var1; SenateHeaders."Status Msg1")
                {
                }
                column(IncludeVar2; SenateHeaders."IncludeVariable 2")
                {
                }
                column(Var2; SenateHeaders."Status Msg2")
                {
                }
                column(IncludeVar3; SenateHeaders."IncludeVariable 3")
                {
                }
                column(Var3; SenateHeaders."Status Msg3")
                {
                }
                column(IncludeVar4; SenateHeaders."IncludeVariable 4")
                {
                }
                column(Var4; Var4s)
                {
                }
                column(IncludeVar5; SenateHeaders."IncludeVariable 5")
                {
                }
                column(Var5; Var5s)
                {
                }
                column(IncludeVar6; SenateHeaders."IncludeVariable 6")
                {
                }
                column(Var6; '')
                {
                }
                column(StudentNo; ExamsCoreg."Student Number")
                {
                }
                column(YoS; ExamsCoreg."Year of Study")
                {
                }
                column(StudentName; ExamsCoreg."Student Name")
                {
                }
                column(SnchName; ExamsCoreg."School Name")
                {
                }
                column(Classification; ExamsCoreg.Classification)
                {
                }
                column(FinalClassPass; ExamsCoreg."Final Classification Pass")
                {
                }
                column(Graduating; ExamsCoreg.Graduating)
                {
                }
                column(ProgOptName; ExamsCoreg."Prog. Option Name")
                {
                }
                dataitem(ResitUnits; 66650)
                {
                    DataItemLink = "Student No." = FIELD("Student Number"),
                                   "Academic Year" = FIELD("Academic Year"),
                                   Programme = FIELD(Programme);
                    DataItemTableView = WHERE(Pass = FILTER(false));
                    column(UnitCode; ResitUnits."Unit Code")
                    {
                    }
                    column(UnitDescription; ResitUnits."Unit Description")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(CourseCat);
                    CLEAR(Schoolz);
                    CLEAR(YearText2);
                    CLEAR(FinalTexts);
                    CLEAR(ShowRate);
                    Schoolz := ExamsCoreg."School Name";
                    YearText2 := YoSText;
                    IF ExamsCoreg."Programme Option" <> '' THEN BEGIN
                        IF ExamsCoreg."Prog. Option Name" = '' THEN
                            ExamsCoreg."Prog. Option Name" := ExamsCoreg."Programme Option" + ' Option'
                        ELSE
                            ExamsCoreg."Prog. Option Name" := ExamsCoreg."Prog. Option Name" + ' Option';
                    END;


                    // // // // IF ((SchCode<>ExamsCoreg."School Code") AND (AcadCode<>ExamsCoreg."Academic Year") AND
                    // // // //   (YosCode<>ExamsCoreg."Year of Study") AND (RubsCode<>ExamsCoreg.Classification)) THEN
                    // // // //   BEGIN
                    // // // //   seq:=1;
                    // // // //   SchCode:=ExamsCoreg."School Code";
                    // // // //   AcadCode:=ExamsCoreg."Academic Year";
                    // // // //   YosCode:=ExamsCoreg."Year of Study";
                    // // // //   RubsCode:=ExamsCoreg.Classification;
                    // // // //   END ELSE seq:=seq+1;
                    CLEAR(DisplAyOrder);
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, ExamsCoreg.Programme);
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        IF ((ACAProgramme.Category = ACAProgramme.Category::Certificate) OR
                           (ACAProgramme.Category = ACAProgramme.Category::"Course List") OR
                           (ACAProgramme.Category = ACAProgramme.Category::Professional)) THEN BEGIN
                            CourseCat := 'CERTIFICATE';
                            DisplAyOrder := 2;
                        END ELSE
                            IF (ACAProgramme.Category = ACAProgramme.Category::Diploma) THEN BEGIN
                                DisplAyOrder := 3;
                            END ELSE
                                IF (ACAProgramme.Category = ACAProgramme.Category::Postgraduate) THEN BEGIN
                                    DisplAyOrder := 4;
                                END ELSE
                                    IF (ACAProgramme.Category = ACAProgramme.Category::Undergraduate) THEN BEGIN
                                        DisplAyOrder := 1;
                                    END;

                    END;


                    ACAResultsStatusez.RESET;
                    ACAResultsStatusez.SETRANGE(Code, SenateHeaders."Classification Code");
                    ACAResultsStatusez.SETRANGE(ACAResultsStatusez."Special Programme Class", ACAProgramme."Special Programme Class");
                    ACAResultsStatusez.SETRANGE(ACAResultsStatusez."Academic Year", SenateHeaders."Academic Year");
                    IF ACAResultsStatusez.FIND('-') THEN BEGIN

                        IF ((ACAResultsStatusez."Grad. Status Msg 4" = '') OR (ACAResultsStatusez."Grad. Status Msg 5" = '') OR
                           (ACAResultsStatusez."Grad. Status Msg 5" = '')) THEN
                            YearText2 := '';
                        IF ExamsCoreg."Year of Study" = 1 THEN BEGIN
                            FinalTexts := ACAResultsStatusez."1st Year Grad. Comments";
                        END ELSE
                            IF ExamsCoreg."Year of Study" = 2 THEN BEGIN
                                FinalTexts := ACAResultsStatusez."2nd Year Grad. Comments";
                            END ELSE
                                IF ExamsCoreg."Year of Study" = 3 THEN BEGIN
                                    FinalTexts := ACAResultsStatusez."3rd Year Grad. Comments";
                                END ELSE
                                    IF ExamsCoreg."Year of Study" = 4 THEN BEGIN
                                        FinalTexts := ACAResultsStatusez."4th Year Grad. Comments";
                                    END ELSE
                                        IF ExamsCoreg."Year of Study" = 5 THEN BEGIN
                                            FinalTexts := ACAResultsStatusez."5th Year Grad. Comments";
                                        END ELSE
                                            IF ExamsCoreg."Year of Study" = 6 THEN BEGIN
                                                FinalTexts := ACAResultsStatusez."6th Year Grad. Comments";
                                            END ELSE
                                                IF ExamsCoreg."Year of Study" = 7 THEN BEGIN
                                                    FinalTexts := ACAResultsStatusez."7th Year Grad. Comments";
                                                END;

                        IF ((ExamsCoreg."Final Year of Study") = (ExamsCoreg."Year of Study")) THEN BEGIN
                            IF ((ACAProgramme.Category = ACAProgramme.Category::Certificate) OR
                              (ACAProgramme.Category = ACAProgramme.Category::"Course List") OR
                              (ACAProgramme.Category = ACAProgramme.Category::Professional)) THEN BEGIN
                                FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Cert.";
                            END ELSE
                                IF ((ACAProgramme.Category = ACAProgramme.Category::Diploma)) THEN BEGIN
                                    FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Dip";
                                END ELSE
                                    IF ((ACAProgramme.Category = ACAProgramme.Category::Undergraduate) OR
                           (ACAProgramme.Category = ACAProgramme.Category::Postgraduate)) THEN BEGIN
                                        FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Degree";
                                    END;
                            ShowRate := TRUE;
                        END;

                        IF ACAResultsStatusez."Grad. Status Msg 6" = '' THEN BEGIN
                            Schoolz := '';
                            FinalTexts := '';
                        END;
                        IF ACAResultsStatusez."Grad. Status Msg 4" = '' THEN BEGIN
                            Schoolz := '';
                            FinalTexts := '';
                        END;
                        IF ACAResultsStatusez."Grad. Status Msg 5" = '' THEN BEGIN
                            Schoolz := '';
                            FinalTexts := '';
                        END;
                    END;
                    CLEAR(NextYearofStudy);
                    CLEAR(Var4s);
                    CLEAR(Var5s);
                    IF ExamsCoreg."Final Year of Study" = ExamsCoreg."Year of Study" THEN BEGIN
                        finalists := TRUE;
                        Var4s := 'Examinations for the degree in their repective Programs. They are recommended to GRADUATE';
                    END ELSE BEGIN
                        finalists := FALSE;
                        IF ExamsCoreg."Year of Study" = 1 THEN
                            NextYearofStudy := ' their SECOND (2) year of Study'
                        ELSE
                            IF ExamsCoreg."Year of Study" = 2 THEN
                                NextYearofStudy := ' their THIRD (3) year of Study'
                            ELSE
                                IF ExamsCoreg."Year of Study" = 3 THEN
                                    NextYearofStudy := ' their FOURTH (4) year of Study'
                                ELSE
                                    IF ExamsCoreg."Year of Study" = 4 THEN
                                        NextYearofStudy := ' their FIFTH (5) year of Study'
                                    ELSE
                                        IF ExamsCoreg."Year of Study" = 5 THEN
                                            NextYearofStudy := ' their SIXTH (6) year of Study'
                                        ELSE
                                            IF ExamsCoreg."Year of Study" = 6 THEN NextYearofStudy := ' their SEVENTH (7) year of Study';
                        Var4s := 'Examinations for the degree in their repective Programs. They are recommended to proceed to ' + NextYearofStudy;
                    END;
                    //ExamsCoreg."Student Name":=FormatNames(ExamsCoreg."Student Name");
                end;
            }

            trigger OnAfterGetRecord()
            var
                ACAExamCourseRegistration: Record 66651;
                seq: Integer;
            begin
                CLEAR(seq);
                CLEAR(TransRate);
                CLEAR(RubAcadYear);
                CLEAR(RubNumberText);
                RubAcadYear := SenateHeaders."Academic Year";

                ACAExamCourseRegistration.RESET;
                ACAExamCourseRegistration.SETRANGE("Academic Year", SenateHeaders."Academic Year");
                ACAExamCourseRegistration.SETRANGE("Year of Study", SenateHeaders."Year of Study");
                ACAExamCourseRegistration.SETRANGE("School Code", SenateHeaders."School Code");
                ACAExamCourseRegistration.SETRANGE(Classification, SenateHeaders."Classification Code");
                ACAExamCourseRegistration.SETRANGE("Prog. Category", SenateHeaders.Category);
                ACAExamCourseRegistration.SETCURRENTKEY(Programme, "Programme Option", "Student Number", "Category Order");
                IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        seq += 1;
                        ACAExamCourseRegistration."Rubric Number" := seq;
                        ACAExamCourseRegistration.MODIFY;
                    END;
                    UNTIL ACAExamCourseRegistration.NEXT = 0;
                END;
                CLEAR(YoSText);
                IF SenateHeaders."Year of Study" = 1 THEN YoSText := 'FIRST';
                IF SenateHeaders."Year of Study" = 2 THEN YoSText := 'SECOND';
                IF SenateHeaders."Year of Study" = 3 THEN YoSText := 'THIRD';
                IF SenateHeaders."Year of Study" = 4 THEN YoSText := 'FOURTH';
                IF SenateHeaders."Year of Study" = 5 THEN YoSText := 'FIFTH';
                IF SenateHeaders."Year of Study" = 6 THEN YoSText := 'SIXTH';
                IF SenateHeaders."Year of Study" = 7 THEN YoSText := 'SEVENTH';
                CLEAR(StatusPercentage);
                CLEAR(StatusPercentageBarchelors);
                CLEAR(StatusPercentageMasters);
                CLEAR(StatusPercentageDiploma);
                CLEAR(StatusPercentageCert);
                CLEAR(ShowRateBarch);
                CLEAR(ShowRateCertificate);
                CLEAR(ShowRateDiploma);
                CLEAR(ShowRateMasters);
                CLEAR(IntCount);
                // General
                IF SenateHeaders.School_AcadYear_Count <> 0 THEN BEGIN
                    StatusPercentage := ROUND((SenateHeaders.School_AcadYear_Status_Count / SenateHeaders.School_AcadYear_Count) * 100, 0.01, '<');
                    TransRate := ROUND((SenateHeaders.School_AcadYearTrans_Count / SenateHeaders.School_AcadYear_Count) * 100, 0.01, '<');
                END;
                IF SenateHeaders.Category = SenateHeaders.Category::Undergraduate THEN BEGIN
                    // Barchelors
                    IF SenateHeaders.SchCat_AcadYear_Status_BarcCo <> 0 THEN BEGIN
                        StatusPercentageBarchelors := ROUND((SenateHeaders.SchCat_AcadYear_Status_BarcCo / SenateHeaders.SchCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        TransRateBarch := ROUND((SenateHeaders.SchCat_AcadYearTrans_BarcCo / SenateHeaders.SchCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        ShowRateBarch := TRUE;
                        StatusPercentage := StatusPercentageBarchelors;
                        TransRate := TransRateBarch;
                    END;
                    RubNumberText := ConvertDecimalToText.InitiateConvertion(SenateHeaders.SchCat_AcadYear_Status_BarcCo);
                    IntCount := SenateHeaders.SchCat_AcadYear_Status_BarcCo;
                END ELSE
                    IF SenateHeaders.Category = SenateHeaders.Category::Postgraduate THEN BEGIN
                        // Masters
                        IF SenateHeaders.SchCat_AcadYear_Status_MasCo <> 0 THEN BEGIN
                            StatusPercentageMasters := ROUND((SenateHeaders.SchCat_AcadYear_Status_MasCo / SenateHeaders.SchCat_AcadYear_MasCo) * 100, 0.01, '<');
                            TransRateMasters := ROUND((SenateHeaders.SchCat_AcadYearTrans_MascCo / SenateHeaders.SchCat_AcadYear_MasCo) * 100, 0.01, '<');
                            ShowRateMasters := TRUE;
                            StatusPercentage := StatusPercentageMasters;
                            TransRate := TransRateMasters;
                        END;
                        RubNumberText := ConvertDecimalToText.InitiateConvertion(SenateHeaders.SchCat_AcadYear_Status_MasCo);
                        IntCount := SenateHeaders.SchCat_AcadYear_Status_MasCo;
                    END ELSE
                        IF SenateHeaders.Category = SenateHeaders.Category::Diploma THEN BEGIN
                            // Diploma
                            IF SenateHeaders.SchCat_AcadYear_Status_DipCo <> 0 THEN BEGIN
                                StatusPercentageDiploma := ROUND((SenateHeaders.SchCat_AcadYear_Status_DipCo / SenateHeaders.SchCat_AcadYear_DipCo) * 100, 0.01, '<');
                                TransRateDiploma := ROUND((SenateHeaders.SchCat_AcadYearTrans_DipCo / SenateHeaders.SchCat_AcadYear_DipCo) * 100, 0.01, '<');
                                ShowRateDiploma := TRUE;
                                StatusPercentage := StatusPercentageDiploma;
                                TransRate := TransRateDiploma;
                            END;
                            RubNumberText := ConvertDecimalToText.InitiateConvertion(SenateHeaders.SchCat_AcadYear_Status_DipCo);
                            IntCount := SenateHeaders.SchCat_AcadYear_Status_DipCo;
                        END ELSE
                            IF ((SenateHeaders.Category = SenateHeaders.Category::Certificate)
                     OR (SenateHeaders.Category = SenateHeaders.Category::"Course List")
                      OR (SenateHeaders.Category = SenateHeaders.Category::Professional)) THEN BEGIN
                                // Certificate
                                IF SenateHeaders.SchCat_AcadYear_Status_CertCo <> 0 THEN BEGIN
                                    StatusPercentageCert := ROUND((SenateHeaders.SchCat_AcadYear_Status_CertCo / SenateHeaders.SchCat_AcadYear_CertCo) * 100, 0.01, '<');
                                    TransRateCertificate := ROUND((SenateHeaders.SchCat_AcadYearTrans_CertCo / SenateHeaders.SchCat_AcadYear_CertCo) * 100, 0.01, '<');
                                    ShowRateCertificate := TRUE;
                                    StatusPercentage := StatusPercentageCert;
                                    TransRate := TransRateCertificate;
                                END;
                                RubNumberText := ConvertDecimalToText.InitiateConvertion(SenateHeaders.SchCat_AcadYear_Status_CertCo);
                                IntCount := SenateHeaders.SchCat_AcadYear_Status_CertCo;
                            END;
                CLEAR(SchCode);
            end;

            trigger OnPreDataItem()
            begin
                IF SenateHeaders.GETFILTER("Academic Year") = '' THEN ERROR('Specify the Academic Year filters');
                IF SenateHeaders.GETFILTER("School Code") = '' THEN ERROR('Specify a School Code filters');
                IF SenateHeaders.GETFILTER("Year of Study") = '' THEN ERROR('Specify the Year of Study filter');
                IF SenateHeaders.GETFILTER(Category) = '' THEN ERROR('Specify Program Category');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        IF CompanyInformation.FIND('-') THEN CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record 79;
        seq: Integer;
        ACAProgramme: Record 61511;
        YoSText: Text[150];
        finalists: Boolean;
        ConvertDecimalToText: Codeunit "Convert Decimal To Text ACA";
        Var4s: Text;
        Var5s: Text;
        NextYearofStudy: Text;
        CourseCat: Text[100];
        StatusPercentage: Decimal;
        SchCode: Code[20];
        AcadCode: Code[20];
        YosCode: Integer;
        RubsCode: Code[20];
        ACAResultsStatusez: Record 61739;
        RubAcadYear: Text[250];
        RubNumberText: Text[250];
        Schoolz: Text[250];
        YearText2: Text[250];
        FinalTexts: Text[250];
        TransRate: Decimal;
        ShowRate: Boolean;
        TransRateBarch: Decimal;
        ShowRateBarch: Boolean;
        TransRateMasters: Decimal;
        ShowRateMasters: Boolean;
        TransRateDiploma: Decimal;
        ShowRateDiploma: Boolean;
        TransRateCertificate: Decimal;
        ShowRateCertificate: Boolean;
        StatusPercentageBarchelors: Decimal;
        StatusPercentageMasters: Decimal;
        StatusPercentageDiploma: Decimal;
        StatusPercentageCert: Decimal;
        progOptions: Record 61554;
        DisplAyOrder: Integer;
        IntCount: Integer;
}

