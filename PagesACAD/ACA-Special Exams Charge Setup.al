page 40001 "ACA-Special Exams Charge Setup" 
{


    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Special Exams Charge Setup";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ToolTip = 'Specifies the value of the Campus field.';
                    ApplicationArea = All;
                }
                field("Constant Unit Code"; Rec."Constant Unit Code")
                {
                    ToolTip = 'Specifies the value of the Constant Unit Code field.';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ToolTip = 'Specifies the value of the Faculty field.';
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ToolTip = 'Specifies the value of the Faculty Code field.';
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                    ApplicationArea = All;
                }
                field("Level Code"; Rec."Level Code")
                {
                    ToolTip = 'Specifies the value of the Level Code field.';
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ToolTip = 'Specifies the value of the Mode of Study field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
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