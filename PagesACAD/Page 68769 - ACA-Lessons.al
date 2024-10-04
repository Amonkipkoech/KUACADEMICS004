page 68769 "ACA-Lessons"
{
    PageType = CardPart;
    SourceTable = 61542;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Descrition; Rec.Descrition)
                {
                    ApplicationArea = All;
                }
                field("Full Time/Part Time"; Rec."Full Time/Part Time")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("No Of Hours"; Rec."No Of Hours")
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

