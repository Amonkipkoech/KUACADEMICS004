page 40028 "Supp Exam Registration Card"
{
    PageType = Card;

    SourceTable = "Supp Exam Registration Header";
    Caption = 'Supplementary Exam Application';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Application No."; rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Student Full Name"; rec."Student Full Name")
                {
                    ApplicationArea = All;
                }

                field("Student Admission No."; rec."Student Admission No.")
                {
                    ApplicationArea = All;
                }

                field("Program"; rec."Program")
                {
                    ApplicationArea = All;
                }
                field(Status; REC.Status)
                {
                    ApplicationArea = All;
                }
            }

            part(ListPart; "Supp Exam Reg ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "Application No." = FIELD("Application No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = rec.Status = rec.Status::open;
                trigger OnAction()
                begin
                    rec.Status := rec.Status::"Pending Approval";
                end;
            }
            action(Approved)
            {
                Visible = rec.Status = rec.Status::"Pending Approval";
                trigger OnAction()
                begin
                    rec.Status := rec.Status::Approved;
                end;
            }
            action(Reject)
            {
                Visible = rec.Status = rec.Status::"Pending Approval";
                trigger OnAction()
                begin
                    rec.Status := rec.Status::Rejected;
                end;
            }
        }
    }
}

