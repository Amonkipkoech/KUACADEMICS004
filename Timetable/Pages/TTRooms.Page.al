page 74520 "TT-Rooms"
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
                    Caption = 'Lecture Hall';
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Class Capacity (Min)"; Rec."Class Capacity (Min)")
                {
                    ApplicationArea = All;
                }
                field("Class Capacity (Max)"; Rec."Class Capacity (Max)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exam Capacity (Min)"; Rec."Exam Capacity (Min)")
                {
                    ApplicationArea = All;
                }
                field("Exam Capacity (Max)"; Rec."Exam Capacity (Max)")
                {
                    ApplicationArea = All;
                    Editable = false;
                
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

