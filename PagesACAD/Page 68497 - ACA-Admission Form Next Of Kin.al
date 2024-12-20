page 68497 "ACA-Admission Form Next Of Kin"
{
    PageType = ListPart;
    SourceTable = 61373;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Address 1"; Rec."Address 1")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Address 3"; Rec."Address 3")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
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

