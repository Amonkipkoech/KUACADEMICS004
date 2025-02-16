page 40040  "E-Citizen Services"
{
    PageType = List;
    SourceTable = "E-Citizen Services";
    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Code field.';
                }
                field(Services; Rec.Services)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Services field.';
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank field.';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Number field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(Insitution; Rec.Insitution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insitution field.';
                }
            }
        }
    }
}
