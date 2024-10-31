page 52062 "Issue Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = studentIssues;

    layout
    {
        area(Content)
        {
            group("Issue Card")
            {
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                }
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                }
                field(ClientName; Rec.ClientName)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Block/Session';
                    ApplicationArea = All;
                }
                field(DateRaised; Rec.DateRaised)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                }

            }
            group("Issues Raised")
            {
                field("issue Raised"; Rec."issue Raised")
                {
                    ApplicationArea = ALL;
                    MultiLine = true;
                }
                field(Resolution; Rec.Resolution)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Resolving Staff"; Rec."Resolving Staff")
                {
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
            action("Mark As Resolved")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}