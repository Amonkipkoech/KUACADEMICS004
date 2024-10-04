page 68935 "ACA-Hostel Invtry Items List"
{
    PageType = List;
    SourceTable = "ACA-Hostel Inventory";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Per Room"; Rec."Quantity Per Room")
                {
                    ApplicationArea = All;
                }
                field("Applies To"; Rec."Applies To")
                {
                    ApplicationArea = All;
                }
                field("Hostel Gender"; Rec."Hostel Gender")
                {
                    ApplicationArea = All;
                }
                field("Fine Amount"; Rec."Fine Amount")
                {
                    ApplicationArea = All;
                }
                field("Bill Total"; Rec."Bill Total")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("All Rooms"; Rec."All Rooms")
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

