/// <summary>
/// Page ACA-Grading System (ID 69402).
/// </summary>
page 69402 "ACA-Grading System"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Exam Gradding Setup";
    SourceTableView = SORTING(Grade)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Up to"; Rec."Up to")
                {
                    ApplicationArea = All;
                }
                field(Range; Rec.Range)
                {
                    ApplicationArea = All;
                }
                field(Failed; Rec.Failed)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Results Exists Status"; Rec."Results Exists Status")
                {
                    ApplicationArea = All;
                }
                field("Consolidated Prefix"; Rec."Consolidated Prefix")
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

