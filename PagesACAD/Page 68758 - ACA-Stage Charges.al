page 68758 "ACA-Stage Charges"
{
    PageType = List;
    SourceTable = "ACA-Stage Charges";

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
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Recovered First"; Rec."Recovered First")
                {
                    ApplicationArea = All;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
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
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
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

