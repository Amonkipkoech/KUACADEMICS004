page 65218 "Lect Posted Batch Card"
{
    DataCaptionFields = "Semester Code", Status, "Created By";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 65200;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("No of Lecturers"; Rec."No of Lecturers")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
                {
                    ApplicationArea = All;
                }
            }
            part("Loads List"; 65211)
            {
                Caption = 'Loads List';
                Editable = false;
                Enabled = false;
                SubPageLink = "Semester Code" = FIELD("Semester Code");
                SubPageView = WHERE(Approve = FILTER(true),
                                    "Courses Count" = FILTER(> 0));
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        InsertMode: Boolean;
        HideCreditCheckDialogue: Boolean;
        UpdateDocumentDate: Boolean;
        BilltoCustomerNoChanged: Boolean;

}

