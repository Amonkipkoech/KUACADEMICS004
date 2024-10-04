report 51471 "Suggest Attendance Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Suggest Attendance Entries.rdl';

    dataset
    {
        dataitem("ACA-Time Table"; "ACA-Time Table")
        {
            RequestFilterFields = Programme, Stage, Unit, Semester, "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Time_Table_Programme; Programme)
            {
            }
            column(Time_Table_Stage; Stage)
            {
            }
            column(Time_Table_Unit; Unit)
            {
            }
            column(Time_Table_Semester; Semester)
            {
            }
            column(Time_Table__Day_of_Week_; "Day of Week")
            {
            }
            column(Time_Table_Period; Period)
            {
            }
            column(Time_TableCaption; Time_TableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Time_Table_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Time_Table_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Time_Table_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Time_Table_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Time_Table__Day_of_Week_Caption; FIELDCAPTION("Day of Week"))
            {
            }
            column(Time_Table_PeriodCaption; FIELDCAPTION(Period))
            {
            }
            column(Time_Table_Lecture_Room; "Lecture Room")
            {
            }
            column(Time_Table_Class; Class)
            {
            }
            column(Time_Table_Unit_Class; "Unit Class")
            {
            }
            column(Time_Table_Exam; Exam)
            {
            }
            column(Time_Table_Released; Released)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MinDate := "ACA-Time Table".GETRANGEMIN("ACA-Time Table"."Date Filter");
                MaxDate := "ACA-Time Table".GETRANGEMAX("ACA-Time Table"."Date Filter");
                REPEAT

                    IF DATE2DWY(MinDate, 1) = 1 THEN
                        DayCode := 'MON';
                    IF DATE2DWY(MinDate, 1) = 2 THEN
                        DayCode := 'TUE';
                    IF DATE2DWY(MinDate, 1) = 3 THEN
                        DayCode := 'WED';
                    IF DATE2DWY(MinDate, 1) = 4 THEN
                        DayCode := 'THUR';
                    IF DATE2DWY(MinDate, 1) = 5 THEN
                        DayCode := 'FRI';
                    IF DATE2DWY(MinDate, 1) = 6 THEN
                        DayCode := 'SAT';
                    IF DATE2DWY(MinDate, 1) = 7 THEN
                        DayCode := 'SUN';

                    /* IF DayCode = "ACA-Time Table"."Day of Week" THEN BEGIN
                        IF NOT Actual.GET(MinDate, Programme, Stage, Unit, Semester, Period, "Day of Week", "Lecture Room") THEN BEGIN
                            Actual.INIT;
                            Actual."RFQ No." := "ACA-Time Table".Programme;
                            //Actual."RFQ Line No.":="Time Table".Stage;
                            Actual."Quote No." := "ACA-Time Table".Unit;
                            Actual."Vendor No." := "ACA-Time Table".Semester;
                            Actual."Item No." := "ACA-Time Table".Period;
                            Actual.Description := "ACA-Time Table"."Day of Week";
                            Actual."Unit Of Measure" := "ACA-Time Table"."Lecture Room";
                            //Actual.Total:=MinDate;
                            IF Periods.GET("ACA-Time Table".Period) THEN
                                Actual."Line Amount" := Periods.Hours;
                            Actual.INSERT;

                        END;
                    END; */

                    MinDate := CALCDATE('1D', MinDate);
                UNTIL MinDate > MaxDate
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

    var
        DateFilter: Text[100];
        //Actual: Record 61550;
        TTable: Record 61540;
        MinDate: Date;
        MaxDate: Date;
        DayCode: Code[20];
        Periods: Record 61514;
        Time_TableCaptionLbl: Label 'Time Table';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

