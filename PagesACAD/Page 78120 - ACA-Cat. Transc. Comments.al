page 78120 "ACA-Cat. Transc. Comments"
{
    PageType = List;
    SourceTable = "ACA-Prog. Cat. Transcript Comm";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field("Pass Comment"; Rec."Pass Comment")
                {
                    ApplicationArea = All;
                }
                field("Failed Comment"; Rec."Failed Comment")
                {
                    ApplicationArea = All;
                }
                field("Include Programme Name"; Rec."Include Programme Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

