page 68804 "ACA-Post-Grad History"
{
    PageType = List;
    SourceTable = 61593;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
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

