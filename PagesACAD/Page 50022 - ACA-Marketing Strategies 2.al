page 50096 "ACA-Marketing Strategies 2"
{
    PageType = List;
    SourceTable = 61648;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Students Registered"; Rec."Students Registered")
                {
                    ApplicationArea = All;
                }
                field("Academic Year filter"; Rec."Academic Year filter")
                {
                    ApplicationArea = All;
                }
                field("Intake Code filter"; Rec."Intake Code filter")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type filter"; Rec."Settlement Type filter")
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

