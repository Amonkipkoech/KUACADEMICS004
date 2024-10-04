page 86603 "tEST Data"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cust Ledger Test";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Acc No"; Rec."Acc No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acc No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Enry No"; Rec."Enry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enry No field.';
                }
                field("Count";Rec."Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enry No field.';
                }
                field("Count 2";Rec."Count 2")
                {
                    ApplicationArea = All;

                }
                field("Count 3";Rec."Count 3")
                {
                    ApplicationArea = All;
                    
                }
                field("Count 4";Rec."Count 4")
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}