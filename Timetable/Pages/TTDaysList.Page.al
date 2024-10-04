page 74524 "TT-Days List"
{
    Caption = 'Timetable Days';
    PageType = List;
    SourceTable = 74502;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Day Code"; Rec."Day Code")
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

