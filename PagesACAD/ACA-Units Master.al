page 86522 "ACA-Units Master table"
{
    PageType = List;
    SourceTable = "ACA-Units Master Table";
    InsertAllowed = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field("Level Code"; Rec."Level Code")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    ApplicationArea = All;
                }
                field("Prerequisite Unit Code 1"; Rec."Prerequisite Unit Code 1")
                {
                    ApplicationArea = All;
                }
                field("Prerequisite Unit Code 2"; Rec."Prerequisite Unit Code 2")
                {
                    ApplicationArea = ALL;
                }
                field("Prerequisite Unit Code 3"; Rec."Prerequisite Unit Code 3")
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