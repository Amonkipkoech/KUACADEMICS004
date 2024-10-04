page 74519 "TT-Blocks"
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
        area(creation)
        {
            action(Rooms)
            {
                Caption = 'Rooms';
                Image = Reuse;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 74520;
                RunPageLink = "Block Code" = FIELD("Block Code"),
                              "Academic year" = FIELD("Academic Year"),
                              Semester = FIELD(Semester);
                ApplicationArea = All;
            }
        }
    }
}

