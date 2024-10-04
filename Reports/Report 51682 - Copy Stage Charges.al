/// <summary>
/// Report Copy Stage Charges (ID 51682).
/// </summary>
report 51682 "Copy Stage Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Copy Stage Charges.rdl';

    dataset
    {
        dataitem(DataItem6690; 61533)
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code);
            RequestFilterFields = "Programme Code";
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
            column(Stage_Charges__Programme_Code_; "Programme Code")
            {
            }
            column(Stage_Charges__Stage_Code_; "Stage Code")
            {
            }
            column(Stage_Charges_Code; Code)
            {
            }
            column(Stage_Charges_Description; Description)
            {
            }
            column(Stage_Charges_Amount; Amount)
            {
            }
            column(Stage_ChargesCaption; Stage_ChargesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Stage_Charges__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Stage_Charges__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Stage_Charges_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Stage_Charges_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Stage_Charges_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Stage_Charges_Settlement_Type; "Settlement Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                StageCharges.INIT;
                StageCharges."Programme Code" := 'DPITNEW07';
                StageCharges."Stage Code" := "Stage Code";
                StageCharges.Code := Code;
                StageCharges.Description := Description;
                StageCharges.Amount := Amount;
                StageCharges.Remarks := Remarks;
                StageCharges."Recovered First" := "Recovered First";
                StageCharges.Semester := Semester;
                StageCharges."Student Type" := "Student Type";
                StageCharges.INSERT;
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
        StageCharges: Record 61533;
        Stage_ChargesCaptionLbl: Label 'Stage Charges';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

