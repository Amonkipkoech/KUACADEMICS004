page 79022 "Programme Leaders Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Programme Leaders";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Programme Code";Rec."Programme Code")
                {
                    ApplicationArea = All;
                    
                }
                field("Programme Name";Rec."Programme Name")
                {
                    ApplicationArea = All;
                }
                field(Levels;Rec.Levels)
                {
                    ApplicationArea = All;
                
                }
                field("Faculty Code";Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Name";Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Programme Leader Staff ID";Rec."Programme Leader Staff ID")
                {
                    ApplicationArea =All;
                }
                field("Programme Leader Name";Rec."Programme Leader Name")
                {
                    ApplicationArea = All;
                }
                field("Programme Status";Rec."Programme Status")
                {
                    ApplicationArea = All;
                }
                field(Department;Rec.Department)
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
            action(Test)
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