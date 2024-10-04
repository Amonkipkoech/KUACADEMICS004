report 51067 "Update Transfers"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cust. Ledger Entry"; 21)
        {
            RequestFilterFields = Description;

            trigger OnAfterGetRecord()
            begin
                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry".Amount);
                Journal.INIT;
                Journal."Journal Template Name" := 'General';
                Journal."Journal Batch Name" := 'Transfers';
                Journal."Line No." := Journal."Line No." + 1;
                Journal."Account Type" := Journal."Account Type"::Customer;
                Journal."Account No." := "Cust. Ledger Entry"."Customer No.";
                Journal."Posting Date" := "Cust. Ledger Entry"."Posting Date";
                Journal."Document No." := "Cust. Ledger Entry"."Document No.";
                Journal.Description := "Cust. Ledger Entry".Description;
                Journal."Bal. Account No." := "Cust. Ledger Entry"."Bal. Account No.";
                Journal.Amount := "Cust. Ledger Entry".Amount * -1;
                Journal.INSERT;
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
        Journal: Record 81;
}

