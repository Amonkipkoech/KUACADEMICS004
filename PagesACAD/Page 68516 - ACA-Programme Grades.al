/// <summary>
/// Page ACA-Programme Grades (ID 68516).
/// </summary>
page 68516 "ACA-Programme Grades"
{
    PageType = Document;
    SourceTable = 61384;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade"; Rec."Mean Grade")
                {
                    ApplicationArea = All;
                }
                field("Min Points"; Rec."Min Points")
                {
                    ApplicationArea = All;
                }
            }
            part(ASG; 68517)
            {
                SubPageLink = Programme = FIELD(Programme);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

