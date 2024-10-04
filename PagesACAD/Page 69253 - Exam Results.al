page 69253 "Exam Results"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Exam Results";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                }
                field("Reg. Transaction ID"; Rec."Reg. Transaction ID")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;
                }
                field("Last Edited By"; Rec."Last Edited By")
                {
                    ApplicationArea = All;
                }
                field("Last Edited On"; Rec."Last Edited On")
                {
                    ApplicationArea = All;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ApplicationArea = All;
                }
                field("Semester Total"; Rec."Semester Total")
                {
                    ApplicationArea = All;
                }
                field("Lecturer Names"; Rec."Lecturer Names")
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

