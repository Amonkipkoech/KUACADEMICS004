report 51366 "Jab Admission List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Jab Admission List.rdl';

    dataset
    {
        dataitem("ACA-Adm. Form Header"; "ACA-Adm. Form Header")
        {
            DataItemTableView = SORTING("Admission No.");
            RequestFilterFields = "Faculty Admitted To", "Degree Admitted To";
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
            column(Admission_Form_Header__Admission_No__; "Admission No.")
            {
            }
            column(Admission_Form_Header__Degree_Admitted_To_; "Degree Admitted To")
            {
            }
            column(Admission_Form_Header_Gender; Gender)
            {
            }
            column(Admission_Form_Header__Index_Number_; "Index Number")
            {
            }
            column(Name; Name)
            {
            }
            column(Admission_Form_HeaderCaption; Admission_Form_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Admission_Form_Header__Admission_No__Caption; FIELDCAPTION("Admission No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Admission_Form_Header__Degree_Admitted_To_Caption; FIELDCAPTION("Degree Admitted To"))
            {
            }
            column(Admission_Form_Header_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Admission_Form_Header__Index_Number_Caption; FIELDCAPTION("Index Number"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Name := "ACA-Adm. Form Header".Surname + ' ' + "ACA-Adm. Form Header"."Other Names";
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
        Name: Text[100];
        Admission_Form_HeaderCaptionLbl: Label 'Admission Form Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
}

