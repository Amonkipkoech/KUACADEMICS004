/// <summary>
/// Page TT-Rooms List (ID 74521).
/// </summary>
page 74521 "TT-Rooms List"
{
    PageType = List;
    SourceTable = 74501;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Block Code"; Rec."Block Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = All;
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                }
                field("Class Capacity (Min)"; Rec."Class Capacity (Min)")
                {
                    ApplicationArea = All;
                }
                field("Class Capacity (Max)"; Rec."Class Capacity (Max)")
                {
                    ApplicationArea = All;
                }
                field("Exam Capacity (Min)"; Rec."Exam Capacity (Min)")
                {
                    ApplicationArea = All;
                }
                field("Exam Capacity (Max)"; Rec."Exam Capacity (Max)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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

