page 68748 "ACA-Fee By Stage"
{
    PageType = List;
    SourceTable = 61523;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Settlemet Type"; Rec."Settlemet Type")
                {
                    ApplicationArea = All;
                }
                field(Campus;Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Seq."; Rec."Seq.")
                {
                    ApplicationArea = All;
                }
                field("Break Down"; Rec."Break Down")
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

