page 68130 "ACA-Exams Activities Header"
{
    PageType = Card;
    SourceTable = 61736;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
#pragma warning disable AL0269
                part(Eactv; 68134)
#pragma warning restore AL0269
                {
                    SubPageLink = Code = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

