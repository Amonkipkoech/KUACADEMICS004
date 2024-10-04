page 69072 "ACA-Clearance Conditions List"
{
    PageType = List;
    SourceTable = "ACA-Clearance Conditions list";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Clearance Level Code"; Rec."Clearance Level Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field("Condition to Check"; Rec."Condition to Check")
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

