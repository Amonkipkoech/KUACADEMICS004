page 77723 "ACA-Student Charges Reservour"
{
    PageType = List;
    SourceTable = "ACA-Std Charges Reservour";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transacton ID"; Rec."Transacton ID")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Recovered First"; Rec."Recovered First")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Recognized; Rec.Recognized)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Distribution; Rec.Distribution)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Distribution Account"; Rec."Distribution Account")
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

    trigger OnDeleteRecord(): Boolean
    begin
        //IF Recognized = TRUE THEN
        //ERROR('You can not delete recognized/billed transactions.');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF Rec."Transaction Type" = Rec."Transaction Type"::Charges THEN
            Rec.VALIDATE("Transacton ID");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec.Recognized = TRUE THEN
            ERROR('You can not modify recognized/billed transactions.');
    end;
}

