page 54599 "Bank Intergration Transactions"
{
    PageType = List;
    SourceTable = "Bank Intergration - Final";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(bankreference; Rec.bankreference)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the bankreference field.';
                }
                field(debitaccount; Rec.debitaccount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the debitaccount field.';
                }
                field(transactionDate; Rec.transactionDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the transactionDate field.';
                }
                field(billAmount; Rec.billAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billAmount field.';
                }
                field(paymentMode; Rec.paymentMode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the paymentMode field.';
                }
                field(phonenumber; Rec.phonenumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the phonenumber field.';
                }
                field(customerRefNumber; Rec.customerRefNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customerRefNumber field.';
                }
                field(debitcustname; Rec.debitcustname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the debitcustname field.';
                }
                field("New Student"; Rec."New Student")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the New Student field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }

}