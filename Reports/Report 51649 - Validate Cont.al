/// <summary>
/// Report Validate Cont (ID 51649).
/// </summary>
report 51649 "Validate Cont"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Validate Cont.rdl';

    dataset
    {
        dataitem(DataItem6698; 5050)
        {
            DataItemTableView = SORTING("No.");
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
            column(Contact__No__; "No.")
            {
            }
            column(Contact_Name; Name)
            {
            }
            column(Contact__First_Name_; "First Name")
            {
            }
            column(Contact__Middle_Name_; "Middle Name")
            {
            }
            column(Contact__Company_No__; "Company No.")
            {
            }
            column(Contact__Company_Name_; "Company Name")
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Contact__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Contact_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Contact__First_Name_Caption; FIELDCAPTION("First Name"))
            {
            }
            column(Contact__Middle_Name_Caption; FIELDCAPTION("Middle Name"))
            {
            }
            column(Contact__Company_No__Caption; FIELDCAPTION("Company No."))
            {
            }
            column(Contact__Company_Name_Caption; FIELDCAPTION("Company Name"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                // Contact.VALIDATE(Contact."No.");
                // Contact.VALIDATE(Contact.Name);
                // Contact.VALIDATE(Contact."First Name");
                // Contact.VALIDATE(Contact."Middle Name");
                // Contact.VALIDATE(Contact."Company No.");
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
        ContactCaptionLbl: Label 'Contact';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

