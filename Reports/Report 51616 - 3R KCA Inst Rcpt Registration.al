report 51616 "3R KCA Inst Rcpt Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/3R KCA Inst Rcpt Registration.rdl';

    dataset
    {
        dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
        {
            DataItemTableView = SORTING("Receipt No");
            RequestFilterFields = "Transaction ID";
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
            column(Receipt_Items_Uniq_No_2; "Uniq No 2")
            {
            }
            column(Receipt_Items_Transaction_ID; "Transaction ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                StudCharges.RESET;
                StudCharges.SETCURRENTKEY(StudCharges."Transacton ID", StudCharges."Student No.");
                StudCharges.SETRANGE(StudCharges."Student No.", "ACA-Receipt Items"."Student No.");
                StudCharges.SETRANGE(StudCharges."Transacton ID", "ACA-Receipt Items"."Transaction ID");
                IF StudCharges.FIND('-') THEN BEGIN
                    "ACA-Receipt Items".Code := StudCharges.Code;
                    "ACA-Receipt Items".Programme := StudCharges.Programme;
                    "ACA-Receipt Items".Stage := StudCharges.Stage;
                    "ACA-Receipt Items".Unit := StudCharges.Unit;
                    "ACA-Receipt Items".Semester := StudCharges.Semester;
                    "ACA-Receipt Items".MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //"Receipt Items".MODIFYALL("Receipt Items"."Transaction ID",'');
                //"Receipt Items".MODIFYALL("Receipt Items"."Student No.",'');
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

