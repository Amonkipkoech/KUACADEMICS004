page 68708 "ACA-Programme Entry Subjects"
{
    PageType = List;
    SourceTable = "ACA-Programme Entry Subjects";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Minimum Grade"; Rec."Minimum Grade")
                {
                    ApplicationArea = All;
                }
                field("Minimum Points"; Rec."Minimum Points")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

