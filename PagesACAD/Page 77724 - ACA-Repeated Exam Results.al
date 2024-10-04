/// <summary>
/// Page ACA-Repeated Exam Results (ID 77724).
/// </summary>
page 77724 "ACA-Repeated Exam Results"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Exam Results";
    SourceTableView = WHERE("Number of Occurances" = FILTER(> 1));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programmes)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Semester Total"; Rec."Semester Total")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(ExamType; Rec.ExamType)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Number of Occurances"; Rec."Number of Occurances")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("To Delete"; Rec."To Delete")
                {
                    ApplicationArea = All;
                }
                field(UserID; Rec.UserID)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

