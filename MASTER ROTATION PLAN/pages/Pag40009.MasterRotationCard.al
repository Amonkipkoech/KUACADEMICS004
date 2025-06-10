page 40009 "Master Rotation Plan Card"

{
    PageType = Card;
    SourceTable = "Master Rotation Plan2";

    Caption = 'Consolidated Institute MRP';

    layout
    {
        area(content)
        {
            group("HoD Information")
            {
                Caption = 'General Information';
                field("Plan ID"; rec."Plan ID") { ApplicationArea = All; }
                field(Session; rec.Session)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; rec.Year) { ApplicationArea = all; }
                field("Program Code"; rec."Program Code") { ApplicationArea = All; }
                field("Program Name"; rec."Program Name") { ApplicationArea = All; }
                field("HoD Name"; rec."HoD Name") { ApplicationArea = All; }
                field("Department"; rec.Department) { ApplicationArea = All; }
                field("Phone Number"; rec."Phone Number") { ApplicationArea = All; }
                field("Email"; rec.Email) { ApplicationArea = All; }
                field(Status; rec.Status) { ApplicationArea = All; }
            }




            group("Clinical Classes")
            {
                Caption = 'End Of Block One Clinical Rotation';
                part("Clinical Rotation List"; "Clinical Rotation List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "Plan ID" = field("Plan ID"), Year = field("Year"), Session = field("Session"), Department = field("Department");
                }
            }




        }
    }
    actions
    {
        area(Processing)
        {
            action("Send For Approval")
            {
                Caption = 'Send For Approval';
                Visible = rec.Status = rec.Status::Open;
                trigger OnAction()
                begin
                    rec.status := rec.status::"Pending Approval";
                    Message('Send For Approval Successfully');
                end;
            }
            action("Approve")
            {
                Caption = 'Approve';
                Visible = rec.Status = rec.Status::"Pending Approval";
                trigger OnAction()
                begin
                    rec.status := rec.status::Approved;
                    Message('Approved Successfully');
                end;
            }
            action("Reject")
            {
                Caption = 'Reject';
                Visible = rec.Status = rec.Status::"Pending Approval";
                trigger OnAction()
                begin
                    rec.status := rec.status::Open;
                    Message('Rejected');
                end;
            }
            action(Attachments1)
            {
                ApplicationArea = All;
                Caption = 'MRP Attachments';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "MRP Attachments";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }

            action(Approvals)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                RunObject = page "Approval Entries";
                RunPageLink = "Document No." = field("Plan ID");
                Visible = not (Rec.Status = Rec.Status::Open);
            }
            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    If ApprovalsMgmt.CheckMasterRotationPlansWorkflowEnable(Rec) then
                        ApprovalsMgmt.OnSendMasterRotationPlanForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelMasterRotationPlanForApproval(Rec);
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
        ApprovalsMgmt: CodeUnit "Approval Mgnt. Util.";


}

