/// <summary>
/// Report Inst Stud No (ID 51685).
/// </summary>
report 51685 "Inst Stud No"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Inst Stud No.rdl';

    dataset
    {
        dataitem(DataItem5672; 61538)
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Student No.";
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

            trigger OnAfterGetRecord()
            begin
                RcptNo := COPYSTR("Receipt No.", 1, 12);
                CustLedg.RESET;
                CustLedg.SETRANGE(CustLedg."Document No.", RcptNo);
                IF CustLedg.FIND('-') THEN BEGIN
                    "Student No." := CustLedg."Customer No.";
                    //"ACA-Receipt".MODIFY;
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
        CustLedg: Record 21;
        RcptNo: Text[50];
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

