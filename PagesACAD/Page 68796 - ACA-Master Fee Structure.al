/// <summary>
/// Page ACA-Master Fee Structure (ID 68796).
/// </summary>
page 68796 "ACA-Master Fee Structure"
{
    PageType = Document;
    SaveValues = true;
    SourceTable = 61555;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Settlemet Type"; Rec."Settlemet Type")
                {
                    ApplicationArea = All;
                }
                field("Seq."; Rec."Seq.")
                {
                    ApplicationArea = All;
                }
                field("Break Down"; Rec."Break Down")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
#pragma warning disable AL0269
            part(mstc; "ACA-Master Std Charges")
#pragma warning restore AL0269
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Update)
            {
                Caption = 'Update';
                action(Programme)
                {
                    Caption = 'Programme';
                    RunObject = Report 51584;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
}

