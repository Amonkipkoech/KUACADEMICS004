report 66658 "ACA-Cumm. Resit List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Cumm. Resit List.rdl';

    dataset
    {
        dataitem(GradStuds; "ACA-Exam Classification Studs")
        {
            RequestFilterFields = "School Code", Programme, "Academic Year";
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(Phone; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(HomePage; CompanyInformation."Home Page")
            {
            }
            dataitem(CummResits; "ACA-Exam Cummulative Resit")
            {
                DataItemLink = "Student Number" = FIELD("Student Number");
                column(StudNo; CummResits."Student Number")
                {
                }
                column(Names; CummResits."Student Name")
                {
                }
                column(UnitCode; CummResits."Unit Code")
                {
                }
                column(UnitDesc; CummResits."Unit Description")
                {
                }
                column(Prog; CummResits.Programme)
                {
                }
                column(SchCode; CummResits."School Code")
                {
                }
                column(SchName; CummResits."School Name")
                {
                }
                column(Grade; CummResits.Grade)
                {
                }
            }
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
}

