report 78040 "ACA-Consolidated Marksheet 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Consolidated Marksheet 1.rdl';

    dataset
    {
        dataitem(ExamCoreg; "ACA-Exam. Course Registration")
        {
            CalcFields = "Total Courses", "Total Units", "Total Marks", "Total Failed Courses", "Total Failed Units", "Failed Courses", "Failed Units", "Total Cores Passed", "Tota Electives Passed", "Total Required Passed", "Total Cores Done", "Total Required Done", "Total Electives Done";
            RequestFilterFields = Programme, "Academic Year", "Year of Study", "Programme Option", "Global Dimension 1 Code";
            column(seq; seq)
            {
            }
            column(COmpName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address + ', ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(pic; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(StudNumber; ExamCoreg."Student Number")
            {
            }
            column(CampusFilter; ExamCoreg.GETFILTER("Global Dimension 1 Code"))
            {
            }
            column(Progs; ExamCoreg.Programme)
            {
            }
            column(YearofStudy; ExamCoreg."Year of Study")
            {
            }
            column(AcadYear; ExamCoreg."Academic Year")
            {
            }
            column(StudentName; FormatNames(ExamCoreg."Student Name"))
            {
            }
            column(Dept; ExamCoreg.Department)
            {
            }
            column(SchCode; ExamCoreg."School Code")
            {
            }
            column(DeptName; ExamCoreg."Department Name")
            {
            }
            column(SchName; ExamCoreg."School Name")
            {
            }
            column(Class; ExamCoreg.Classification)
            {
            }
            column(NAverage; ROUND(ExamCoreg."Normal Average", 0.01, '='))
            {
            }
            column(WAverage; ROUND(ExamCoreg."Weighted Average", 0.01, '='))
            {
            }
            column(ProgOption; ExamCoreg."Programme Option")
            {
            }
            column(PercentageFailedCourses; ExamCoreg."% Total Failed Courses")
            {
            }
            column(PercentageFailedUnits; ExamCoreg."% Total Failed Units")
            {
            }
            column(TotalPassed; ExamCoreg."Total Required Passed" + ExamCoreg."Tota Electives Passed" + ExamCoreg."Total Cores Passed")
            {
            }
            column(TotalCourseDone; ExamCoreg."Total Electives Done" + ExamCoreg."Total Required Done" + ExamCoreg."Total Cores Done")
            {
            }
            column(TotalUnits; ExamCoreg."Total Units")
            {
            }
            column(TotalMarks; ExamCoreg."Total Marks")
            {
            }
            column(TotFailedCourses; ExamCoreg."Total Failed Courses")
            {
            }
            column(TotFailedUnits; ExamCoreg."Total Failed Units")
            {
            }
            column(FailedCourses; ExamCoreg."Failed Courses")
            {
            }
            column(FailedUnits; ExamCoreg."Failed Units")
            {
            }
            column(TotalCoursesPassed; ExamCoreg."Total Required Passed" + ExamCoreg."Tota Electives Passed" + ExamCoreg."Total Cores Passed")
            {
            }
            column(TotWeightedMarks; ExamCoreg."Total Weighted Marks")
            {
            }
            column(ClassOrder; ExamCoreg."Final Classification Order")
            {
            }
            dataitem(ExamClassUnits; "ACA-Exam Classification Units")
            {
                CalcFields = "Comsolidated Prefix", "Grade Comment", Grade, Pass;
                DataItemLink = "Student No." = FIELD("Student Number"),
                               Programme = FIELD(Programme),
                               "Academic Year" = FIELD("Academic Year"),
                               "Year of Study" = FIELD("Year of Study");
                column(UnitCode; ExamClassUnits."Unit Code")
                {
                }
                column(UnitDescription; ExamClassUnits."Unit Description")
                {
                }
                column(CreditHours; ExamClassUnits."Credit Hours")
                {
                }
                column(CATScore; ExamClassUnits."CAT Score")
                {
                }
                column(ExamScore; ExamClassUnits."Exam Score")
                {
                }
                column(TotalScore; ExamClassUnits."Total Score")
                {
                }
                column(Pass; ExamClassUnits.Pass)
                {
                }
                column(UnitYearOfStudy; ExamClassUnits."Year of Study")
                {
                }
                column(ExamScoreDecimal; ExamClassUnits."Exam Score Decimal")
                {
                }
                column(CATScoreDecimal; ExamClassUnits."CAT Score Decimal")
                {
                }
                column(TotalScoreDecimal; ExamClassUnits."Total Score Decimal")
                {
                }
                column(UnitGrade; ExamClassUnits.Grade)
                {
                }
                column(UnitSchoolCode; ExamClassUnits."School Code")
                {
                }
                column(UnitDepartmentCode; ExamClassUnits."Department Code")
                {
                }
                column(GradeComment; ExamClassUnits."Grade Comment")
                {
                }
                column(Prefix; ExamClassUnits."Comsolidated Prefix")
                {
                }
                column(isRepeatOrResit; ExamClassUnits."Is a Resit/Repeat")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(seq);
                IF ExamCoreg.GETFILTER(Programme) = '' THEN ERROR('Specify a programme');
                IF ExamCoreg.GETFILTER("Academic Year") = '' THEN ERROR('Specify Academic year');
                IF ExamCoreg.GETFILTER("Year of Study") = '' THEN ERROR('Specify Year of Study');
                ACAProgrammeOptions.RESET;
                ACAProgrammeOptions.SETRANGE("Programme Code", ExamCoreg.GETFILTER(Programme));
                ACAProgrammeOptions.SETFILTER(Code, '<>%1', '');
                IF ACAProgrammeOptions.FIND('-') THEN BEGIN
                    IF ExamCoreg.GETFILTER("Programme Option") = '' THEN ERROR('Specify Programme option');
                END;
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

    trigger OnPreReport()
    begin
        IF ExamCoreg.GETFILTER(Programme) = '' THEN ERROR('Specify a programme filter.');
    end;

    var
        CompanyInformation: Record 79;
        DimensionValue: Record 349;
        ACAUnitsSubjects: Record 61517;
        seq: Integer;
        ACAProgrammeOptions: Record 61554;

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
        /*CommonName:=CONVERTSTR(CommonName,',',' ');
           FormerCommonName:='';
          REPEAT
           BEGIN
          Countings+=1;
          IF COPYSTR(CommonName,Countings,1)=' ' THEN BEGIN
           IF OneSpaceFound=FALSE THEN FormerCommonName:=FormerCommonName+COPYSTR(CommonName,Countings,1);
            OneSpaceFound:=TRUE
           END ELSE BEGIN
             OneSpaceFound:=FALSE;
             FormerCommonName:=FormerCommonName+COPYSTR(CommonName,Countings,1)
           END;
           END;
             UNTIL Countings=STRLEN(CommonName);
             CommonName:=FormerCommonName;
        CLEAR(NamesSmall);
        CLEAR(FirsName);
        CLEAR(SpaceCount);
        CLEAR(SpaceFound);
        CLEAR(OtherNames);
        IF STRLEN(CommonName)>100 THEN  CommonName:=COPYSTR(CommonName,1,100);
        Strlegnth:=STRLEN(CommonName);
        IF STRLEN(CommonName)>4 THEN BEGIN
          NamesSmall:=LOWERCASE(CommonName);
          REPEAT
            BEGIN
              SpaceCount+=1;
              IF ((COPYSTR(NamesSmall,SpaceCount,1)='') OR (COPYSTR(NamesSmall,SpaceCount,1)=' ') OR (COPYSTR(NamesSmall,SpaceCount,1)=',')) THEN SpaceFound:=TRUE;
              IF NOT SpaceFound THEN BEGIN
                FirsName:=FirsName+UPPERCASE(COPYSTR(NamesSmall,SpaceCount,1));
                END ELSE  BEGIN
                  IF STRLEN(OtherNames)<150 THEN BEGIN
                IF ((COPYSTR(NamesSmall,SpaceCount,1)='') OR (COPYSTR(NamesSmall,SpaceCount,1)=' ') OR (COPYSTR(NamesSmall,SpaceCount,1)=',')) THEN BEGIN
                  OtherNames:=OtherNames+' ';
                SpaceCount+=1;
                  OtherNames:=OtherNames+UPPERCASE(COPYSTR(NamesSmall,SpaceCount,1));
                  END ELSE BEGIN
                  OtherNames:=OtherNames+COPYSTR(NamesSmall,SpaceCount,1);
                    END;
        
                END;
                END;
            END;
              UNTIL ((SpaceCount=Strlegnth))
          END;
          CLEAR(NewName);
        NewName:=FirsName+','+OtherNames;*/

    end;
}

