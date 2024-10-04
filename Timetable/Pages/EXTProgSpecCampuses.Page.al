page 74561 "EXT-Prog. Spec. Campuses"
{
    Caption = 'Programme Specific Campuses';
    PageType = List;
    SourceTable = 74558;

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

