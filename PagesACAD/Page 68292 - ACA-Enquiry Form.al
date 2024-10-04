page 68292 "ACA-Enquiry Form"
{
    PageType = Card;
    SourceTable = 61348;
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enquiry Date"; Rec."Enquiry Date")
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
                field(Intake; Rec.Intake)
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field("How You knew about us"; Rec."How You knew about us")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }
}

