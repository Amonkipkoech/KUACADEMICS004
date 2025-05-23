page 68746 "ACA-Lecture Room"
{
    PageType = List;
    SourceTable = 61694;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Minimum Capacity"; Rec."Minimum Capacity")
                {
                    ApplicationArea = All;
                }
                field("Maximum Capacity"; Rec."Maximum Capacity")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Facilities; Rec.Facilities)
                {
                    ApplicationArea = All;
                }
                field("Reserve For"; Rec."Reserve For")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                }
                field("Lab No."; Rec."Lab No.")
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

