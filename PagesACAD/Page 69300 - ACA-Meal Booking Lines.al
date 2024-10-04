page 69300 "ACA-Meal Booking Lines"
{
    PageType = ListPart;
    SourceTable = "CAT-Meal Booking Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meal Code"; Rec."Meal Code")
                {
                    ApplicationArea = All;
                }
                field("Meal Name"; Rec."Meal Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
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

