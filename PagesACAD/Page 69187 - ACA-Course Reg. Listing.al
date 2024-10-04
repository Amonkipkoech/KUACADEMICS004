page 69187 "ACA-Course Reg. Listing"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "ACA-Course Registration";
    SourceTableView = SORTING("Student No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Options; Rec.Options)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
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

