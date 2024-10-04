/// <summary>
/// Page ACA-Exam Setup (ID 69401).
/// </summary>
page 69401 "ACA-Exam Setup"
{
    PageType = List;
    SourceTable = "ACA-Exams Setup";

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
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Max. Score"; Rec."Max. Score")
                {
                    ApplicationArea = All;
                }
                field("% Contrib. Final Score"; Rec."% Contrib. Final Score")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

