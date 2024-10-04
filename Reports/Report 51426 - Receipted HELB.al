report 51426 "Receipted HELB"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipted HELB.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Student No.")
                                ORDER(Ascending)
                                WHERE("Payment Mode" = CONST(HELB));
            RequestFilterFields = "Payment By", "Student No.";
            column(userName; userName)
            {
            }
            column(dateToday; dateToday)
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
            column(Receipt__Payment_By_; "Payment By")
            {
            }
            column(Receipt__User_ID_; "User ID")
            {
            }
            column(Receipt_Amount_Control1102760017; Amount)
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
            column(Receipt__Payment_By_Caption; FIELDCAPTION("Payment By"))
            {
            }
            column(Receipt__User_ID_Caption; FIELDCAPTION("User ID"))
            {
            }
            column(Receipted_HELBCaption; Receipted_HELBCaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                userName := USERID;
                dateToday := TODAY;
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
        userName: Code[20];
        dateToday: Date;
        Receipted_HELBCaptionLbl: Label 'Receipted HELB';
}

