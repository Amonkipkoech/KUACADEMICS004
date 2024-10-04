report 81801 "Programme Stages Dept"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Programme Stages Dept.rdl';

    dataset
    {
        dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
        {
            RequestFilterFields = "Programme Code";
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
            column(Programme_Stages__Programme_Code_; "Programme Code")
            {
            }
            column(Programme_Stages_Code; Code)
            {
            }
            column(Programme_Stages_Description; Description)
            {
            }
            column(Programme_Stages__G_L_Account_; "G/L Account")
            {
            }
            column(Programme_Stages_Department; Department)
            {
            }
            column(Programme_Stages_Remarks; Remarks)
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
            column(Programme_Stages_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_Stages__G_L_Account_Caption; FIELDCAPTION("G/L Account"))
            {
            }
            column(Programme_Stages_DepartmentCaption; FIELDCAPTION(Department))
            {
            }
            column(Programme_Stages_RemarksCaption; FIELDCAPTION(Remarks))
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF Prog.GET("ACA-Programme Stages"."Programme Code") THEN BEGIN
                //"ACA-Programme Stages".Department:=Prog."School Code";
                "ACA-Programme Stages"."Include in Time Table" := FALSE;
                "ACA-Programme Stages".MODIFY;
                //END;
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
        Prog: Record 61511;
        Programme_StagesCaptionLbl: Label 'Programme Stages';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

