page 86612 "Portal Setups"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = PortalSetup;

    layout
    {
        area(Content)
        {
            group("Portal Messages Setups")
            {
                field(StudentPortalMessage; Rec.StudentPortalMessage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Setup for messages displayed on students portal';
                    MultiLine = true;
                }
                field(staffPortalMessage; Rec.staffPortalMessage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Setup for messages displayed on staff portal';
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Setup for messages displayed on status page';

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