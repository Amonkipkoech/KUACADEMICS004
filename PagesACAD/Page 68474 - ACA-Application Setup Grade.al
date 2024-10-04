page 68474 "ACA-Application Setup Grade"
{
    PageType = CardPart;
    SourceTable = 61364;

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
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Points; Rec.Points)
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

