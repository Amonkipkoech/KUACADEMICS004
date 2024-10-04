page 68517 "ACA-Programme Subject Grades"
{
    PageType = ListPart;
    SourceTable = 61385;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade"; Rec."Mean Grade")
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

