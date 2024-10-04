page 68470 "ACA-Application Form Qualif."
{
    PageType = ListPart;
    SourceTable = 61361;

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field("Where Obtained"; Rec."Where Obtained")
                {
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                }
                field(Award; Rec.Award)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
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

