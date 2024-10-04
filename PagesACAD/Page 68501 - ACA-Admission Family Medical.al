page 68501 "ACA-Admission Family Medical"
{
    PageType = ListPart;
    SourceTable = 61377;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Medical Condition Code"; Rec."Medical Condition Code")
                {
                    ApplicationArea = All;
                }
                field("Medical Condition Name"; Rec."Medical Condition Name")
                {
                    ApplicationArea = All;
                }
                field(Yes; Rec.Yes)
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

