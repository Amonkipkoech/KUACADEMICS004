/// <summary>
/// Page TT-Unit Spec. Weighting (ID 74515).
/// </summary>
page 74515 "TT-Unit Spec. Weighting"
{
    Caption = 'Unit Specific Weighting';
    PageType = List;
    SourceTable = 74515;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Weighting Category"; Rec."Weighting Category")
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

