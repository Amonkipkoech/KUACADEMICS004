page 68783 "ACA-Student Comments"
{
    PageType = List;
    SourceTable = 61559;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

