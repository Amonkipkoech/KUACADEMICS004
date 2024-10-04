report 51403 "Process Student Patients"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Process Student Patients.rdl';

    dataset
    {
        dataitem("ACA-Adm. Form Header"; "ACA-Adm. Form Header")
        {
            DataItemTableView = SORTING("Admission No.");
            RequestFilterFields = "Admission No.";
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
            column(Admission_Form_Header__Admission_No___Control1102760011; "Admission No.")
            {
            }
            column(Admission_Form_Header_Date; Date)
            {
            }
            column(Admission_Form_Header__Admission_Type_; "Admission Type")
            {
            }
            column(Admission_Form_Header__JAB_S_No_; "JAB S.No")
            {
            }
            column(Admission_Form_Header__Academic_Year_; "Academic Year")
            {
            }
            column(Admission_Form_Header__Application_No__; "Application No.")
            {
            }
            column(Admission_Form_Header_Surname; Surname)
            {
            }
            column(Admission_Form_Header__Other_Names_; "Other Names")
            {
            }
            column(Admission_Form_Header__Faculty_Admitted_To_; "Faculty Admitted To")
            {
            }
            column(Admission_Form_Header__Degree_Admitted_To_; "Degree Admitted To")
            {
            }
            column(Admission_Form_Header__Date_Of_Birth_; "Date Of Birth")
            {
            }
            column(Admission_Form_Header_Gender; Gender)
            {
            }
            column(Admission_Form_Header__Marital_Status_; "Marital Status")
            {
            }
            column(Admission_Form_HeaderCaption; Admission_Form_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Admission_Form_Header__Admission_No___Control1102760011Caption; FIELDCAPTION("Admission No."))
            {
            }
            column(Admission_Form_Header_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Admission_Form_Header__Admission_Type_Caption; FIELDCAPTION("Admission Type"))
            {
            }
            column(Admission_Form_Header__JAB_S_No_Caption; FIELDCAPTION("JAB S.No"))
            {
            }
            column(Admission_Form_Header__Academic_Year_Caption; FIELDCAPTION("Academic Year"))
            {
            }
            column(Admission_Form_Header__Application_No__Caption; FIELDCAPTION("Application No."))
            {
            }
            column(Admission_Form_Header_SurnameCaption; FIELDCAPTION(Surname))
            {
            }
            column(Admission_Form_Header__Other_Names_Caption; FIELDCAPTION("Other Names"))
            {
            }
            column(Admission_Form_Header__Faculty_Admitted_To_Caption; FIELDCAPTION("Faculty Admitted To"))
            {
            }
            column(Admission_Form_Header__Degree_Admitted_To_Caption; FIELDCAPTION("Degree Admitted To"))
            {
            }
            column(Admission_Form_Header__Date_Of_Birth_Caption; FIELDCAPTION("Date Of Birth"))
            {
            }
            column(Admission_Form_Header_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Admission_Form_Header__Marital_Status_Caption; FIELDCAPTION("Marital Status"))
            {
            }
            column(Admission_Form_Header__Admission_No__Caption; FIELDCAPTION("Admission No."))
            {
            }

            trigger OnAfterGetRecord()
            begin
                // HMSPatient.CopyStudentToHMS("ACA-Adm. Form Header");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Admission No.");
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

    trigger OnPreReport()
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."Customer Type", Customer."Customer Type"::Student);
        IF Customer.FIND('-') THEN BEGIN
            REPEAT
            //   HMSPatient.CopyRegisteredStudentToHMS(Customer);
            UNTIL Customer.NEXT = 0;
        END;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        // HMSPatient: Codeunit 50139;
        Customer: Record 18;
        Admission_Form_HeaderCaptionLbl: Label 'Admission Form Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

