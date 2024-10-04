report 51588 "Stage Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Stage Charges.rdl';

    dataset
    {
        dataitem("ACA-Stage Charges"; "ACA-Stage Charges")
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code);
            RequestFilterFields = "Programme Code", "Stage Code";
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
            column(Stage_Charges_Semester; Semester)
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
            column(Stage_Charges_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Stage_Charges_Settlement_Type; "Settlement Type")
            {
            }
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
        Stage_ChargesCaptionLbl: Label 'Stage Charges';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

