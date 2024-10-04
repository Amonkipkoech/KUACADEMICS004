/// <summary>
/// Page ELECT-Electral Districts LKP (ID 60020).
/// </summary>
page 60020 "ELECT-Electral Districts LKP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 60004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Electral District Doce"; Rec."Electral District Doce")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. of Registered Voters"; Rec."No. of Registered Voters")
                {
                    ApplicationArea = All;
                }
                field("No. of Votes Cast"; Rec."No. of Votes Cast")
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

