page 68476 "ACA-Applic. Setup District"
{
    PageType = CardPart;
    SourceTable = 61365;

    layout
    {
        area(content)
        {
            repeater(___)
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

