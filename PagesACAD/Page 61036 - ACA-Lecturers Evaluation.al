page 61036 "ACA-Lecturers Evaluation"
{
    PageType = List;
    SourceTable = 61036;

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
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Lecturer No"; Rec."Lecturer No")
                {
                    ApplicationArea = All;
                }
                field("Question No"; Rec."Question No")
                {
                    ApplicationArea = All;
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                }
                field("Date Time"; Rec."Date Time")
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

