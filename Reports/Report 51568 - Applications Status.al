report 51568 "Applications Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Applications Status.rdl';

    dataset
    {
        dataitem("ACA-Enquiry Header"; "ACA-Enquiry Header")
        {
            DataItemTableView = SORTING(Programmes, "Registrar Approved");
            RequestFilterFields = Programmes, "Registrar Approved";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Enquiry_Header_Programme; Programmes)
            {
            }
            column(Enquiry_Header__Registrar_Approved_; "Registrar Approved")
            {
            }
            column(Enquiry_Header_Semester; Semester)
            {
            }
            column(Enquiry_Header_Status; Status)
            {
            }
            column(Enquiry_Header__Programme_Stage_; "Programme Stage")
            {
            }
            column(Enquiry_Header_Programme_Control1102760014; Programmes)
            {
            }
            column(Enquiry_Header__Passport_National_ID_Number_; "Passport/National ID Number")
            {
            }
            column(Enquiry_Header__Name_Surname_First__; "Name(Surname First)")
            {
            }
            column(Enquiry_Header__Enquiry_Date_; "Enquiry Date")
            {
            }
            column(Enquiry_Header__Enquiry_No__; "Enquiry No.")
            {
            }
            column(Enquiry_HeaderCaption; Enquiry_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Enquiry_Header_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Enquiry_Header__Registrar_Approved_Caption; FIELDCAPTION("Registrar Approved"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(ID_NumberCaption; ID_NumberCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(StageCaption; StageCaptionLbl)
            {
            }
            column(Semester_IntakeCaption; Semester_IntakeCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Application_DateCaption; Application_DateCaptionLbl)
            {
            }
            column(Application_No_Caption; Application_No_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Registrar Approved");
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
        Enquiry_HeaderCaptionLbl: Label 'Enquiry Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
        ID_NumberCaptionLbl: Label 'ID Number';
        ProgrammeCaptionLbl: Label 'Programme';
        StageCaptionLbl: Label 'Stage';
        Semester_IntakeCaptionLbl: Label 'Semester/Intake';
        StatusCaptionLbl: Label 'Status';
        Application_DateCaptionLbl: Label 'Application Date';
        Application_No_CaptionLbl: Label 'Application No.';
}

