page 86014 "Student Clearance Card"
{
    Caption = 'Student Clearance Card';
    PageType = Card;
    SourceTable = "Student Clerance";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Clearance No"; Rec."Clearance No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearance No field.', Comment = '%';
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field("Student Name "; Rec."Student Name ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Graduation Fee Paid"; Rec."Graduation Fee Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Graduation Fee Paid field.', Comment = '%';
                }
            }
            group("Head of Department")
            {


                field("Department Cleared"; Rec."Department Cleared")
                {
                    ApplicationArea = All;
                }
                field("Department Cleared Name"; Rec."  Department Clearance Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
                field("HoD Name"; rec."HoD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
            }
            group("Library Approval")
            {


                field("Library Cleared&"; rec."Library Cleared&")
                {
                    ApplicationArea = All;
                }
                field("Librarian Name"; rec."Library Cleared Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
                field("Librarian"; rec."Library Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
            }
            group("Finance Approval")
            {


                field("Finance Cleared"; rec."Finance Cleared&")
                {
                    ApplicationArea = All;
                }
                field("Finance Name"; rec."Finance Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
                field("finance Clearance Remarks"; rec."library Clearance Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
            }
            group("Head of Institute")
            {


                field("Head of Institute Name"; rec."Head of Institute Name")
                {
                    ApplicationArea = All;
                }
                field("Head of InstituteCleared"; rec."Head of InstituteCleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
                field("Head of Institute remarks"; "Head of Institute remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
            }
            group("Head Of Ict Approval")
            {


                field("Ict Name"; rec."Ict Name")
                {
                    ApplicationArea = All;
                }
                field("ICT Cleared"; rec."ICT Cleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
                field("Ict  Clearance Remarks"; rec."Ict  Clearance Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Cleared Name field.', Comment = '%';
                }
            }

            // field("Accomodation Cleared"; Rec."Library Cleared")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Accomodation Cleared field.', Comment = '%';
            // }
            // field("Accomodation Cleared Name"; Rec."Accomodation Cleared Name")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Accomodation Cleared Name field.', Comment = '%';
            // }
            // field("School Cleared"; Rec."School Cleared")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the School Cleared field.', Comment = '%';
            // }
            // field("School Cleared Name"; Rec."School Cleared Name")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the School Cleared Name field.', Comment = '%';
            // }
            // field("Dean of Students"; Rec."Dean of Students")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Dean of Students field.', Comment = '%';
            // }
            // field("Dean of Students Name"; Rec."Dean of Students Name")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Dean of Students Name field.', Comment = '%';
            // }
            // field("Student ID Card Returned"; Rec."Student ID Card Returned")
            // {
            //     ApplicationArea = All;
            // }
            // field("Staff Collecting ID"; Rec."Staff Collecting ID")
            // {
            //     ApplicationArea = All;
            // }
            // field("ID Return Date"; Rec."ID Return Date")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            // field(Library; Rec.Library)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Library field.', Comment = '%';
            // }
            // field("Library Cleared Name"; Rec."Library Cleared Name")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Library Cleared Name field.', Comment = '%';
            // }
            // field("Sports and Games Cleared Name"; Rec."Sports and Games Cleared Name")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Sports and Games Cleared Name field.', Comment = '%';
            // }
            // field("Sports and games"; Rec."Sports and games")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Sports and games field.', Comment = '%';
            // }
            // field("UESA Cleared"; Rec."UESA Cleared")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the UESA Cleared field.', Comment = '%';
            // }
            // field("UESA Cleared Name"; Rec."UESA Cleared Name")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the UESA Cleared Name field.', Comment = '%';
            // }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    If ApprovalsMgmt.CheckstudentClearanceWorkflowEnable(Rec) then
                        ApprovalsMgmt.OnSendstudentClearanceForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelstudentClearanceForApproval(Rec);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = (Rec.Status = Rec.Status::Cancelled);

                trigger OnAction()
                var
                    SuccessMsg: Label 'The Document has been re-openned successfully';
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Message(SuccessMsg);
                    CurrPage.Update();
                end;
            }
        }
    }
    var
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}

