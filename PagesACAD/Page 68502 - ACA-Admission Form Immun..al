page 68502 "ACA-Admission Form Immun."
{
    PageType = ListPart;
    SourceTable = 61378;

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field("Immunization Code"; Rec."Immunization Code")
                {
                    ApplicationArea = All;
                }
                field("Immunization Name"; Rec."Immunization Name")
                {
                    ApplicationArea = All;
                }
                field(Yes; Rec.Yes)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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

