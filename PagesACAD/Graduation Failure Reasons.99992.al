/// <summary>
/// Page Graduation Failure Reasons (ID 99992).
/// </summary>
page 99992 "Graduation Failure Reasons"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 66633;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Reason Details"; Rec."Reason Details")
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

