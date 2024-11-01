page 78033 "ACA-Scholarship Batches Card"
{
    PageType = Card;
    Caption = 'Scholarship Batch Card';
    PromotedActionCategories = 'New,Process,Reports,Post Allocation';
    SourceTable = "ACA-Scholarship Batches";

    layout
    {
        area(Content)
        {
            group("Batch Information")
            {


                field("No."; Rec."No.")
                {

                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }

                field("Scholarship Code"; Rec."Scholarship Code")
                {
                    ToolTip = 'Specifies the value of the Scholarship Code field.';
                    ApplicationArea = All;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ToolTip = 'Specifies the value of the Scholarship Name field.';
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Batch No. field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Scholarship Status';
                    ApplicationArea = All;
                }
                field("Scholarship Type"; Rec."Scholarship Type")
                {
                    ToolTip = 'Specifies the value of the Scholarship Type field.';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.';
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                    ApplicationArea = All;
                }


                field("Batch Date"; Rec."Batch Date")
                {
                    ToolTip = 'Specifies the value of the Batch Date field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Allocating Bank Account field.';
                    ApplicationArea = All;
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Allocated Amount field.';
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        rec."UnAllocated Amount" := rec."Receipt Amount" - rec."Allocated Amount";
                    end;

                }
                field("UnAllocated Amount"; Rec."UnAllocated Amount")
                {
                    ToolTip = 'Specifies the value of the Allocated Amount field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Students "; Rec."No. of Students ")
                {
                    ToolTip = 'Specifies the value of the No. of Students  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt No"; Rec."Receipt No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Receipt No';
                }
            }
            part("ACA-Scholarship Allocation"; "ACA-Scholarship Allocation")
            {
                ApplicationArea = all;
                SubPageLink = "Transaction Code" = field("No."),
                "Batch No." = field("Batch No.");
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(PostReceipts)
            {

                ApplicationArea = all;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction();
                begin
                    PostReceipts.PostReceiptBuffer(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        rec."UnAllocated Amount" := rec."Receipt Amount" - rec."Allocated Amount";

    end;

    var
        PostReceipts: Codeunit "Post Stud Receipt Buffer";
}