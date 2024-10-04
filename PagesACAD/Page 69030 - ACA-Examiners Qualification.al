page 69030 "ACA-Examiners Qualification"
{
    PageType = ListPart;
    SourceTable = "ACA-Lecturer/Examiner Qualif.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Code"; Rec."Qualification Code")
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

