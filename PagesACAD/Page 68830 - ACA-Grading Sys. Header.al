page 68830 "ACA-Grading Sys. Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                RunObject = Page 69401;
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
            action("Grading System")
            {
                Caption = 'Grading System';
                Image = Continue;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 69402;
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
            action("Provisional Transcript Comments")
            {
                Caption = 'Provisional Transcript Comments';
                Image = CreateInventoryPickup;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 88853;
                RunPageLink = "Exam Category" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}
