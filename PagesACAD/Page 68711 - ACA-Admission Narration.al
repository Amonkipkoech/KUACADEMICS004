page 68711 "ACA-Admission Narration"
{
    PageType = List;
    SourceTable = "ACA-Admission Req. Narration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Admission Req. Narration"; Rec."Admission Req. Narration")
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

