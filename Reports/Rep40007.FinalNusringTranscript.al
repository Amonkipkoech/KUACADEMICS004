report 40007 "FinalNusring Transcript"
{
    Caption = 'FinalNusring Transcript';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/NursingTranscrip.rdl';

    dataset
    {
        dataitem("Semester Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.";
            column(StudNo; "Student No.")
            {
            }
            column(infoName; info.Name)
            {
            }
            column(infoAddress; info.Address)
            {
            }
            column(infoAddress2; info."Address 2")
            {
            }
            column(infoCity; info.City)
            {
            }
            column(infoEmail; info."E-Mail")
            {
            }
            column(infoPhone; info."Phone No.")
            {
            }

            column(Sem; '')
            {
            }
            column(Stag; '')
            {
            }
            column(CumSc; '')
            {
            }
            column(CurrSem; '')
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }

            dataitem(StudUnitsss2; "ACA-Student Theory Units ")
            {
                DataItemLink = "Student No." = FIELD("Student No.");
                column(Unit2; unit)
                {
                }
                column(Desc2; "Unit Description")
                {
                }
                column(CreditHours2; "Credit Hours")
                {
                }

            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        info: Record "Company Information";
        CompanyInformation: Record 79;
}
