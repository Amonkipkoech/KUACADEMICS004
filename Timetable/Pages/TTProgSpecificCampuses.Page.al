page 74507 "TT-Prog. Specific Campuses"
{
    Caption = 'Programme Specific Campuses';
    PageType = List;
    SourceTable = 74507;

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

