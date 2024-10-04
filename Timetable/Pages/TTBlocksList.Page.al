/// <summary>
/// Page TT-Blocks List (ID 74522).
/// </summary>
page 74522 "TT-Blocks List"
{
    PageType = List;
    SourceTable = 74519;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Block Code"; Rec."Block Code")
                {
                    ApplicationArea = All;
                }
                field("Block Description"; Rec."Block Description")
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

