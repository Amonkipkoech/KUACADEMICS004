/// <summary>
/// Report Update Reg No (ID 51686).
/// </summary>
report 51686 "Update Reg No"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Reg No.rdl';

    dataset
    {
        dataitem(DataItem5672; 61538)
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.";
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
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt_Date; Date)
            {
            }
            column(Receipt__Payment_Mode_; "Payment Mode")
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(ReceiptCaption; ReceiptCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receipt__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Receipt_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Receipt__Payment_Mode_Caption; FIELDCAPTION("Payment Mode"))
            {
            }
            column(Receipt_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            dataitem(DataItem9528; 61539)
            {
                DataItemLink = "Receipt No" = FIELD("Receipt No.");

                trigger OnAfterGetRecord()
                begin
                    /*
                    IF StudCharges.GET("Receipt Items"."Transaction ID",Receipt."Student No.") THEN BEGIN
                    "Receipt Items"."Reg. No":=StudCharges."Reg. Transacton ID";
                    "Receipt Items".Code:=StudCharges.Code;
                    "Receipt Items".MODIFY;
                    END;
                    */
                    "Student No." := "Student No.";
                    //"ACA-Receipt Items".MODIFY;

                end;
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
        StudCharges: Record 61535;
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

