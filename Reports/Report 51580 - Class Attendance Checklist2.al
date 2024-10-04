report 51580 "Class Attendance Checklist2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Class Attendance Checklist2.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = SORTING("Student No.", Unit)
                                ORDER(Ascending)
                                WHERE("Reg Reversed" = FILTER(false));
            RequestFilterFields = Programme, Unit, Semester;
            column(Progs; "ACA-Student Units".Programme)
            {
            }
            column(Stages; "ACA-Student Units".Stage)
            {
            }
            column(StudUnitCode; "ACA-Student Units".Unit)
            {
            }
            column(SemesterFilter; "ACA-Student Units".GETFILTER("ACA-Student Units".Semester))
            {
            }
            column(Semz; "ACA-Student Units".Semester)
            {
            }
            column(StudNo; "ACA-Student Units"."Student No.")
            {
            }
            column(AcadYear; "ACA-Student Units"."Academic Year")
            {
            }
            column(Bal; "ACA-Student Units"."Balance Due")
            {
            }
            column(UnitName; UnitDesc)
            {
            }
            column(ProgName; ACAProgramme.Description)
            {
            }
            column(RCount; ACACountExamAttendance."Counted Students")
            {
            }
            column(Names; Names)
            {
            }
            column(Name1; CompanyInformation.Name)
            {
            }
            column(Name2; CompanyInformation."Name 2")
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Phone; CompanyInformation."Phone No.")
            {
            }
            column(Phone2; CompanyInformation."Phone No. 2")
            {
            }
            column(Emails; CompanyInformation."E-Mail")
            {
            }
            column(homep; CompanyInformation."Home Page")
            {
            }
            column(logo; CompanyInformation.Picture)
            {
            }
            column(UName; UnitsSubj.Desription)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ACAStudentUnits.CALCFIELDS("Balance Due");
                CLEAR(UnitDesc);
                CLEAR(UnitNo);
                UnitsSubj.RESET;
                UnitsSubj.SETRANGE(UnitsSubj."Programme Code", "ACA-Student Units".Programme);
                UnitsSubj.SETRANGE(UnitsSubj.Code, "ACA-Student Units".Unit);
                IF UnitsSubj.FIND('-') THEN BEGIN
                    UnitDesc := UnitsSubj.Desription;
                    UnitNo := UnitsSubj."No. Units";
                END;
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "ACA-Student Units".Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN
                END;
                /*
                RCount:=RCount+1;
                GCount:=GCount+1;*/
                Names := '';

                IF Cust.GET("ACA-Student Units"."Student No.") THEN
                    Names := Cust.Name;

                ACACountExamAttendance.RESET;
                ACACountExamAttendance.SETRANGE("User Name", USERID);
                ACACountExamAttendance.SETRANGE(Programme, "ACA-Student Units".Programme);
                ACACountExamAttendance.SETRANGE(Semester, "ACA-Student Units".Semester);
                ACACountExamAttendance.SETRANGE("Unit Code", "ACA-Student Units".Unit);
                ACACountExamAttendance.SETRANGE("Student No.", "ACA-Student Units"."Student No.");
                IF ACACountExamAttendance.FIND('-') THEN;

            end;

            trigger OnPreDataItem()
            begin
                ACAStudentUnits.CALCFIELDS("Balance Due");
                CLEAR(RunningCount);

                ACACountExamAttendance.RESET;
                ACACountExamAttendance.SETRANGE("User Name", USERID);
                IF ACACountExamAttendance.FIND('-') THEN ACACountExamAttendance.DELETEALL;
                ACAStudentUnits.RESET;
                IF "ACA-Student Units".GETFILTER("ACA-Student Units".Programme) <> '' THEN
                    ACAStudentUnits.SETRANGE(Programme, "ACA-Student Units".GETFILTER("ACA-Student Units".Programme));
                IF "ACA-Student Units".GETFILTER("ACA-Student Units".Semester) <> '' THEN
                    ACAStudentUnits.SETRANGE(Semester, "ACA-Student Units".GETFILTER("ACA-Student Units".Semester));
                IF "ACA-Student Units".GETFILTER("ACA-Student Units".Unit) <> '' THEN
                    ACAStudentUnits.SETRANGE(Unit, "ACA-Student Units".GETFILTER("ACA-Student Units".Unit));
                ACAStudentUnits.SETCURRENTKEY("Student No.", Unit);
                IF ACAStudentUnits.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        CLEAR(RunningCount);
                        ACACountExamAttendance.RESET;
                        ACACountExamAttendance.SETRANGE("User Name", USERID);
                        ACACountExamAttendance.SETRANGE(Programme, ACAStudentUnits.Programme);
                        ACACountExamAttendance.SETRANGE(Semester, ACAStudentUnits.Semester);
                        ACACountExamAttendance.SETRANGE("Unit Code", ACAStudentUnits.Unit);
                        IF ACACountExamAttendance.FIND('+') THEN RunningCount := ACACountExamAttendance."Counted Students";
                        RunningCount := RunningCount + 1;
                        ACACountExamAttendance.RESET;
                        ACACountExamAttendance.SETRANGE("User Name", USERID);
                        ACACountExamAttendance.SETRANGE(Programme, ACAStudentUnits.Programme);
                        ACACountExamAttendance.SETRANGE(Semester, ACAStudentUnits.Semester);
                        ACACountExamAttendance.SETRANGE("Unit Code", ACAStudentUnits.Unit);
                        ACACountExamAttendance.SETRANGE("Student No.", ACAStudentUnits."Student No.");
                        IF NOT (ACACountExamAttendance.FIND('-')) THEN BEGIN
                            ACACountExamAttendance.INIT;
                            ACACountExamAttendance."User Name" := USERID;
                            ACACountExamAttendance.Programme := ACAStudentUnits.Programme;
                            ACACountExamAttendance."Unit Code" := ACAStudentUnits.Unit;
                            ACACountExamAttendance.Semester := ACAStudentUnits.Semester;
                            ACACountExamAttendance."Student No." := ACAStudentUnits."Student No.";
                            ACACountExamAttendance."Counted Students" := RunningCount;
                            ACACountExamAttendance.INSERT;
                        END;
                    END;
                    UNTIL ACAStudentUnits.NEXT = 0;
                END;
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
        RCount: Integer;
        Cust: Record 18;
        Names: Text[200];
        DValue: Record 349;

        FDesc: Text[200];
        Dept: Text[200];
        UnitDesc: Text[100];
        UnitNo: Decimal;
        UnitsSubj: Record 61517;
        GCount: Integer;
        ACAProgramme: Record 61511;
        ACACountExamAttendance: Record 77730;
        ACAStudentUnits: Record 61549;
        RunningCount: Integer;
        CompanyInformation: Record 79;
}

