page 70261 "ACA-Mailing List Params"
{

    PageType = List;
    CardPageId = "ACA-Mailing Card Params";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Mail Parameters";

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field("Mail Code"; Rec."Mail Code")
                {
                    ToolTip = 'Specifies the value of the Mail Code field.';
                    ApplicationArea = All;
                }
                field("Mail Batch"; Rec."Mail Batch")
                {
                    ToolTip = 'Specifies the value of the Mail Batch field.';
                    ApplicationArea = All;
                }
                field("Cc 1"; Rec."Cc 1")
                {
                    ToolTip = 'Specifies the value of the Cc 1 field.';
                    ApplicationArea = All;
                }
                field("Cc 2"; Rec."Cc 2")
                {
                    ToolTip = 'Specifies the value of the Cc 2 field.';
                    ApplicationArea = All;
                }
                field("Cc 3"; Rec."Cc 3")
                {
                    ToolTip = 'Specifies the value of the Cc 3 field.';
                    ApplicationArea = All;
                }
                field("Cc 4"; Rec."Cc 4")
                {
                    ToolTip = 'Specifies the value of the Cc 4 field.';
                    ApplicationArea = All;
                }
                field("BCc 1"; Rec."BCc 1")
                {
                    ToolTip = 'Specifies the value of the BCc 1 field.';
                    ApplicationArea = All;
                }
                field("BCc 2"; Rec."BCc 2")
                {
                    ToolTip = 'Specifies the value of the BCc 2 field.';
                    ApplicationArea = All;
                }
                field("BCc 3"; Rec."BCc 3")
                {
                    ToolTip = 'Specifies the value of the BCc 3 field.';
                    ApplicationArea = All;
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.';
                    ApplicationArea = All;
                }
                field("Email Body"; Rec."Email Body")
                {
                    ToolTip = 'Specifies the value of the Email Body field.';
                    ApplicationArea = All;
                }
                field("Email Body 2"; Rec."Email Body 2")
                {
                    ToolTip = 'Specifies the value of the Email Body 2 field.';
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