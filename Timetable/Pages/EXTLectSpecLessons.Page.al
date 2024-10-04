page 74565 "EXT-Lect. Spec. Lessons"
{
    Caption = 'Lecturer Specific Lessons';
    PageType = List;
    SourceTable = 74562;

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
                field("Constraint Category"; Rec."Constraint Category")
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

