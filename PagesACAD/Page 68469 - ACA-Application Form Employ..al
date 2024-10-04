page 68469 "ACA-Application Form Employ."
{
    PageType = ListPart;
    SourceTable = 61360;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To date"; Rec."To date")
                {
                    ApplicationArea = All;
                }
                field(Organisation; Rec.Organisation)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
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

