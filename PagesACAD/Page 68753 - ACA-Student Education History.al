page 68753 "ACA-Student Education History"
{
    PageType = List;
    SourceTable = "ACA-Student Education History";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field(Qualifications; Rec.Qualifications)
                {
                    ApplicationArea = All;
                }
                field(Instituition; Rec.Instituition)
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

