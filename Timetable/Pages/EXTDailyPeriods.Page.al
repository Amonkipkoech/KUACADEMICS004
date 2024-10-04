page 74558 "EXT-Daily Periods"
{
    Caption = 'Timetable Daily Lessons';
    PageType = List;
    SourceTable = 74552;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
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

