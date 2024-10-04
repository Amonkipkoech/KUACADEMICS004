page 86523 "ACA-Program Duration"
{
    PageType = List;
    SourceTable = 86522;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Duration Code";  Rec."Duration Code")
                {
                    ApplicationArea = All;
                }
                field(Duration;Rec.Duration)
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

