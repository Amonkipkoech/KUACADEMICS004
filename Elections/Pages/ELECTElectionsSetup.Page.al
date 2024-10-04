/// <summary>
/// Page ELECT-Elections Setup (ID 60024).
/// </summary>
page 60024 "ELECT-Elections Setup"
{
    PageType = Card;
    SourceTable = 60013;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Current Election"; Rec."Current Election")
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

