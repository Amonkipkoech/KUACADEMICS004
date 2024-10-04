page 68504 "ACA-Medical Condition List"
{
    PageType = List;
    SourceTable = 61379;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field(Family; Rec.Family)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

