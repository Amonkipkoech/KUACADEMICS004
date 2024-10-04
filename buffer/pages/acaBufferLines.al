page 84531 "Receipt Buffer Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Imp. Receipts Buffer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Batch No."; Rec."Batch No.")
                // {
                //     ApplicationArea = All;
                // }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Account No.';
                    ApplicationArea = All;
                    Editable = editable;

                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin
                        cust.Get(Rec."Student No.");
                        Name := cust.Name;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = editable;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                // field("Receipt No"; Rec."Receipt No")
                // {
                //     ApplicationArea = All;
                // }
                // field(IDNo; Rec.IDNo)
                // {
                //     ApplicationArea = All;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field("Stud Exist"; Rec."Stud Exist")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    var
        editable: Boolean;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            editable := false
        else
            editable := true;
    end;
}