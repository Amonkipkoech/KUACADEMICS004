page 61614 "ACA-School Transfer Grades"
{
    PageType = List;
    SourceTable = 66691;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
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

