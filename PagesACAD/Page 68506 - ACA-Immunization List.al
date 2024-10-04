page 68506 "ACA-Immunization List"
{
    PageType = List;
    SourceTable = 61380;

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

