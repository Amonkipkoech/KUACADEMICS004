page 68777 "ACA-Prerequisite Approval"
{
    PageType = List;
    SourceTable = 61547;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Reg. Transaction ID"; Rec."Reg. Transaction ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Prerequisite; Rec.Prerequisite)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
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

