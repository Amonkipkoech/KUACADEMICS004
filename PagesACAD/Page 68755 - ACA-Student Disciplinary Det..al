page 68755 "ACA-Student Disciplinary Det."
{
    PageType = List;
    SourceTable = "ACA-Std Disciplinary Details";

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
                field("Disciplinary Case"; Rec."Disciplinary Case")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Action"; Rec."Disciplinary Action")
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

