page 70077 "Exam Res. List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Exam Results";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No.";Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Correct;Rec.Correct)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(ExamType; Rec.ExamType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ExamType field.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Contribution; Rec.Contribution)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
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

