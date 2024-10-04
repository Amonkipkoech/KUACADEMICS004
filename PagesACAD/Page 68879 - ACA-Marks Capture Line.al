page 68879 "ACA-Marks Capture Line"
{
    PageType = List;
    SourceTable = "FIN-Exam Marks Capture";

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
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CAT 1"; Rec."CAT 1")
                {
                    ApplicationArea = All;
                }
                field("CAT 2"; Rec."CAT 2")
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
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

