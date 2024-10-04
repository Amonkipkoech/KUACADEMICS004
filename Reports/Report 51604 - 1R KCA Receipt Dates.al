report 51604 "1R KCA Receipt Dates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/1R KCA Receipt Dates.rdlc';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = Date;
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
            column(Receipt__No__Series_; "No. Series")
            {
            }
            column(Receipt__Payment_By_; "Payment By")
            {
            }
            column(Receipt__User_ID_; "User ID")
            {
            }
            column(Receipt__Transaction_Date_; "Transaction Date")
            {
            }
            column(Receipt__Transaction_Time_; "Transaction Time")
            {
            }
            column(Receipt__Student_Name_; "Student Name")
            {
            }
            column(Receipt__KCA_Rcpt_No_; "KCA Rcpt No")
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
            column(Receipt__No__Series_Caption; FIELDCAPTION("No. Series"))
            {
            }
            column(Receipt__Payment_By_Caption; FIELDCAPTION("Payment By"))
            {
            }
            column(Receipt__User_ID_Caption; FIELDCAPTION("User ID"))
            {
            }
            column(Receipt__Transaction_Date_Caption; FIELDCAPTION("Transaction Date"))
            {
            }
            column(Receipt__Transaction_Time_Caption; FIELDCAPTION("Transaction Time"))
            {
            }
            column(Receipt__Student_Name_Caption; FIELDCAPTION("Student Name"))
            {
            }
            column(Receipt__KCA_Rcpt_No_Caption; FIELDCAPTION("KCA Rcpt No"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RcptItems.RESET;
                RcptItems.SETCURRENTKEY(RcptItems."Receipt No");
                RcptItems.SETRANGE(RcptItems."Receipt No", "ACA-Receipt"."Receipt No.");
                IF RcptItems.FIND('-') THEN BEGIN
                    //RcptItems.MODIFYALL(RcptItems."Student No.",Receipt."Student No.");
                    RcptItems.MODIFYALL(RcptItems.Date, "ACA-Receipt".Date);
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
        RcptItems: Record 61539;
        ReceiptCaptionLbl: Label 'Receipt';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

