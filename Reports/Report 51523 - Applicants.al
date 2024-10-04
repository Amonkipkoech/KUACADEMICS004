report 51523 Applicants
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Applicants.rdl';

    dataset
    {
        dataitem("ACA-Enquiry Header"; "ACA-Enquiry Header")
        {
            DataItemTableView = SORTING("Enquiry No.");
            RequestFilterFields = "Enquiry No.";
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
            column(Enquiry_Header__Enquiry_No__; "Enquiry No.")
            {
            }
            column(Enquiry_Header__Enquiry_Date_; "Enquiry Date")
            {
            }
            column(Enquiry_Header__Name_Surname_First__; "Name(Surname First)")
            {
            }
            column(Enquiry_Header_Programme; Programmes)
            {
            }
            column(Enquiry_Header__Programme_Stage_; "Programme Stage")
            {
            }
            column(Enquiry_Header_Semester; Semester)
            {
            }
            column(Enquiry_Header_Status; Status)
            {
            }
            column(KSPS_Enquiry_HeaderCaption; KSPS_Enquiry_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Enquiry_Header__Enquiry_No__Caption; FIELDCAPTION("Enquiry No."))
            {
            }
            column(Enquiry_Header__Enquiry_Date_Caption; FIELDCAPTION("Enquiry Date"))
            {
            }
            column(Enquiry_Header__Name_Surname_First__Caption; FIELDCAPTION("Name(Surname First)"))
            {
            }
            column(Enquiry_Header_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Enquiry_Header__Programme_Stage_Caption; FIELDCAPTION("Programme Stage"))
            {
            }
            column(Enquiry_Header_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Enquiry_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Enquiry No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        KSPS_Enquiry_HeaderCaptionLbl: Label 'KSPS Enquiry Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

