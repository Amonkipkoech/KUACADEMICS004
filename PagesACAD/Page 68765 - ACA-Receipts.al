page 68765 "ACA-Receipts"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Worksheet;
    SourceTable = "ACA-Receipt";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = true;
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bank Slip/Cheque No"; Rec."Bank Slip/Cheque No")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment By"; Rec."Payment By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Reversed, FALSE);
                    Receipts.RESET;
                    Receipts.SETRANGE(Receipts."Receipt No.", Rec."Receipt No.");
                    IF Receipts.FIND('-') THEN
                        //REPORT.RUN(39005949,TRUE,FALSE,Receipts);
                        REPORT.RUN(51524, TRUE, FALSE, Receipts);
                end;
            }
        }
    }

    var
        Receip: Record "ACA-Receipt";
        Receipts: Record "ACA-Receipt";
}

