report 51602 "KCA Set as recovered first"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA Set as recovered first.rdl';

    dataset
    {
        dataitem("ACA-Charge"; "ACA-Charge")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Recover First";
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
            column(Charge_Code; Code)
            {
            }
            column(Charge_Description; Description)
            {
            }
            column(Charge_Amount; Amount)
            {
            }
            column(Charge__Recover_First_; "Recover First")
            {
            }
            column(ChargeCaption; ChargeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Charge_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Charge_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Charge_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Charge__Recover_First_Caption; FIELDCAPTION("Recover First"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                StudCharges.RESET;
                StudCharges.SETRANGE(StudCharges.Code, "ACA-Charge".Code);
                IF StudCharges.FIND('-') THEN BEGIN
                    StudCharges.MODIFYALL(StudCharges."Recovered First", TRUE);
                END;
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
        StudCharges: Record 61535;
        ChargeCaptionLbl: Label 'Charge';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

