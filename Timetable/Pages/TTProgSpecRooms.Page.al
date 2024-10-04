/// <summary>
/// Page TT-Prog. Spec. Rooms (ID 74509).
/// </summary>
page 74509 "TT-Prog. Spec. Rooms"
{
    Caption = 'Programme Specific Rooms';
    PageType = List;
    SourceTable = 74509;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room Code"; Rec."Room Code")
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

