report 74550 "EXT-Master Timetable (Final)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/EXT-Master Timetable (Final).rdl';

    dataset
    {
        dataitem("EXT-Timetable FInal Collector"; 74568)
        {
            RequestFilterFields = Programme, Unit, Semester, Lecturer, "Date Code", "Period Code", Department, "Period Type", "Room Code";
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
            column(ProgrammeCode; "EXT-Timetable FInal Collector".Programme)
            {
            }
            column(UnitCode; "EXT-Timetable FInal Collector".Unit)
            {
            }
            column(Semes; "EXT-Timetable FInal Collector".Semester)
            {
            }
            column(LessonCode; "EXT-Timetable FInal Collector"."Period Code")
            {
            }
            column(DayOfWeek; "EXT-Timetable FInal Collector"."Date Code")
            {
            }
            column(LectureRoom; "EXT-Timetable FInal Collector"."Lecture Room")
            {
            }
            column(LecturerCode; "EXT-Timetable FInal Collector".Lecturer)
            {
            }
            column(DepartmentLCode; "EXT-Timetable FInal Collector".Department)
            {
            }
            column(RoomType; "EXT-Timetable FInal Collector"."Room Type")
            {
            }
            column(CampusCode; "EXT-Timetable FInal Collector"."Campus Code")
            {
            }
            column(RoomCode; "EXT-Timetable FInal Collector"."Room Code")
            {
            }
            column(BuldingOrBlock; "EXT-Timetable FInal Collector"."Block/Building")
            {
            }
            column(Faculty; "EXT-Timetable FInal Collector"."School or Faculty")
            {
            }
            column(LessomCategory; "EXT-Timetable FInal Collector"."Period Category")
            {
            }
            column(LessonOrder; "EXT-Timetable FInal Collector"."Period Order")
            {
            }
            column(DayOrder; "EXT-Timetable FInal Collector"."Date Order")
            {
            }
            column(RecordId; "EXT-Timetable FInal Collector"."Record ID")
            {
            }
            column(AllocatedStatus; "EXT-Timetable FInal Collector".Allocated)
            {
            }
            column(LessonType; "EXT-Timetable FInal Collector"."Period Type")
            {
            }
            column(LessonStart; TTDailyLessons."Start Time")
            {
            }
            column(LessonStop; TTDailyLessons."End Time")
            {
            }
            column(TimetableEntry; '[' + "EXT-Timetable FInal Collector".Programme + ';' + "EXT-Timetable FInal Collector".Unit + ';' + "EXT-Timetable FInal Collector".Lecturer + ';' + "EXT-Timetable FInal Collector"."Room Code" + ';]')
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
                TTProgrammes.SETRANGE(Semester, "EXT-Timetable FInal Collector".Semester);
                TTProgrammes.SETRANGE("Programme Code", "EXT-Timetable FInal Collector".Programme);
                IF TTProgrammes.FIND('-') THEN;
                IF DontUseColor = TRUE THEN TTProgrammes."Timetable Color" := TTProgrammes."Timetable Color"::White;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "EXT-Timetable FInal Collector".Programme);
                IF ACAProgramme.FIND('-') THEN;

                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, "EXT-Timetable FInal Collector".Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", "EXT-Timetable FInal Collector".Programme);
                IF ACAUnitsSubjects.FIND('-') THEN;

                TTDailyLessons.RESET;
                TTDailyLessons.SETRANGE(Semester, "EXT-Timetable FInal Collector".Semester);
                TTDailyLessons.SETRANGE("Date Code", "EXT-Timetable FInal Collector"."Date Code");
                TTDailyLessons.SETRANGE("Period Code", "EXT-Timetable FInal Collector"."Period Code");
                IF TTDailyLessons.FIND('-') THEN BEGIN

                END;
                // //  CountedColumns:=CountedColumns+1;
                // //  IF CountedColumns=5 THEN CountedColumns:=1;
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "EXT-Timetable FInal Collector".Lecturer);
                IF HRMEmployeeC.FIND('-') THEN BEGIN

                END;

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "EXT-Timetable FInal Collector".Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;


                ACAUnitsSubjects2.RESET;
                ACAUnitsSubjects2.SETRANGE("Programme Code", "EXT-Timetable FInal Collector".Programme);
                ACAUnitsSubjects2.SETRANGE(Code, "EXT-Timetable FInal Collector".Unit);
                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN

                END;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(LFiltersApplied);
                LFiltersApplied := "EXT-Timetable FInal Collector".GETFILTERS;
                DontUseColor := FALSE;
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
        TTDailyLessons: Record 74552;
        LFiltersApplied: Text[1024];
        HRMEmployeeC: Record 61188;

        ACAUnitsSubjects2: Record 61517;
        CountedColumnsProgs: Integer;
        CountedColumnsLects: Integer;
        CountedColumnsUnits: Integer;
        TTProgrammes: Record 74553;
        DontUseColor: Boolean;
}

