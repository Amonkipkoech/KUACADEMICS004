/// <summary>
/// Page TT-Weight Lesson Categories (ID 74527).
/// </summary>
page 74527 "TT-Weight Lesson Categories"
{
    PageType = List;
    SourceTable = 74506;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Single Classes"; Rec."Single Classes")
                {
                    ApplicationArea = All;
                }
                field("Double Classes"; Rec."Double Classes")
                {
                    ApplicationArea = All;
                }
                field("Triple Classes"; Rec."Triple Classes")
                {
                    ApplicationArea = All;
                }
                field("Quadruple  Classes"; Rec."Quadruple  Classes")
                {
                    ApplicationArea = All;
                }
                field("Penta Classes"; Rec."Penta Classes")
                {
                    ApplicationArea = All;
                }
                field("Hexa Classes"; Rec."Hexa Classes")
                {
                    ApplicationArea = All;
                }
                field("Hepta Classes"; Rec."Hepta Classes")
                {
                    ApplicationArea = All;
                }
                field("Octa Classes"; Rec."Octa Classes")
                {
                    ApplicationArea = All;
                }
                field("Default Category"; Rec."Default Category")
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

