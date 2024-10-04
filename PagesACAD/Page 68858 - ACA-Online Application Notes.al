page 68858 "ACA-Online Application Notes"
{
    PageType = List;
    SourceTable = "ACA-Online Application Notes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Notes"; Rec."Application Notes")
                {
                    ApplicationArea = All;
                }
                field(Order; Rec.Order)
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

