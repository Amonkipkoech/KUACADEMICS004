page 66651 "ACA-Exam-Senate Units View"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 66650;

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
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
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
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                }
                field("Weighted Total Score"; Rec."Weighted Total Score")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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

