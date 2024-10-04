page 66670 "ACA-Mobi Units List"
{
    PageType = List;
    SourceTable = 61517;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
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

