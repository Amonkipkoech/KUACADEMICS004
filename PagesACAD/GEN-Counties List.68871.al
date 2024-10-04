/// <summary>
/// Page GEN-Counties List (ID 68871).
/// </summary>
page 68871 "GEN-Counties List"
{
    //CardPageID = "GEN-Counties Card";
    PageType = List;
    SourceTable = 61658;
    SourceTableView = SORTING(Category, "Title Code")
                      ORDER(Ascending)
                      WHERE(Category = FILTER(Counties));

    layout
    {
        area(content)
        {
            repeater(Group)
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

