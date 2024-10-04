/// <summary>
/// Page ACA-Units/Subjects Lists (ID 99940).
/// </summary>
page 99940 "ACA-Units/Subjects Lists"
{
    PageType = List;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    ApplicationArea = All;
                }
                field("Exam Category"; Rec."Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Special Programme Class"; Rec."Special Programme Class")
                {
                    ApplicationArea = All;
                }
                field("Default Exam Category"; Rec."Default Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Programme Name"; Rec."Programme Name")
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

