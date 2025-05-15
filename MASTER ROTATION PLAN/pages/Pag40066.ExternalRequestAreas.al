page 40066 "External Request Areas"
{
    Caption = 'External Request Areas';
    PageType = ListPart;
    SourceTable = "External Request Rotation area";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Rotation Area Code"; Rec."Rotation Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rotation Area Code field.', Comment = '%';
                }
                field("Rotation Name"; Rec."Rotation Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rotation Name field.', Comment = '%';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
            }
        }
    }
}
