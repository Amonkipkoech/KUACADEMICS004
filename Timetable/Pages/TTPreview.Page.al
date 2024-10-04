/// <summary>
/// Page TT-Preview (ID 74530).
/// </summary>
page 74530 "TT-Preview"
{
    PageType = List;
    SourceTable = 74523;

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
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Day of Week"; Rec."Day of Week")
                {
                    ApplicationArea = All;
                }
                field("Lesson Code"; Rec."Lesson Code")
                {
                    ApplicationArea = All;
                }
                field("Lecture Room"; Rec."Lecture Room")
                {
                    ApplicationArea = All;
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Room Code"; Rec."Room Code")
                {
                    ApplicationArea = All;
                }
                field("Lesson Category"; Rec."Lesson Category")
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

