page 68749 "ACA-Fees By Unit"
{
    PageType = List;
    SourceTable = 61524;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Settlemet Type"; Rec."Settlemet Type")
                {
                    ApplicationArea = All;
                }
                field("Seq."; Rec."Seq.")
                {
                    ApplicationArea = All;
                }
                field("Break Down"; Rec."Break Down")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                { ApplicationArea = All; }
            }
        }
    }

    actions
    {
    }
}

