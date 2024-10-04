page 68471 "ACA-Application Form Academic"
{
    PageType = ListPart;
    SourceTable = 61362;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    Editable = false;
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

