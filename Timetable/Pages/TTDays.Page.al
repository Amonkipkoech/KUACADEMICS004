page 74523 "TT-Days"
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
                field("Day Order"; Rec."Day Order")
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
            action("`")
            {
                Caption = 'Daily Lessons';
                Image = AdjustExchangeRates;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74525;
                RunPageLink = "Academic Year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester),
                              "Day Code" = FIELD("Day Code");
                ApplicationArea = All;
            }
        }
    }
}

