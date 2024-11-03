page 40022 xylist
{
    Caption = 'Unit Coverage';
    PageType = ListPart;
    SourceTable = "XY form Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field("Rotation Area"; Rec."Rotation Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rotation Area field.', Comment = '%';
                }
                field("Unit   Coverage"; Rec."Unit   Coverage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description Covered field.', Comment = '%';
                }
                field("Duration Hours"; rec."Duration Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Duration Hours';
                    ToolTip = 'Specifies the value of the Unit Description Covered field.', Comment = '%';
                }
            }
        }
    }
}
