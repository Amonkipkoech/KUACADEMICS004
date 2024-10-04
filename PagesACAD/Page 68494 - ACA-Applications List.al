/// <summary>
/// Page ACA-Applications List (ID 68494).
/// </summary>
page 68494 "ACA-Applications List"
{
    CardPageID = "ACA-Application Form Header";
    PageType = List;
    SourceTable = "ACA-Applic. Form Header";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                Editable = false;
                field("Application No."; Rec."Application No.")
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Application Form")
                {
                    Caption = 'Application Form';
                    RunObject = Page 68467;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Department Approval")
                {
                    Caption = 'Department Approval';
                    RunObject = Page 68481;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("School/Faculty Approval")
                {
                    Caption = 'School/Faculty Approval';
                    RunObject = Page 68482;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Deans Approval")
                {
                    Caption = 'Deans Approval';
                    RunObject = Page 68484;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit()
    begin
        //CurrPage.LOOKUPMODE := TRUE;
    end;
}

