page 68712 "ACA-Students Units2"
{
    PageType = ListPart;
    SourceTable = 61549;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Semester; Rec.Semester)
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
                field("No. Of Units"; Rec."No. Of Units")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

