report 86618 "Update bankEntry2"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        dataitem(bankEntry; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Bank Account No.", "Posting Date", "Document No.";
            dataitem(bank; "Bank Account")
            {
                RequestFilterFields = "No.";
                trigger OnAfterGetRecord()
                var
                    banksTrans: Record "Bank Account Ledger Entry";
                begin
                    banksTrans.Reset();
                    banksTrans.SetRange("Bank Account No.", bankEntry."Bank Account No.");
                    if banksTrans.Find('-') then begin
                        repeat
                            banksTrans."Bank Account No." := bank."No.";
                            banksTrans.Modify();
                        until banksTrans.Next() = 0;
                    end;

                end;
            }







        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        wfuserG: Record "Workflow User Group";
}