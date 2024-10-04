page 68770 "ACA-New Student Charges"
{
    PageType = List;
    SourceTable = 61543;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = All;
                }
                field("First Time Students"; Rec."First Time Students")
                {
                    ApplicationArea = All;
                }
                field("Distribution (%)"; Rec."Distribution (%)")
                {
                    ApplicationArea = All;
                }
                field("Distribution Account"; Rec."Distribution Account")
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

