page 60008 "ELECT-Polling Centers List"
{
    PageType = List;
    SourceTable = 60008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Polling Center Code"; Rec."Polling Center Code")
                {
                    ApplicationArea = All;
                }
                field("No. of Registered Voters"; Rec."No. of Registered Voters")
                {
                    ApplicationArea = All;
                }
                field("No. of Votes Cast"; Rec."No. of Votes Cast")
                {
                    ApplicationArea = All;
                }
                field("Returning Officer ID"; Rec."Returning Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Returning Officer Name"; Rec."Returning Officer Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Booths)
            {
                Caption = 'Booths';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 60009;
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Polling Center Code" = FIELD("Polling Center Code"),
                              "Electral District" = FIELD("Electral District");
                ApplicationArea = All;
            }
            action(Agents)
            {
                Caption = 'Poll Agents';
                Image = AddWatch;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 60025;
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Electral District" = FIELD("Electral District"),
                              "Polling Center" = FIELD("Polling Center Code");
                ApplicationArea = All;
            }
        }
    }
}

