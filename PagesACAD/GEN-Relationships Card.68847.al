page 68847 "GEN-Relationships Card"
{
    PageType = Card;
    SourceTable = 61658;
    SourceTableView = WHERE(Category = FILTER(Relationships));

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

