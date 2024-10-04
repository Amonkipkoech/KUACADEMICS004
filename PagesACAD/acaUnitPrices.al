page 51866 UnitPrices
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = true;
    ModifyAllowed = true;
    SourceTable = "ACA-Fee By Unit";
    
    layout
    {
        area(Content)
        {
            repeater(unitBased)
            {
               
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Code field.';
                }
                field("Unit Code";Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.';
                }
                field("Break Down"; Rec."Break Down")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Break Down field.';
                }
                field("Settlemet Type"; Rec."Settlemet Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Settlemet Type field.';
                }
                field("Seq."; Rec."Seq.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seq. field.';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage Code field.';
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