page 68465 "ACA-Issued Admissions List"
{
    PageType = List;
    SourceTable = 61358;
    SourceTableView = WHERE(Status = CONST("Admission Letter"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ApplicationArea = All;
                }
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    ApplicationArea = All;
                }
                field(School1; Rec.School1)
                {
                    ApplicationArea = All;
                }
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    ApplicationArea = All;
                }
                field("School 2"; Rec."School 2")
                {
                    ApplicationArea = All;
                }
                field("Date of Receipt"; Rec."Date of Receipt")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Former School Code"; Rec."Former School Code")
                {
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = All;
                }
                field("Year of Examination"; Rec."Year of Examination")
                {
                    ApplicationArea = All;
                }
                field("Examination Body"; Rec."Examination Body")
                {
                    ApplicationArea = All;
                }
                field("Mean Grade Acquired"; Rec."Mean Grade Acquired")
                {
                    ApplicationArea = All;
                }
                field("Points Acquired"; Rec."Points Acquired")
                {
                    ApplicationArea = All;
                }
                field("Principal Passes"; Rec."Principal Passes")
                {
                    ApplicationArea = All;
                }
                field("Subsidiary Passes"; Rec."Subsidiary Passes")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = All;
                }
                field("Application Form Receipt No."; Rec."Application Form Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Index Number"; Rec."Index Number")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("HOD User ID"; Rec."HOD User ID")
                {
                    ApplicationArea = All;
                }
                field("HOD Date"; Rec."HOD Date")
                {
                    ApplicationArea = All;
                }
                field("HOD Time"; Rec."HOD Time")
                {
                    ApplicationArea = All;
                }
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    ApplicationArea = All;
                }
                field("Dean User ID"; Rec."Dean User ID")
                {
                    ApplicationArea = All;
                }
                field("Dean Date"; Rec."Dean Date")
                {
                    ApplicationArea = All;
                }
                field("Dean Time"; Rec."Dean Time")
                {
                    ApplicationArea = All;
                }
                field("Dean Recommendations"; Rec."Dean Recommendations")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    ApplicationArea = All;
                }
                field("Batch Time"; Rec."Batch Time")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Recommendation"; Rec."Admission Board Recommendation")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Date"; Rec."Admission Board Date")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Time"; Rec."Admission Board Time")
                {
                    ApplicationArea = All;
                }
                field("Admitted Degree"; Rec."Admitted Degree")
                {
                    ApplicationArea = All;
                }
                field("Admitted Department"; Rec."Admitted Department")
                {
                    ApplicationArea = All;
                }
                field("Deferred Until"; Rec."Deferred Until")
                {
                    ApplicationArea = All;
                }
                field("Date Of Meeting"; Rec."Date Of Meeting")
                {
                    ApplicationArea = All;
                }
                field("Date Of Receipt Slip"; Rec."Date Of Receipt Slip")
                {
                    ApplicationArea = All;
                }
                field("Receipt Slip No."; Rec."Receipt Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admission No"; Rec."Admission No")
                {
                    ApplicationArea = All;
                }
                field("Admitted To Stage"; Rec."Admitted To Stage")
                {
                    ApplicationArea = All;
                }
                field("Admitted Semester"; Rec."Admitted Semester")
                {
                    ApplicationArea = All;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;
                }
                field("Second Choice Stage"; Rec."Second Choice Stage")
                {
                    ApplicationArea = All;
                }
                field("Second Choice Semester"; Rec."Second Choice Semester")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Date Sent for Approval"; Rec."Date Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Post Graduate"; Rec."Post Graduate")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field("Admissable Status"; Rec."Admissable Status")
                {
                    ApplicationArea = All;
                }
                field("Mode of Study"; Rec."Mode of Study")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No"; Rec."Enquiry No")
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
            action(Card)
            {
                RunObject = Page 68493;
                RunPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
            }
        }
    }
}

