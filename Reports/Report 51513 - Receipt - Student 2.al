report 51513 "Receipt - Student 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipt - Student 2.rdl';

    dataset
    {
        dataitem("ACA-Receipt"; "ACA-Receipt")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.";
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Receipt_Date; Date)
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Names; Names)
            {
            }
            column(TIME; TIME)
            {
            }
            column(CPA_Center__Thika_RdCaption; CPA_Center__Thika_RdCaptionLbl)
            {
            }
            dataitem("ACA-Receipt Items"; "ACA-Receipt Items")
            {
                DataItemLink = "Receipt No" = FIELD("Receipt No.");
                column(Receipt_Items_Balance; Balance)
                {
                }
                column(Receipt_Items_Amount; Amount)
                {
                }
                column(Receipt_Items_Description; Description)
                {
                }
                column(Receipt_Items_Code; Code)
                {
                }
                column(Receipt_Items_Receipt_No; "Receipt No")
                {
                }
                column(Receipt_Items_Uniq_No_2; "Uniq No 2")
                {
                }
                column(Receipt_Items_Transaction_ID; "Transaction ID")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Cust.RESET;
                IF Cust.GET("ACA-Receipt"."Student No.") THEN BEGIN
                    Cust.CALCFIELDS(Cust.Balance);
                    Names := Cust.Name;
                END;

                //CheckReport.InitTextVariable;
                //CheckReport.FormatNoText(NumberText,Receipt.Amount,'KSH');
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
        Cust: Record 18;
        Names: Text[200];
        AmountWords: Text[250];

        NumberText: Text[250];
        CPA_Center__Thika_RdCaptionLbl: Label 'CPA Center -Thika Rd';
}

