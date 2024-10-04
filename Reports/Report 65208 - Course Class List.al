/// <summary>
/// Report Course Class List (ID 65208).
/// </summary>
report 65208 "Course Class List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Class List.rdl';

    dataset
    {
        dataitem(DataItem1000000009; 61511)
        {
            DataItemTableView = SORTING(Code)
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone1; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompPage; CompanyInformation."Home Page")
            {
            }
            column(CompPin; CompanyInformation."Company P.I.N")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(progName; Description)
            {
            }
            column(faculty; Faculty)
            {
            }
            column(Semester; sems)
            {
            }
            column(ProgCode; code)
            {
            }
            dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                DataItemTableView = SORTING(Code, "Programme Code", "Stage Code", "Entry No")
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                column(UnitDesc; Desription)
                {
                }
                column(UnitCode; Code)
                {
                }
                dataitem("ACA-Student Units"; "ACA-Student Units")
                {
                    DataItemLink = Programme = FIELD("Programme Code"),
                                   Unit = FIELD(Code);
                    DataItemTableView = SORTING("Student No.", Unit)
                                        ORDER(Ascending)
                                        WHERE(Reversed = FILTER('No'));
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = Programme, Stage, Unit;

                    column(GroupingConcortion; Programme + semester + Unit)
                    {
                    }
                    column(Student_No_; "Student No.")
                    {
                    }
                    column(Student_Name; "Student Name")
                    {
                    }
                    // column(seq;seq)
                    // {
                    // }

                    trigger OnAfterGetRecord()
                    begin

                        CLEAR("Student No.");
                        IF customer.GET("Student No.") then
                            "Student No." := "Student Name";

                        seq := seq + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(seq);
                        "ACA-Student Units".SETFILTER("ACA-Student Units".Semester, sems);
                        CLEAR(filters);
                        filters := ACAUnitsSubjects.GETFILTERS;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SemFilter; sems)
                {
                    Caption = 'Semester Filter';
                    TableRelation = "ACA-Semester".Code;
                    ApplicationArea = All;
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

    trigger OnInitReport()
    begin
        IF CompanyInformation.GET() THEN
            //  CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
            CLEAR(Gtoto);
        CLEAR(seq);
        ACASemesters.RESET;
        ACASemesters.SETRANGE("Current Semester", TRUE);
        IF ACASemesters.FIND('-') THEN BEGIN
            sems := ACASemesters.Code;
        END;
    end;

    trigger OnPreReport()
    begin

        IF sems = '' THEN ERROR('Specify a Semester');
    end;

    var
        CompanyInformation: Record 79;
        Gtoto: Decimal;
        seq: Integer;
        StudName: Code[150];
        Customer: Record 18;
        HRMEmployeeC: Record 61188;
        LectName: Text[220];
        progName: Code[150];
        ACAProgramme: Record 61511;
        ACAUnitsSubjects: Record 61517;
        sems: Code[20];
        ACASemesters: Record 61692;
        filters: Text[1024];
}

