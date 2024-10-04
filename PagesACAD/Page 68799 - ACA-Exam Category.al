page 68799 "ACA-Exam Category"
{
    PageType = List;
    SourceTable = 61568;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Transcript Comments")
            {
                Caption = 'Transcript Comments';
                Image = Category;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-Cat. Transc. Comments";
                RunPageLink = "Exam Catogory" = FIELD(Code);
                ApplicationArea = All;
            }
            action("Exam Setup")
            {
                Caption = 'Exam Setup';
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-Exam Setup";
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
            action("Grading System")
            {
                Caption = 'Grading System';
                Image = Continue;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ACA-Grading System";
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}

