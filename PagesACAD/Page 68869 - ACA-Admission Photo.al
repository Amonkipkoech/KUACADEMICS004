page 68869 "ACA-Admission Photo"
{
    PageType = Card;
    SourceTable = "ACA-Adm. Form Header";

    layout
    {
        area(content)
        {
            group("Admission photo")
            {
                field(Photo; Rec.Photo)
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

