page 77200 "ACA-Results Cancellation Lines"
{
    PageType = ListPart;
    SourceTable = "Aca-Result Cancelation Subject";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
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

