page 68782 "ACA-Student Aluminae"
{
    PageType = Document;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            Status = FILTER(Alluminae | "Dropped Out" | Suspended | Expulsion | Discontinued | Deceased | Transferred));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Payments By"; Rec."Payments By")
                {
                    ApplicationArea = All;
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(sms_Password; Rec.sms_Password)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    Caption = 'Religion';
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Caption = 'Posting Group';
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
                field("E-Mail";Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Next Of Kin")
            {
                Caption = 'Next Of Kin';
#pragma warning disable AL0269
                part(nok; "ACA-Student Kin")
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No" = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Education History")
            {
                Caption = 'Education History';
#pragma warning disable AL0269
                part(EH; 68753)
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Comments)
            {
                Caption = 'Comments';
#pragma warning disable AL0269
                part(comm; 68783)
#pragma warning restore AL0269
                {
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("Contact Details")
            {
                Caption = 'Contact Details';
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Sponsor)
            {
                Caption = 'Sponsor';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action("Registration Details")
                {
                    Caption = 'Registration Details';
                    RunObject = Page "ACA-Student Registration";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Re-Activate Record")
                {
                    Caption = 'Re-Activate Record';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to re-activate student?', TRUE) = TRUE THEN BEGIN
                            Rec.Status := Rec.Status::Current;
                            Rec.MODIFY;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Customer Type" := Rec."Customer Type"::Student;
    end;

    var
        PictureExists: Boolean;
}

