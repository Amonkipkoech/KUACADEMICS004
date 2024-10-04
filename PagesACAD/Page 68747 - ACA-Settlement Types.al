page 68747 "ACA-Settlement Types"
{
    PageType = List;
    SourceTable = 61522;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = All;
                }
                field("Tuition G/L Account"; Rec."Tuition G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Reg. No Prefix"; Rec."Reg. No Prefix")
                {
                    ApplicationArea = All;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
    

    var
        AllowAccessSetup: boolean;
}

