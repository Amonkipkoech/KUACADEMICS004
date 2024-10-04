/// <summary>
/// Page GEN-Denominations (ID 68842).
/// </summary>
page 68842 "GEN-Denominations"
{
    CardPageID = "ACA-Religions 2";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 61658;
    SourceTableView = WHERE(Category = FILTER(Denominations));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Title Code"; Rec."Title Code")
                {
                    Caption = 'Denomination';
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

