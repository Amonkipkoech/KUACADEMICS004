page 68738 "ACA-Religions 2"
{
    PageType = List;
    SourceTable = 61658;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Title Code"; Rec."Title Code")
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

