page 68132 "ACA-Hostel List1"
{
    CardPageID = "ACA-Hostel Card1";
    Editable = true;
    PageType = ListPart;
    SourceTable = 61162;

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Total Rooms"; Rec."Total Rooms")
                {
                    ApplicationArea = All;
                }
                field("Space Per Room"; Rec."Space Per Room")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Occupant"; Rec."Cost Per Occupant")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Vaccant; Rec.Vaccant)
                {
                    ApplicationArea = All;
                }
                field("Partially Occupied"; Rec."Partially Occupied")
                {
                    ApplicationArea = All;
                }
                field("Fully Occupied"; Rec."Fully Occupied")
                {
                    ApplicationArea = All;
                }
                field(Blacklisted; Rec.Blacklisted)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Cost per Room"; Rec."Cost per Room")
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

