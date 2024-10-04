codeunit 60111 "ACA-Dates"
{

    trigger OnRun()
    begin
    end;

    var
        dayOfWeek: Integer;
        weekNumber: Integer;
        year: Integer;
        weekends: Integer;
        NextDay: Date;


    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        IF ((DateOfBirth <> 0D) AND (DateOfJoin <> 0D)) THEN BEGIN
            dayB := DATE2DMY(DateOfBirth, 1);
            monthB := DATE2DMY(DateOfBirth, 2);
            yearB := DATE2DMY(DateOfBirth, 3);
            dayJ := DATE2DMY(DateOfJoin, 1);
            monthJ := DATE2DMY(DateOfJoin, 2);
            yearJ := DATE2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            CASE (DateCat) OF
                1:
                    BEGIN
                        Year := yearJ - yearB;
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        END;

                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            END;

                        AgeString := '%1  Years, %2  Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);

                    END;

                2, 3, 7:
                    BEGIN
                        IF (monthJ <> monthB) THEN BEGIN
                            IF monthJ >= monthB THEN
                                Month := monthJ - monthB;
                            // ELSE ERROR('The wrong date category!');
                        END;

                        IF (dayJ <> dayB) THEN BEGIN
                            IF (dayJ >= dayB) THEN
                                Day := dayJ - dayB
                            ELSE
                                IF (dayJ < dayB) THEN BEGIN
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                END;
                        END;

                        AgeString := '%1  Months %2 Days';
                        AgeString := STRSUBSTNO(AgeString, Month, Day);
                    END;
                4:
                    BEGIN
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := STRSUBSTNO(AgeString, Year);
                    END;
                5:
                    BEGIN
                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            END;

                        Year := yearJ - yearB;
                        AgeString := '%1  Years, %2 Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);
                    END;
                6:
                    BEGIN
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        END;
                        Year := yearJ - yearB;
                        AgeString := '%1  Years and #2## Months';
                        AgeString := STRSUBSTNO(AgeString, Year, Month);
                    END;
                ELSE
                    AgeString := '';
            END;
        END ELSE
            MESSAGE('For Date Calculation Enter All Applicable Dates!');
        EXIT;
    end;


    procedure DifferenceStartEnd(StartDate: Date; EndDate: Date) DaysValue: Integer
    var
        dayStart: Integer;
        monthS: Integer;
        yearS: Integer;
        dayEnd: Integer;
        monthE: Integer;
        yearE: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsBetween: Integer;
        i: Integer;
        j: Integer;
        monthValue: Integer;
        monthEnd: Integer;
        p: Integer;
        q: Integer;
        l: Integer;
        DateCat: Integer;
        daysInYears: Integer;
        m: Integer;
        yearStart: Integer;
        t: Integer;
        s: Integer;
        WeekendDays: Integer;
        Holidays: Integer;
    begin
        IF ((StartDate <> 0D) AND (EndDate <> 0D)) THEN BEGIN
            Day := 0;
            monthValue := 0;
            p := 0;
            q := 0;
            l := 0;
            Year := 0;
            daysInYears := 0;
            DaysValue := 0;
            dayStart := DATE2DMY(StartDate, 1);
            monthS := DATE2DMY(StartDate, 2);
            yearS := DATE2DMY(StartDate, 3);
            dayEnd := DATE2DMY(EndDate, 1);
            monthE := DATE2DMY(EndDate, 2);
            yearE := DATE2DMY(EndDate, 3);

            WeekendDays := 0;
            //AbsencePreferences.FIND('-');
            //IF (AbsencePreferences."Include Weekends" = TRUE) THEN
            //   WeekendDays:= DetermineWeekends(StartDate,EndDate);

            Holidays := 0;
            // AbsencePreferences.FIND('-');
            // IF (AbsencePreferences."Include Holidays" = TRUE) THEN
            //   Holidays:= DetermineHolidays(StartDate,EndDate);

            DateCat := DateCategory(dayStart, dayEnd, monthS, monthE, yearS, yearE);
            CASE (DateCat) OF
                1:
                    BEGIN
                        p := 0;
                        q := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;
                        IF (monthE <> monthS) THEN BEGIN

                            FOR j := 1 TO (monthS - 1) DO BEGIN
                                q := q + DetermineDaysInMonth(t, yearS);
                                t := t + 1;
                            END;
                            q := q + dayStart;

                            FOR i := 1 TO (monthE - 1) DO BEGIN
                                p := p + DetermineDaysInMonth(s, yearE);
                                s := s + 1;
                            END;
                            p := p + dayEnd;

                            FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN
                                    daysInYears := daysInYears + 366
                                ELSE
                                    daysInYears := daysInYears + 365;
                                yearStart := yearStart + 1;
                            END;
                            DaysValue := (((daysInYears - q) + p) - WeekendDays) - Holidays;
                        END;
                    END;

                2, 7:
                    BEGIN
                        FOR l := (monthS + 1) TO (monthE - 1) DO
                            DaysValue := DaysValue + DetermineDaysInMonth(l, yearS);
                        DaysValue := ((DaysValue + (DetermineDaysInMonth(monthS, yearS) - dayStart) + dayEnd) - WeekendDays) - Holidays;
                    END;

                3:
                    BEGIN
                        IF (dayEnd >= dayStart) THEN
                            DaysValue := dayEnd - dayStart - WeekendDays - Holidays
                        ELSE
                            IF (dayEnd = dayStart) THEN
                                DaysValue := 0
                            ELSE
                                DaysValue := ((dayStart - dayEnd) - WeekendDays) - Holidays;

                    END;

                4:
                    BEGIN
                        DaysValue := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        FOR m := 1 TO Year DO BEGIN
                            IF (LeapYear(yearStart)) THEN
                                daysInYears := 366
                            ELSE
                                daysInYears := 365;
                            DaysValue := DaysValue + daysInYears;
                            yearStart := yearStart + 1;
                        END;
                        DaysValue := (DaysValue - WeekendDays) - Holidays;
                    END;

                5:
                    BEGIN
                        Year := yearE - yearS;
                        yearStart := yearS;
                        FOR m := 1 TO Year DO BEGIN
                            IF LeapYear(yearStart) THEN
                                daysInYears := daysInYears + 366
                            ELSE
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        END;
                        DaysValue := daysInYears;
                        IF dayEnd > dayStart THEN
                            DaysValue := (DaysValue + (dayEnd - dayStart) - WeekendDays) - Holidays
                        ELSE
                            IF dayStart > dayEnd THEN
                                DaysValue := (DaysValue - (dayStart - dayEnd) - WeekendDays) - Holidays;
                    END;

                6:
                    BEGIN
                        q := 0;
                        p := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;

                        FOR j := 1 TO monthS DO BEGIN
                            q := q + DetermineDaysInMonth(t, yearS);
                            t := t + 1;
                        END;

                        FOR i := 1 TO monthE DO BEGIN
                            p := p + DetermineDaysInMonth(s, yearE);
                            s := s + 1;
                        END;

                        FOR m := 1 TO Year DO BEGIN
                            IF LeapYear(yearStart) THEN
                                daysInYears := daysInYears + 366
                            ELSE
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        END;

                        DaysValue := ((daysInYears - q) + p) - WeekendDays - Holidays;
                    END;
                ELSE
                    DaysValue := 0;

            END;
        END ELSE
            MESSAGE('Enter all applicable dates for calculation!');
        DaysValue += 1;
        EXIT;
    end;


    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        CASE (Month) OF
            1:
                DaysInMonth := 31;
            2:
                BEGIN
                    IF (LeapYear(Year)) THEN
                        DaysInMonth := 29
                    ELSE
                        DaysInMonth := 28;
                END;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            ELSE
                MESSAGE('Not valid date. The month must be between 1 and 12');
        END;

        EXIT;
    end;


    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    begin
        IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN
            Category := 1
        ELSE
            IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN
                Category := 2
            ELSE
                IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN
                    Category := 3
                ELSE
                    IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                        Category := 4
                    ELSE
                        IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN
                            Category := 5
                        ELSE
                            IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN
                                Category := 6
                            ELSE
                                IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN
                                    Category := 7
                                ELSE
                                    IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                                        Category := 3
                                    ELSE BEGIN
                                        Category := 0;
                                        //ERROR('The start date cannot be after the end date.');
                                    END;
        EXIT;
    end;


    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year MOD 100 = 0;
        DivByFour := Year MOD 4 = 0;
        IF ((NOT CenturyYear AND DivByFour) OR (Year MOD 400 = 0)) THEN
            LY := TRUE
        ELSE
            LY := FALSE;
    end;


    procedure ReservedDates(NewStartDate: Date; NewEndDate: Date; EmployeeNumber: Code[20]) Reserved: Boolean
    var
        OK: Boolean;
    begin
        //AbsenceHoliday.SETFILTER("Employee No.",EmployeeNumber);
        //  OK:= AbsenceHoliday.FIND('-');
        /*  REPEAT
              IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewStartDate < AbsenceHoliday."End Date") THEN
                 Reserved := TRUE
              ELSE
              IF (NewEndDate < AbsenceHoliday."End Date") AND (NewEndDate > AbsenceHoliday."Start Date") THEN
                 Reserved := TRUE
              ELSE
              IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewEndDate < AbsenceHoliday."End Date") THEN
                 Reserved := TRUE
              ELSE Reserved := FALSE;

          UNTIL AbsenceHoliday.NEXT = 0;*/

    end;


    procedure DetermineWeekends(DateStart: Date; DateEnd: Date) Weekends: Integer
    begin
        Weekends := 0;
        WHILE (DateStart <= DateEnd) DO BEGIN
            dayOfWeek := DATE2DWY(DateStart, 1);
            IF (dayOfWeek = 6) OR (dayOfWeek = 7) THEN
                Weekends := Weekends + 1;
            NextDay := CalculateNextDay(DateStart);
            DateStart := NextDay;
        END;
    end;


    procedure CalculateNextDay(Date: Date) NextDate: Date
    var
        today: Integer;
        month: Integer;
        year: Integer;
        nextDay: Integer;
        daysInMonth: Integer;
    begin
        today := DATE2DMY(Date, 1);
        month := DATE2DMY(Date, 2);
        year := DATE2DMY(Date, 3);
        daysInMonth := DetermineDaysInMonth(month, year);
        nextDay := today + 1;
        IF (nextDay > daysInMonth) THEN BEGIN
            nextDay := 1;
            month := month + 1;
            IF (month > 12) THEN BEGIN
                month := 1;
                year := year + 1;
            END;
        END;
        NextDate := DMY2DATE(nextDay, month, year);
    end;


    procedure DetermineHolidays(DateStart: Date; DateEnd: Date) Holiday: Integer
    var
        NextDay: Date;
    begin
        /*  Holiday:= 0;
          WHILE (DateStart <= DateEnd) DO BEGIN
            dayOfWeek:= DATE2DWY(DateStart,1);
            StatutoryHoliday.FIND('-');
            REPEAT
             IF (DateStart = StatutoryHoliday."Holiday Date") THEN
                Holiday:= Holiday + StatutoryHoliday."Duration Of Holiday";

            UNTIL StatutoryHoliday.NEXT = 0;
            NextDay:= CalculateNextDay(DateStart);
            DateStart:= NextDay;
         END;   */

    end;


    procedure ConvertDate(nDate: Date) strDate: Text[30]
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        strDay: Text[4];
        StrMonth: Text[20];
        strYear: Text[6];
    begin
        //this function converts the date to the format required by ksps
        lDay := DATE2DMY(nDate, 1);
        lMonth := DATE2DMY(nDate, 2);
        lYear := DATE2DMY(nDate, 3);

        IF lDay = 1 THEN BEGIN strDay := '1st' END;
        IF lDay = 2 THEN BEGIN strDay := '2nd' END;
        IF lDay = 3 THEN BEGIN strDay := '3rd' END;
        IF lDay = 4 THEN BEGIN strDay := '4th' END;
        IF lDay = 5 THEN BEGIN strDay := '5th' END;
        IF lDay = 6 THEN BEGIN strDay := '6th' END;
        IF lDay = 7 THEN BEGIN strDay := '7th' END;
        IF lDay = 8 THEN BEGIN strDay := '8th' END;
        IF lDay = 9 THEN BEGIN strDay := '9th' END;
        IF lDay = 10 THEN BEGIN strDay := '10th' END;
        IF lDay = 11 THEN BEGIN strDay := '11th' END;
        IF lDay = 12 THEN BEGIN strDay := '12th' END;
        IF lDay = 13 THEN BEGIN strDay := '13th' END;
        IF lDay = 14 THEN BEGIN strDay := '14th' END;
        IF lDay = 15 THEN BEGIN strDay := '15th' END;
        IF lDay = 16 THEN BEGIN strDay := '16th' END;
        IF lDay = 17 THEN BEGIN strDay := '17th' END;
        IF lDay = 18 THEN BEGIN strDay := '18th' END;
        IF lDay = 19 THEN BEGIN strDay := '19th' END;
        IF lDay = 20 THEN BEGIN strDay := '20th' END;
        IF lDay = 21 THEN BEGIN strDay := '21st' END;
        IF lDay = 22 THEN BEGIN strDay := '22nd' END;
        IF lDay = 23 THEN BEGIN strDay := '23rd' END;
        IF lDay = 24 THEN BEGIN strDay := '24th' END;
        IF lDay = 25 THEN BEGIN strDay := '25th' END;
        IF lDay = 26 THEN BEGIN strDay := '26th' END;
        IF lDay = 27 THEN BEGIN strDay := '27th' END;
        IF lDay = 28 THEN BEGIN strDay := '28th' END;
        IF lDay = 29 THEN BEGIN strDay := '29th' END;
        IF lDay = 30 THEN BEGIN strDay := '30th' END;
        IF lDay = 31 THEN BEGIN strDay := '31st' END;

        IF lMonth = 1 THEN BEGIN StrMonth := ' January ' END;
        IF lMonth = 2 THEN BEGIN StrMonth := ' February ' END;
        IF lMonth = 3 THEN BEGIN StrMonth := ' March ' END;
        IF lMonth = 4 THEN BEGIN StrMonth := ' April ' END;
        IF lMonth = 5 THEN BEGIN StrMonth := ' May ' END;
        IF lMonth = 6 THEN BEGIN StrMonth := ' June ' END;
        IF lMonth = 7 THEN BEGIN StrMonth := ' July ' END;
        IF lMonth = 8 THEN BEGIN StrMonth := ' August ' END;
        IF lMonth = 9 THEN BEGIN StrMonth := ' September ' END;
        IF lMonth = 10 THEN BEGIN StrMonth := ' October ' END;
        IF lMonth = 11 THEN BEGIN StrMonth := ' November ' END;
        IF lMonth = 12 THEN BEGIN StrMonth := ' December ' END;

        strYear := FORMAT(lYear);
        //return the date
        strDate := strDay + StrMonth + strYear;
    end;


    procedure DetermineAge_Years(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        IF ((DateOfBirth <> 0D) AND (DateOfJoin <> 0D)) THEN BEGIN
            dayB := DATE2DMY(DateOfBirth, 1);
            monthB := DATE2DMY(DateOfBirth, 2);
            yearB := DATE2DMY(DateOfBirth, 3);
            dayJ := DATE2DMY(DateOfJoin, 1);
            monthJ := DATE2DMY(DateOfJoin, 2);
            yearJ := DATE2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            CASE (DateCat) OF
                1:
                    BEGIN
                        Year := yearJ - yearB;
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        END;

                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            END;

                        AgeString := '%1';
                        AgeString := STRSUBSTNO(AgeString, Year);

                    END;

                2, 3, 7:
                    BEGIN
                        IF (monthJ <> monthB) THEN BEGIN
                            IF monthJ >= monthB THEN
                                Month := monthJ - monthB;
                            // ELSE ERROR('The wrong date category!');
                        END;

                        IF (dayJ <> dayB) THEN BEGIN
                            IF (dayJ >= dayB) THEN
                                Day := dayJ - dayB
                            ELSE
                                IF (dayJ < dayB) THEN BEGIN
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                END;
                        END;

                        AgeString := '%1  Months %2 Days';
                        AgeString := STRSUBSTNO(AgeString, Month, Day);
                    END;
                4:
                    BEGIN
                        Year := yearJ - yearB;
                        AgeString := '#1##';
                        AgeString := STRSUBSTNO(AgeString, Year);
                    END;
                5:
                    BEGIN
                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            END;

                        Year := yearJ - yearB;
                        AgeString := '%1';
                        AgeString := STRSUBSTNO(AgeString, Year);
                    END;
                6:
                    BEGIN
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        END;
                        Year := yearJ - yearB;
                        AgeString := '%1';
                        AgeString := STRSUBSTNO(AgeString, Year, Month);
                    END;
                ELSE
                    AgeString := '';
            END;
        END ELSE
            MESSAGE('For Date Calculation Enter All Applicable Dates!');
        EXIT;
    end;
}
