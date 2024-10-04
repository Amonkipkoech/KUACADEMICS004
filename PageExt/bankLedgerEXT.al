pageextension 60003 "Bankledger entry Ext." extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Bank Account No.")
        {

            field(accountNo; Rec.accountNo)
            {
                ToolTip = 'Specifies the value of the Receiving Bank field.';
                ApplicationArea = All;
            }
        }
    }
}