page 65255 "ACA-Lecture Eval. Questions"
{
    PageType = ListPart;
    SourceTable = 61035;
    UsageCategory = Administration;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Evaluation Category"; Rec."Evaluation Category")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
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

