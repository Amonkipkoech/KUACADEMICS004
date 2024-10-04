/// <summary>
/// Page Graduation Units List (ID 99991).
/// </summary>
page 99991 "Graduation Units List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 66632;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                }
                field("CAT Score"; Rec."CAT Score")
                {
                    ApplicationArea = All;
                }
                field("Exam Score"; Rec."Exam Score")
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Allow In Graduate"; Rec."Allow In Graduate")
                {
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field(Pass; Rec.Pass)
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

