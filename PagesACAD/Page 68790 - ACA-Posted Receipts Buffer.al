page 68790 "ACA-Posted Receipts Buffer"
{
    Editable = false;
    PageType = List;
    SourceTable = 61552;
    SourceTableView = WHERE(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Receipt No"; Rec."Receipt No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Receipting)
            {
                Caption = 'Receipting';
            }
        }
    }

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
}

