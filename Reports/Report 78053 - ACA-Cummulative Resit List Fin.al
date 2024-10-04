report 78053 "ACA-Cummulative Resit List Fin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Cummulative Resit List Fin.rdl';

    dataset
    {
        dataitem(ExamCoregcs; 66651)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Academic Year", "School Code", "Year of Study";
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(CompAddress; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Prog; ExamCoregcs.Programme)
            {
            }
            column(YoS; ExamCoregcs."Year of Study")
            {
            }
            column(AcadYear; ExamCoregcs."Academic Year")
            {
            }
            column(SchCode; ExamCoregcs."School Code")
            {
            }
            column(StudentNo; ExamCoregcs."Student Number")
            {
            }
            column(StudName; ExamCoregcs."Student Name")
            {
            }
            column(SchName; ExamCoregcs."School Name")
            {
            }
            column(Class; ExamCoregcs.Classification)
            {
            }
            column(ProgName; ExamCoregcs."Programme Name")
            {
            }
            column(Filters; Filters)
            {
            }
            dataitem(CummResits; 66657)
            {
                DataItemLink = "Student Number" = FIELD("Student Number"),
                               "Academic Year" = FIELD("Academic Year");
                column(UnitCode; CummResits."Unit Code")
                {
                }
                column(UnitDesc; CummResits."Unit Description")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                CLEAR(Filters);
                Filters := ExamCoregcs.GETFILTERS;
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
        Filters: Text[1024];
}

