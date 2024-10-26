page 40008 "master rotation list "
{
    Caption = 'master rotation list ';
    PageType = List;
    CardPageId = "Master Rotation Plan Card";
    SourceTable = "Master Rotation Table";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plan ID"; Rec."Plan ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan ID field.', Comment = '%';
                }
                field("HoD Name"; Rec."HoD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HoD Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Program Code"; Rec."Program Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program Code field.', Comment = '%';
                }
                field("Program Name"; Rec."Program Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program Name field.', Comment = '%';
                }
                field("Block Name"; Rec."Block Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Block Name field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("Start Month"; Rec."Start Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Month field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("End Month"; Rec."End Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Month field.', Comment = '%';
                }
                field("Number of Weeks"; Rec."Number of Weeks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Weeks field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
            }
        }
    }
}
