page 68745 "ACA-Buildings"
{
    PageType = Card;
    SourceTable = 61519;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Building)
            {
                Caption = 'Building';
                action("Lecture Rooms")
                {
                    Caption = 'Lecture Rooms';
                    RunObject = Page 68775;
                    RunPageLink = "Building Code" = FIELD(Code);
                    ApplicationArea = All;
                }

                action(Labs)
                {
                    Caption = 'Labs';
                    RunObject = Page "ACA-Lecture Rooms - Labs";
                    RunPageLink = "Building Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }
}

