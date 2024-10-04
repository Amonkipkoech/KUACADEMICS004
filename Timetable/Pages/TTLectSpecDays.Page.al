page 74511 "TT-Lect. Spec. Days"
{
    Caption = 'Lecturer Specific Days';
    PageType = List;
    SourceTable = 74511;

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

