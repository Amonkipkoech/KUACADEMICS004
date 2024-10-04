page 79021 "Pogramme Leaders List"
{
    CardPageID = "Programme Leaders Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Programme Leaders";

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
                field("Programme Name";Rec."Programme Name")
                {
                    ApplicationArea = all;
                }
                field(Levels; Rec.Levels)
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Programme Leader Staff ID";Rec."Programme Leader Staff ID")
                {
                    ApplicationArea = All;
                }
                field("Programme Leader Name";Rec."Programme Leader Name")
                {
                    ApplicationArea = All;
                }
                field("Programme Status";Rec."Programme Status")
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