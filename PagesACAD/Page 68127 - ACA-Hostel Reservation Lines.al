page 68127 "ACA-Hostel Reservation Lines"
{
    PageType = ListPart;
    SourceTable = 61627;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hostel No"; Rec."Hostel No")
                {
                    ApplicationArea = All;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = All;
                }
                field("Space No"; Rec."Space No")
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

