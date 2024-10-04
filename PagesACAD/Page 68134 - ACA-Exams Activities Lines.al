page 68134 "ACA-Exams Activities Lines"
{
    PageType = List;
    SourceTable = 61737;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                }
                field("Max duration"; Rec."Max duration")
                {
                    ApplicationArea = All;
                }
                field("Time Line"; Rec."Time Line")
                {
                    ApplicationArea = All;
                }
                field("Action Office"; Rec."Action Office")
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

