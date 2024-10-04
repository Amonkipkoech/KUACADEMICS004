page 68763 "ACA-Student Charges Payments"
{
    PageType = List;
    SourceTable = "ACA-Std Charges";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amounts; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount-Amount Paid"; Rec.Amount - Rec."Amount Paid")
                {
                    Caption = 'Balance';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Recognized; Rec.Recognized)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Recovered First"; Rec."Recovered First")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Apply to"; Rec."Apply to")
                {
                    Caption = 'Apply To';
                    ApplicationArea = All;
                }
                field("Applied Amount"; Rec."Applied Amount")
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

