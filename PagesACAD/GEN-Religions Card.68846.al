page 68846 "GEN-Religions Card"
{
    PageType = Card;
    SourceTable = 61658;
    SourceTableView = WHERE(Category = FILTER(Religions));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Title Code"; Rec."Title Code")
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

