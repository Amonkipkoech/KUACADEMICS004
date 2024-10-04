/// <summary>
/// Page EXT-Lect. Spec. Campuses (ID 74563).
/// </summary>
page 74563 "EXT-Lect. Spec. Campuses"
{
    Caption = 'Lecturer Specific Campuses';
    PageType = List;
    SourceTable = 74560;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Campus Code"; Rec."Campus Code")
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

