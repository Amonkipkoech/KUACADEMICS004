page 68998 "ACA-Clearance View Card Unedit"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("Student Clearance Details")
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Clearance Status"; Rec."Clearance Status")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Clearance Initiated by"; Rec."Clearance Initiated by")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Clearance Initiated Date"; Rec."Clearance Initiated Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Clearance Initiated Time"; Rec."Clearance Initiated Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Current Programme"; Rec."Current Programme")
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

