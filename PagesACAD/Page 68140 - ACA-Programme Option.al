page 68140 "ACA-Programme Option"
{
    PageType = List;
    SourceTable = 61554;

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Program Code';
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                    Caption = 'Specialization';
                }
                field("Stage Code";Rec."Stage Code")
                {
                    ApplicationArea = All;
                    Caption =  'Specialization Stage';
                }
            }
        }
    }

    actions
    {
    }
}

