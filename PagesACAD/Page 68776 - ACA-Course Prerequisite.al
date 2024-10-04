page 68776 "ACA-Course Prerequisite"
{
    PageType = List;
    SourceTable = 61546;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Requirement; Rec.Requirement)
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
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

