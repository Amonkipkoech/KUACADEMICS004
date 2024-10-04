page 68477 "ACA-Applic. Setup District Lis"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 61365;

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Code; Rec.Code)
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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

