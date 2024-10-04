page 68936 "ACA-Std Hostel Inventory Items"
{
    PageType = List;
    SourceTable = "ACA-Std Hostel Inventory Items";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hostel Block"; Rec."Hostel Block")
                {
                    ApplicationArea = All;
                }
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = All;
                }
                field("Space Code"; Rec."Space Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
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

