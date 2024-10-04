/// <summary>
/// Page ELECT-Polling Booths List (ID 60009).
/// </summary>
page 60009 "ELECT-Polling Booths List"
{
    PageType = List;
    SourceTable = 60009;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Booth Code"; Rec."Booth Code")
                {
                    ApplicationArea = All;
                }
                field("Login Acc. Name"; Rec."Login Acc. Name")
                {
                    ApplicationArea = All;
                }
                field("Login Password"; Rec."Login Password")
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

