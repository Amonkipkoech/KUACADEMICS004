pageextension 60002 "Customer ledger entry Ext." extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {

            field("Receiving Bank"; Rec."Receiving Bank")
            {
                ToolTip = 'Specifies the value of the Receiving Bank field.';
                ApplicationArea = All;
            }
        }
    }
}