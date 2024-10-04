page 68741 "ACA-Charge"
{
    Editable = true;
    PageType = list;
    SourceTable = "ACA-Charge";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field(Show; Rec.Show)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Hostel; Rec.Hostel)
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

