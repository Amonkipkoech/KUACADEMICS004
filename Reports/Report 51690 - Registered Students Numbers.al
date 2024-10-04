/// <summary>
/// Report Registered Students Numbers (ID 51690).
/// </summary>
report 51690 "Registered Students Numbers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Registered Students Numbers.rdl';

    dataset
    {
        dataitem(DataItem3691; 61516)
        {
            CalcFields = "Student Registered";
            DataItemTableView = SORTING("Programme Code", Code);
            RequestFilterFields = "Semester Filter";
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
            column(Programme_Stages__Programme_Code_; "Programme Code")
            {
            }
            column(Programme_Stages_Code; Code)
            {
            }
            column(Programme_Stages__Student_Registered_; "Student Registered")
            {
            }
            column(Hesabu; Hesabu)
            {
            }
            column(Programme_Stages_Paid; Paid)
            {
            }
            column(Kaitet; Kaitet)
            {
            }
            column(Programme_Stages_Paid_Control1000000013; Paid)
            {
            }
            column(Programme_StagesCaption; Programme_StagesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_Stages__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Programme_Stages_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_Stages__Student_Registered_Caption; FIELDCAPTION("Student Registered"))
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(PaidCaption; PaidCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Hesabu := Hesabu + 1;
                Kaitet := Kaitet + "Student Registered";
                Paid := Paid + Paid;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Programme Code");
                Hesabu := 0;
                Kaitet := 0;
                Paid := 0;
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
        Hesabu: Integer;
        Kaitet: Integer;
        Paid: Integer;
        Programme_StagesCaptionLbl: Label 'Programme Stages';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        PaidCaptionLbl: Label 'Paid';
        TotalCaptionLbl: Label 'Total';
}

