page 68797 "ACA-Master Std Charges"
{
    PageType = List;
    SourceTable = 61556;

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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("First Time Students"; Rec."First Time Students")
                {
                    ApplicationArea = All;
                }
                field("First Semster Only"; Rec."First Semster Only")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = All;
                }
                field("Distribution (%)"; Rec."Distribution (%)")
                {
                    ApplicationArea = All;
                }
                field("Distribution Account"; Rec."Distribution Account")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

