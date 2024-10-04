page 68472 "ACA-Appication Setup Subject"
{
    PageType = CardPart;
    SourceTable = 61363;

    layout
    {
        area(content)
        {
            repeater(__)
            {
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
    }
}

