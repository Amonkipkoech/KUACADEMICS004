/// <summary>
/// Page EXT-Dates List (ID 74557).
/// </summary>
page 74557 "EXT-Dates List"
{
    Caption = 'Timetable Days';
    PageType = List;
    SourceTable = 74551;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Code"; Rec."Date Code")
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

