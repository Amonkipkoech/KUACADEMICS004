/* report 60005 "Receipts Reports 22"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts Reports 22.rdl';

    dataset
    {
        dataitem(DataItem1102755004; 61723)
        {
            RequestFilterFields = "No.";
            column(HeaderNo; "No.")
            {
            }
            column(HeaderDate; Date)
            {
            }
            column(UserID; Cashier)
            {
            }
            column(AcctName; AcctName)
            {
            }
            column(RegNo; "Student/staff No")
            {
            }
            column(rec; "Received From")
            {
            }
            column(remark; Remarks)
            {
            }
            dataitem(DataItem1102755006; 61717)
            {
                DataItemLink = "No." = FIELD("No.");
                column(RecLineNo; "Account No.")
                {
                }
                column(RecLineAcctName; "Transaction Name")
                {
                }
                column(Amount; Amount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(PayMode; "Pay Mode")
                {
                }
                column(ReceivedFrom; "Received From")
                {
                }
                column(Cheque; "Cheque/Deposit Slip No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAmount := TotalAmount + Amount;

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText2('', TotalAmount, '');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
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
        AcctName: Text[150];
        RegNo: Code[30];
        NumberText: array[2] of Text[1024];
        CheckReport: Report 1401;
        TotalAmount: Decimal;
} */

