page 68764 "ACA-Exam Registration"
{
    PageType = List;
    SourceTable = "ACA-Exam Registration";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Intake';
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

