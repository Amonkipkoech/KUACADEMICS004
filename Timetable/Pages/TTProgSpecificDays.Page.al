/// <summary>
/// Page TT-Prog. Specific Days (ID 74508).
/// </summary>
page 74508 "TT-Prog. Specific Days"
{
    Caption = 'Programme Specific Days';
    PageType = List;
    SourceTable = 74508;

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

