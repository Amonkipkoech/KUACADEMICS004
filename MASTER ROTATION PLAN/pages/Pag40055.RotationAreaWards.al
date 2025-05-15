page 40055 "Rotation Area Wards"
{
    Caption = 'Rotation Area Wards';
    PageType = List;
    SourceTable = "Rotation Area Wards";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Ward Code"; Rec."Ward Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ward Code field.', Comment = '%';
                }
                field("Ward Name"; Rec."Ward Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ward Name field.', Comment = '%';
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capacity field.', Comment = '%';
                }
                field("Rotation Area "; Rec."Rotation Area ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rotation Area field.', Comment = '%';
                }
            }
        }
    }
}
