page 69220 "Exam Result Sessions"
{
    PageType = Card;
    SourceTable = "Exam Sessions Management";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Exam Session"; Rec."Exam Session")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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

