page 52057 "Issues List"
{
    PageType = List;
    CardPageId = "Issue Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = studentIssues;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Type field.';
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client field.';
                }
                field("issue Raised"; Rec."issue Raised")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the issue Raised field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.';
                }
                field(Resolution; Rec.Resolution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resolution field.';
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Block/Session';
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