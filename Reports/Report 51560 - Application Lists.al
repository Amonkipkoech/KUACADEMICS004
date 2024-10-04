report 51560 "Application Lists"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Application Lists.rdl';

    dataset
    {
        dataitem(DataItem8879; 61348)
        {
            DataItemTableView = SORTING("Enquiry No.");
            RequestFilterFields = Programmes, Status, "Registrar Approved";
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
            column(Enquiry_Header__Passport_National_ID_Number_; "Passport/National ID Number")
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
            column(Enquiry_Header__Registrar_Approved_; "Registrar Approved")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Aplication_ListCaption; Aplication_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Application_No_Caption; Application_No_CaptionLbl)
            {
            }
            column(Enquiry_Header__Enquiry_Date_Caption; FIELDCAPTION("Enquiry Date"))
            {
            }
            column(Enquiry_Header__Name_Surname_First__Caption; FIELDCAPTION("Name(Surname First)"))
            {
            }
            column(ID_NumberCaption; ID_NumberCaptionLbl)
            {
            }
            column(Enquiry_Header_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Enquiry_Header__Programme_Stage_Caption; FIELDCAPTION("Programme Stage"))
            {
            }
            column(Semester_IntakeCaption; Semester_IntakeCaptionLbl)
            {
            }
            column(Enquiry_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Enquiry_Header__Registrar_Approved_Caption; FIELDCAPTION("Registrar Approved"))
            {
            }
            column(Student_CountsCaption; Student_CountsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Enquiry No.");
                RCount := 0;
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
        RCount: Integer;
        Aplication_ListCaptionLbl: Label 'Aplication List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Application_No_CaptionLbl: Label 'Application No.';
        ID_NumberCaptionLbl: Label 'ID Number';
        Semester_IntakeCaptionLbl: Label 'Semester/Intake';
        Student_CountsCaptionLbl: Label 'Student Counts';
}

