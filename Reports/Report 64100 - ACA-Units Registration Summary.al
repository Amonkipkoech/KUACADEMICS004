report 64100 "ACA-Units Registration Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Units Registration Summary.rdl';

    dataset
    {
        dataitem(Progy; "ACA-Programme")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "School Code";
            dataitem(CosReg; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = WHERE(Reversed = FILTER(false));
                RequestFilterFields = "Student No.", Semester, Programmes;
                column(CustNo; Cust."No.")
                {
                }
                column(CustName; Cust.Name)
                {
                }
                column(ProDescription; Progy.Description)
                {
                }
                column(ProgCode; Progy.Code)
                {
                }
                column(School; Progy."School Code")
                {
                }
                column(CountedUnts; StudUnits.COUNT)
                {
                }
                column(FacultyFilters; FacultyFilters)
                {
                }
                column(AcadYear; CosReg."Academic Year")
                {
                }
                column(SemCode; ACASemesters.Code)
                {
                }
                column(SemDesc; ACASemesters.Description)
                {
                }
                column(UnitsCodes; UnitsCodes)
                {
                }
                column(SchoolName; DimensionValue.Name)
                {
                }
                column(FacultyNumbers; FacultyNumbers)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(UnitsCodes);
                    ACASemesters.RESET;
                    ACASemesters.SETRANGE(Code, CosReg.Semester);
                    IF ACASemesters.FIND('-') THEN;
                    Cust.RESET;
                    Cust.SETRANGE("No.", CosReg."Student No.");
                    IF Cust.FIND('-') THEN;
                    StudUnits.RESET;
                    StudUnits.SETRANGE("Student No.", CosReg."Student No.");
                    StudUnits.SETRANGE(Semester, CosReg.Semester);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF UnitsCodes = '' THEN
                                UnitsCodes := StudUnits.Unit
                            ELSE
                                UnitsCodes := UnitsCodes + ',' + StudUnits.Unit;
                        END;
                        UNTIL StudUnits.NEXT = 0;
                        FacultyNumbers := 1;
                    END ELSE
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF CosReg.GETFILTERS = '' THEN ERROR('Specify Semester Filter');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DimensionValue.SETRANGE(Code, Progy."School Code");
                DimensionValue.SETRANGE("Dimension Code", 'FACULTY');
                IF DimensionValue.FIND('-') THEN;
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
        UnitsCodes: Code[1024];

        FacultyFilters: Text[1024];
        ACASemesters: Record 61692;
        DimensionValue: Record 349;
        Cust: Record 18;
        StudUnits: Record 61549;
        FacultyNumbers: Integer;
}

