/// <summary>
/// Page TT-Lessons (ID 74529).
/// </summary>
page 74529 "TT-Lessons"
{
    PageType = List;
    SourceTable = 74520;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lesson Code"; Rec."Lesson Code")
                {
                    ApplicationArea = All;
                }
                field("Lesson Order"; Rec."Lesson Order")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End TIme"; Rec."End TIme")
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

