/// <summary>
/// Page SWF-Student Other Incident SF (ID 68659).
/// </summary>
page 68659 "SWF-Student Other Incident SF"
{
    PageType = List;
    SourceTable = 61596;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                }
                field("Incident Case"; Rec."Incident Case")
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

