page 86604 "Data Mine"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 379;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No.";Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Count 2";Rec."Count 2")
                {
                    
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