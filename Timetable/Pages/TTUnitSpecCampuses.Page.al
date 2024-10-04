page 74513 "TT-Unit Spec. Campuses"
{
    Caption = 'Unit Specific Campuses';
    PageType = List;
    SourceTable = 74513;

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

