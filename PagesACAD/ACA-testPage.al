page 86660 "Fin Test"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 271;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No.";Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}