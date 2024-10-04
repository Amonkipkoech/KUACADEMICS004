page 50062 "Confimed Mpesa Trans"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = confirmedMpesaTransaction;
    SourceTableView = where(confirmed = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(accountNo; Rec.accountNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the accountNo field.';
                }
                field(accountName; Rec.accountName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the accountName field.';
                }
                field(confirmed; Rec.confirmed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the confirmed field.';
                }
                field(transactionAmount; Rec.transactionAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the transactionAmount field.';
                }
                field(transactionRefNo; Rec.transactionRefNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the transactionRefNo field.';
                }
                field(telephoneNo; Rec.telephoneNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the telephoneNo field.';
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}