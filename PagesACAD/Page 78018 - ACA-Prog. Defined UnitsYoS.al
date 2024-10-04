page 78018 "ACA-Prog. Defined Units/YoS"
{
    PageType = ListPart;
    SourceTable = "ACA-Defined Units per YoS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programmes)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field("Number of Units"; Rec."Number of Units")
                {
                    ApplicationArea = All;
                }
                field(Options; Rec.Options)
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

