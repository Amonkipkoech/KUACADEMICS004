/// <summary>
/// Page ELECT-Polling Centers LKP (ID 60018).
/// </summary>
page 60018 "ELECT-Polling Centers LKP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Polling Center Code"; Rec."Polling Center Code")
                {
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
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

