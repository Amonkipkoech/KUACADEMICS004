report 51605 "KCA Get Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA Get Registration.rdl';

    dataset
    {
        dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
        {
            DataItemTableView = SORTING("Receipt No");
            RequestFilterFields = "Receipt No", Description, Date;
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
            column(Receipt_Items__Receipt_No_; "Receipt No")
            {
            }
            column(Receipt_Items_Code; Code)
            {
            }
            column(Receipt_Items_Description; Description)
            {
            }
            column(Receipt_Items_Amount; Amount)
            {
            }
            column(Receipt_Items_Balance; Balance)
            {
            }
            column(Receipt_Items_Date; Date)
            {
            }
            column(Receipt_Items_Programme; Programme)
            {
            }
            column(Receipt_Items_Stage; Stage)
            {
            }
            column(Receipt_Items_Unit; Unit)
            {
            }
            column(Receipt_Items_Semester; Semester)
            {
            }
            column(Receipt_Items__Settlement_Type_; "Settlement Type")
            {
            }
            column(Receipt_ItemsCaption; Receipt_ItemsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt_Items__Receipt_No_Caption; FIELDCAPTION("Receipt No"))
            {
            }
            column(Receipt_Items_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Receipt_Items_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Receipt_Items_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Receipt_Items_BalanceCaption; FIELDCAPTION(Balance))
            {
            }
            column(Receipt_Items_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt_Items_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Receipt_Items_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Receipt_Items_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Receipt_Items_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Receipt_Items__Settlement_Type_Caption; FIELDCAPTION("Settlement Type"))
            {
            }
            column(Receipt_Items_Uniq_No_2; "Uniq No 2")
            {
            }
            column(Receipt_Items_Transaction_ID; "Transaction ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Rcpt.GET("ACA-Receipt Items"."Receipt No") THEN BEGIN
                    StudCharges.SETCURRENTKEY(StudCharges."Student No.", StudCharges.Code, StudCharges."Tuition Fee");
                    StudCharges.SETRANGE(StudCharges."Student No.", Rcpt."Student No.");
                    StudCharges.SETRANGE(StudCharges.Code, "ACA-Receipt Items".Code);
                    StudCharges.SETRANGE(StudCharges."Tuition Fee", TRUE);
                    IF StudCharges.FIND('-') THEN BEGIN
                        "ACA-Receipt Items".Programme := StudCharges.Programme;
                        "ACA-Receipt Items".Stage := StudCharges.Stage;
                        "ACA-Receipt Items".Unit := StudCharges.Unit;
                        "ACA-Receipt Items".Semester := StudCharges.Semester;
                        "ACA-Receipt Items"."Transaction ID" := StudCharges."Transacton ID";
                        "ACA-Receipt Items".MODIFY;

                    END;
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
        Rcpt: Record 61538;

        StudCharges: Record 61535;
        Receipt_ItemsCaptionLbl: Label 'Receipt Items';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

