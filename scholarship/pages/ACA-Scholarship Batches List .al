page 78031 "ACA-Scholarship Batches"
{
    CardPageId = "ACA-Scholarship Batches Card";
    PageType = List;
    Caption = 'Scholarship Batches List';
    ModifyAllowed = false;

    SourceTable = "ACA-Scholarship Batches";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
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
                field("Scholarship Type"; Rec."Scholarship Type")
                {
                    ToolTip = 'Specifies the value of the Scholarship Type field.';
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Batch No. field.';
                    ApplicationArea = All;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    ToolTip = 'Specifies the value of the Batch Date field.';
                    ApplicationArea = All;
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                    ApplicationArea = All;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ToolTip = 'Specifies the value of the Allocated Amount field.';
                    ApplicationArea = All;
                }
                field("No. of Students "; Rec."No. of Students ")
                {
                    ToolTip = 'Specifies the value of the No. of Students  field.';
                    ApplicationArea = All;
                }
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}