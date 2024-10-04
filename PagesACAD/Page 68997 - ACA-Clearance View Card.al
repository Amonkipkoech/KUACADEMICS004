page 68997 "ACA-Clearance View Card"
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
                    ApplicationArea = All;
                }
                field("Clearance Semester"; Rec."Clearance Semester")
                {
                    ApplicationArea = All;
                }
                field("Clearance Academic Year"; Rec."Clearance Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Current Programme"; Rec."Current Programme")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Programme End Date"; Rec."Programme End Date")
                {
                    Caption = 'Date of Completion';
                    ApplicationArea = All;
                }
                field("Clearance Reason"; Rec."Clearance Reason")
                {
                    ApplicationArea = All;
                }
                field("Clearance Status"; Rec."Clearance Status")
                {
                    Editable = false;
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
            }
        }
    }

    actions
    {
    }
}

