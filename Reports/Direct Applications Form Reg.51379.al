/// <summary>
/// Report Direct Applications Form Reg (ID 51379).
/// </summary>
report 51379 "Direct Applications Form Reg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/DirectApplicationsFormReg.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; 61358)
        {
            DataItemTableView = SORTING("Application No.");
            RequestFilterFields = Status;
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
            column(Application_Form_Header__Application_No__; "Application No.")
            {
            }
            column(Application_Form_Header__Issued_Date_; "Issued Date")
            {
            }
            column(Application_Form_Header__Surname__________Other_Names_; "ACA-Applic. Form Header".Surname + ' ' + "Other Names")
            {
            }
            column(Application_Form_Header__Receipt_Slip_No__; "Receipt Slip No.")
            {
            }
            column(Application_Form_Header__Application_Date_; "Application Date")
            {
            }
            column(RecNo; RecNo)
            {
            }
            column(Direct_Application_Form_RegisterCaption; Direct_Application_Form_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Application_Form_Header__Application_No__Caption; FIELDCAPTION("Application No."))
            {
            }
            column(Application_Form_Header__Issued_Date_Caption; FIELDCAPTION("Issued Date"))
            {
            }
            column(Name_of_ApplicantCaption; Name_of_ApplicantCaptionLbl)
            {
            }
            column(Application_Form_Header__Receipt_Slip_No__Caption; FIELDCAPTION("Receipt Slip No."))
            {
            }
            column(Return_DateCaption; Return_DateCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(KshsCaption; KshsCaptionLbl)
            {
            }
            column(GRDCaption; GRDCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecNo := RecNo + 1;
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
        RecNo: Integer;
        Direct_Application_Form_RegisterCaptionLbl: Label 'Direct Application Form Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Name_of_ApplicantCaptionLbl: Label 'Name of Applicant';
        Return_DateCaptionLbl: Label 'Return Date';
        No_CaptionLbl: Label 'No.';
        KshsCaptionLbl: Label 'Kshs';
        GRDCaptionLbl: Label 'GRD';
}

