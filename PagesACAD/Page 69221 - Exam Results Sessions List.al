page 69221 "Exam Results Sessions List"
{
    CardPageID = "Exam Result Sessions";
    PageType = List;
    SourceTable = "Exam Sessions Management";

    layout
    {
        area(content)
        {
            repeater(Group)
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

