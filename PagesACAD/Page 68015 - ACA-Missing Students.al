page 68015 "ACA-Missing Students"
{
    Editable = false;
    PageType = List;
    SourceTable = 61008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
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

