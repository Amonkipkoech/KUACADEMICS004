page 68762 "ACA-Time Table Lines"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    ApplicationArea = All;
                }
                field("Lesson Filter"; Rec."Lesson Filter")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF GenSetup.GET() THEN GenSetup.TESTFIELD(GenSetup."Current TT Code");
                        TT.InsertTimeTable(Rec.Code, Rec."Lesson Filter");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        TT: Codeunit "Time Table";
        GenSetup: Record "ACA-General Set-Up";
}

