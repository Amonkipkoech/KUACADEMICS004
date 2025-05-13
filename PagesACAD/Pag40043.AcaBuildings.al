page 40043 "Aca Buildings "
{
    Caption = 'Aca Buildings ';
    PageType = List;
    SourceTable = "ACA-Buidings Setups";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Building Code"; Rec."Building Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Building Code field.', Comment = '%';
                }
                field("Building Name"; Rec."Building Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Building Name field.', Comment = '%';
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus Code field.', Comment = '%';
                }
            }
        }
    }
}
