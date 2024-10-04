/// <summary>
/// Report Exams Final Retake List (ID 78047).
/// </summary>
report 78047 "Exams Final Retake List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exams Final Retake List.rdl';

    dataset
    {
        dataitem(SenateHeaders; 66654)
        {
            DataItemTableView = WHERE("Classification Code" = FILTER('RETAKE LIST'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Academic Year", "School Code", "Programme Code";
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
            dataitem(ExamsCoreg; 66651)
            {
                DataItemLink = Programme = FIELD("Programme Code"),
                               "School Code" = FIELD("School Code"),
                               "Academic Year" = FIELD("Academic Year"),
                               Classification = FIELD("Classification Code"),
                               "Year of Study" = FIELD("Year of Study");
                DataItemTableView = WHERE(Classification = FILTER('RETAKE LIST'));
                column(seq2; ACASenateReportsCounts.Counts)
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
                column(SchClassCount; SenateHeaders."School Classification Count")
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
                column(StudentName; FormatNames(ExamsCoreg."Student Name"))
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
                dataitem(ExamRes; 66650)
                {
                    DataItemLink = "Student No." = FIELD("Student Number"),
                                   Programme = FIELD(Programme),
                                   "Year of Study" = FIELD("Year of Study"),
                                   "Academic Year" = FIELD("Academic Year");
                    DataItemTableView = WHERE(Pass = FILTER(false));
                    column(UnitCode; ExamRes."Unit Code")
                    {
                    }
                    column(UnitDesc; ExamRes."Unit Description")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ACASenateReportsCounts.RESET;
                    ACASenateReportsCounts.SETRANGE("Student Number", ExamsCoreg."Student Number");
                    IF ACASenateReportsCounts.FIND('-') THEN;
                    CLEAR(CourseCat);
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, ExamsCoreg.Programme);
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        IF ((ACAProgramme.Category = ACAProgramme.Category::Certificate) OR
                           (ACAProgramme.Category = ACAProgramme.Category::"Course List") OR
                           (ACAProgramme.Category = ACAProgramme.Category::Professional)) THEN
                            CourseCat := 'CERTIFICATE';
                    END;
                    CLEAR(NextYearofStudy);
                    CLEAR(Var4s);
                    CLEAR(Var5s);
                    IF ExamsCoreg."Final Year of Study" = ExamsCoreg."Year of Study" THEN BEGIN
                        finalists := TRUE;
                        Var4s := ' having failed their studies and to resit the courses indicated against their names while outside the university when next offered.';
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
                        Var4s := ' having failed their studies and to resit the courses indicated against their names while outside the university when next offered.';
                    END;
                    seq += 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                ACAExamCourseRegistration: Record 66651;
                seq: Integer;
            begin

                // ACASenateReportsCounts.RESET;
                // ACASenateReportsCounts.DELETEALL;
                //   ACAExamCourseRegistration.RESET;
                //   ACAExamCourseRegistration.SETRANGE("Academic Year",SenateHeaders."Academic Year");
                //   ACAExamCourseRegistration.SETRANGE("Year of Study",SenateHeaders."Year of Study");
                //   ACAExamCourseRegistration.SETRANGE("School Code",SenateHeaders."School Code");
                //   ACAExamCourseRegistration.SETRANGE(Classification,SenateHeaders."Classification Code");
                //   ACAExamCourseRegistration.SETCURRENTKEY(Programme,"Student Number");
                //   IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                //     CLEAR(seq);
                //     REPEAT
                //         BEGIN
                //         ACASenateReportsCounts.INIT;
                //         ACASenateReportsCounts."Student Number":=ACAExamCourseRegistration."Student Number";
                //         IF ACASenateReportsCounts.INSERT THEN BEGIN
                //           seq+=1;
                //         ACASenateReportsCounts.Counts:=seq;
                //         ACASenateReportsCounts.MODIFY;
                //           END;
                //         END;
                //        UNTIL ACAExamCourseRegistration.NEXT=0;
                //      END;

                CLEAR(YoSText);
                CLEAR(seq);
                IF SenateHeaders."Year of Study" = 1 THEN YoSText := 'FIRST';
                IF SenateHeaders."Year of Study" = 2 THEN YoSText := 'SECOND';
                IF SenateHeaders."Year of Study" = 3 THEN YoSText := 'THIRD';
                IF SenateHeaders."Year of Study" = 4 THEN YoSText := 'FOURTH';
                IF SenateHeaders."Year of Study" = 5 THEN YoSText := 'FIFTH';
                IF SenateHeaders."Year of Study" = 6 THEN YoSText := 'SIXTH';
                IF SenateHeaders."Year of Study" = 7 THEN YoSText := 'SEVENTH';
                SenateHeaders.CALCFIELDS("School Classification Count");
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
        ACASenateReportsCounts: Record 66656 temporary;

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

