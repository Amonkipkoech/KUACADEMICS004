page 68503 "ACA-Medical Condition Card"
{
    PageType = Card;
    SourceTable = 61379;

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
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field(Family; Rec.Family)
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

