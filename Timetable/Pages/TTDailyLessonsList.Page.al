/// <summary>
/// Page TT-Daily Lessons List (ID 74526).
/// </summary>
page 74526 "TT-Daily Lessons List"
{
    Caption = 'Timetable Daily Lessons';
    PageType = List;
    SourceTable = 74503;

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
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
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

