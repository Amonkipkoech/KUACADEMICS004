page 84530 "Receipts Buffer Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Receipts Buffer";
    //Editable =   editable;

    layout
    {
        area(Content)
        {
            group("Batch Information")
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = editable;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Editable = editable;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                    Editable = editable;
                }
                // field("Batch No."; Rec."Batch No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Batch No. field.';
                // }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    Editable = editable;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = editable;
                }

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocating Bank Account field.';
                    Editable = editable;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batch Date field.';
                    Editable = editable;
                }
                // field("No. of Students "; Rec."No. of Students ")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the No. of Students  field.';
                // }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                    Editable = editable;

                }

            }
            part("Receipt Buffer Lines"; "Receipt Buffer Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Transaction Code" = field("No.");

            }

        }
         
}

    actions
    {
        area(Processing)
        {
            action("Post Receipts")
            {
                ApplicationArea = All;
                Image = PostBatch;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction();
                begin
                    PostReceipt.PostReceiptBuffer(Rec);
                end;

            }
        }
    }

    var
        PostReceipt: Codeunit "Post Stud Receipt Buff";
        editable: Boolean;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
        editable := false
        else
        editable := true;
    end;

}