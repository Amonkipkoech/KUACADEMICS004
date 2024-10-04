page 68293 "ACA-Enquiry List"
{
    CardPageID = "ACA-Enquiry Form";
    PageType = List;
    SourceTable = 61348;
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
                field("Enquiry Date"; Rec."Enquiry Date")
                {
                    ApplicationArea = All;
                }
                field("Name(Surname First)"; Rec."Name(Surname First)")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Passport/National ID Number"; Rec."Passport/National ID Number")
                {
                    ApplicationArea = All;
                }
                field("Permanent Home Address"; Rec."Permanent Home Address")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address"; Rec."Correspondence Address")
                {
                    ApplicationArea = All;
                }
                field("Home Telephone No."; Rec."Home Telephone No.")
                {
                    ApplicationArea = All;
                }
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field("Programme Stage"; Rec."Programme Stage")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Application Fee Receipt No."; Rec."Application Fee Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Application Form Filled"; Rec."Application Form Filled")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = All;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = All;
                }
                field("Registrar Approved"; Rec."Registrar Approved")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(pstSubmit)
            {
                Caption = 'Submit Record';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = false;
                ApplicationArea = All;
            }
        }
    }
}

