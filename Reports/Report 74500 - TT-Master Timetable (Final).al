report 74500 "TT-Master Timetable (Final)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/TT-Master Timetable (Final).rdl';

    dataset
    {
        dataitem("TT-Timetable FInal Collector"; 74523)
        {
            RequestFilterFields = Programme, Unit, Semester, Lecturer, "Day of Week", "Lesson Code", Department, "Lesson Type", "Room Code";
            column(ProgName; ACAProgramme.Description)
            {
            }
            column(UnitName; ACAUnitsSubjects.Desription)
            {
            }
            column(LectName; HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress1; CompanyInformation.Address)
            {
            }
            column(CompAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(Phone1; CompanyInformation."Phone No.")
            {
            }
            column(Phone2; CompanyInformation."Phone No. 2")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(HomepAge; CompanyInformation."Home Page")
            {
            }
            column(ProgrammeCode; "TT-Timetable FInal Collector".Programme)
            {
            }
            column(UnitCode; "TT-Timetable FInal Collector".Unit)
            {
            }
            column(Semes; "TT-Timetable FInal Collector".Semester)
            {
            }
            column(LessonCode; "TT-Timetable FInal Collector"."Lesson Code")
            {
            }
            column(DayOfWeek; "TT-Timetable FInal Collector"."Day of Week")
            {
            }
            column(LectureRoom; "TT-Timetable FInal Collector"."Lecture Room")
            {
            }
            column(LecturerCode; "TT-Timetable FInal Collector".Lecturer)
            {
            }
            column(DepartmentLCode; "TT-Timetable FInal Collector".Department)
            {
            }
            column(RoomType; "TT-Timetable FInal Collector"."Room Type")
            {
            }
            column(CampusCode; "TT-Timetable FInal Collector"."Campus Code")
            {
            }
            column(RoomCode; "TT-Timetable FInal Collector"."Room Code")
            {
            }
            column(BuldingOrBlock; "TT-Timetable FInal Collector"."Block/Building")
            {
            }
            column(Faculty; "TT-Timetable FInal Collector"."School or Faculty")
            {
            }
            column(LessomCategory; "TT-Timetable FInal Collector"."Lesson Category")
            {
            }
            column(LessonOrder; "TT-Timetable FInal Collector"."Lesson Order")
            {
            }
            column(DayOrder; "TT-Timetable FInal Collector"."Day Order")
            {
            }
            column(RecordId; "TT-Timetable FInal Collector"."Record ID")
            {
            }
            column(AllocatedStatus; "TT-Timetable FInal Collector".Allocated)
            {
            }
            column(LessonType; "TT-Timetable FInal Collector"."Lesson Type")
            {
            }
            column(LessonStart; TTDailyLessons."Start Time")
            {
            }
            column(LessonStop; TTDailyLessons."End Time")
            {
            }
            column(LessonCode2; TTDailyLessons."Lesson Code")
            {
            }
            column(TimetableEntry; '[' + "TT-Timetable FInal Collector".Programme + ';' + "TT-Timetable FInal Collector".Unit + ';' + "TT-Timetable FInal Collector".Lecturer + ';' + "TT-Timetable FInal Collector"."Room Code" + ';]')
            {
            }
            column(LFiltersApplied; LFiltersApplied)
            {
            }
            column(bgColor; FORMAT(TTProgrammes."Timetable Color"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                TTProgrammes.RESET;
                TTProgrammes.SETRANGE(Semester, "TT-Timetable FInal Collector".Semester);
                TTProgrammes.SETRANGE("Programme Code", "TT-Timetable FInal Collector".Programme);
                IF TTProgrammes.FIND('-') THEN;
                IF DontUseColor = TRUE THEN TTProgrammes."Timetable Color" := TTProgrammes."Timetable Color"::White;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Timetable FInal Collector".Programme);
                IF ACAProgramme.FIND('-') THEN;

                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, "TT-Timetable FInal Collector".Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", "TT-Timetable FInal Collector".Programme);
                IF ACAUnitsSubjects.FIND('-') THEN;

                TTDailyLessons.RESET;
                TTDailyLessons.SETRANGE(Semester, "TT-Timetable FInal Collector".Semester);
                TTDailyLessons.SETRANGE("Day Code", "TT-Timetable FInal Collector"."Day of Week");
                TTDailyLessons.SETRANGE("Lesson Code", "TT-Timetable FInal Collector"."Lesson Code");
                IF TTDailyLessons.FIND('-') THEN BEGIN

                END;
                // //  CountedColumns:=CountedColumns+1;
                // //  IF CountedColumns=5 THEN CountedColumns:=1;
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "TT-Timetable FInal Collector".Lecturer);
                IF HRMEmployeeC.FIND('-') THEN BEGIN

                END;

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Timetable FInal Collector".Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;


                ACAUnitsSubjects2.RESET;
                ACAUnitsSubjects2.SETRANGE("Programme Code", "TT-Timetable FInal Collector".Programme);
                ACAUnitsSubjects2.SETRANGE(Code, "TT-Timetable FInal Collector".Unit);
                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN

                END;
            end;

            trigger OnPreDataItem()
            begin

                DontUseColor := FALSE;
                CLEAR(LFiltersApplied);
                LFiltersApplied := "TT-Timetable FInal Collector".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field(ColorOption; DontUseColor)
                    {
                        Caption = 'Dont use Colors?';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN;
    end;

    var
        CompanyInformation: Record 79;
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        OutputLayout: Option Potrait,Landscape;
        IncludeProgSummary: Boolean;
        IncludeLectSummary: Boolean;
        IncludeUnitSummary: Boolean;
        TTDailyLessons: Record 74503;
        LFiltersApplied: Text[1024];
        HRMEmployeeC: Record 61188;
        TTLegendProgrammes: Record 74525;
        TTLegendLecturers: Record 74526;

        ACAUnitsSubjects2: Record 61517;
        CountedColumnsProgs: Integer;
        CountedColumnsLects: Integer;
        CountedColumnsUnits: Integer;
        TTProgrammes: Record 74504;
        DontUseColor: Boolean;
}

