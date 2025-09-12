page 40065 "Institution Request Card"
{

    PageType = Card;
    SourceTable = "Institutional Request";
    Caption = 'Institution Request Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Request Number"; "Request Number") { }
                field("Institution Code"; "Institution Code") { }
                field("Institution Name"; "Institution Name") { }
                field("Contact Email"; "Contact Email") { }
                field("Phone Number"; "Phone Number") { }
                field(Semester; rec.Semester) { }
                field("Academic Year"; rec."Academic Year") { }
                field(Status; rec.Status) { }
            }
            group("Approval Workflow")
            {
                // --- Admin First Stage ---
                group("Admin (Stage 1)")
                {
                    field("Assigned Admin ID"; Rec."Assigned Admin ID") { ApplicationArea = All; }
                    field("Admin Comment"; Rec."Admin Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::Open;
                    }
                }

                // --- Director First Stage ---
                group("Director (Stage 1)")
                {
                    field("Assigned Director ID"; Rec."Assigned Director ID") { ApplicationArea = All; }
                    field("Director Comment"; Rec."Director Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Pending Director Approval";
                    }
                }

                // --- HOD Stage ---
                group("Head of Department (Stage)")
                {
                    field("Assigned HOD ID"; Rec."Assigned HOD ID") { ApplicationArea = All; }
                    field("HOD Comment"; Rec."HOD Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Pending HOD Feedback";
                    }
                }

                // --- Director Second Stage ---
                group("Director (Stage 2)")
                {
                    field("Assigned Director ID2"; Rec."Assigned Director ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Caption = 'Assigned Director ID';
                    }
                    field("Director Comment2"; Rec."Director Comment")
                    {
                        ApplicationArea = All;
                        Caption = 'Director Comment';
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Director Review (Post-HOD)";
                    }
                }

                // --- Admin Second Stage ---
                group("Admin (Stage 2)")
                {
                    field("Assigned Admin ID2"; Rec."Assigned Admin ID")
                    {
                        Caption = 'Assigned Admin ID';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Admin Comment2"; Rec."Admin Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Admin Comment';
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Pending External Confirmation";
                    }
                }

                // --- Finance Stage ---
                group("Finance")
                {
                    field("Assigned Finance ID"; Rec."Assigned Finance ID") { ApplicationArea = All; }
                    field("Finance Comment"; Rec."Finance Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Pending Finance";
                    }
                }

                // --- Admissions Stage ---
                group("Admissions")
                {
                    field("Assigned Admissions ID"; Rec."Assigned Admissions ID") { ApplicationArea = All; }
                    field("Admissions Comment"; Rec."Admissions Comment")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Editable = Rec."Approval Status" = Rec."Approval Status"::"Pending Admissions";
                    }
                }

                field("Approval Status"; Rec."Approval Status") { ApplicationArea = All; Editable = false; }
            }

            group("Rotation Areas")
            {
                part("External Request Areas"; "External Request Areas")
                {
                    SubPageLink = "Request Number" = field("Request Number");
                }
            }
            group("Students Involved")
            {
                part(Lines; "Institution Request Line Part")//"External Request Areas"
                {
                    SubPageLink = "Request Number" = field("Request Number");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendForApproval)
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify(true);
                    Message('Request sent for approval.');
                end;
            }

            action(ApproveRequest)
            {
                Caption = 'Admit';
                Image = Approve;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending Admissions";
                ApplicationArea = All;

                trigger OnAction()
                var
                    Line: Record "Institution Request Line";
                    CustomerRec: Record Customer;
                    NewCustomer: Record Customer;
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Finance";
                    Rec.Modify(true);

                    Line.SetRange("Request Number", Rec."Request Number");
                    if Line.FindSet() then
                        repeat
                            if not CustomerRec.Get(Line."Student Number") then begin
                                NewCustomer.Init();
                                NewCustomer."No." := Line."Student Number";
                                NewCustomer.Name := Line."Student Name";
                                NewCustomer."Phone No." := Line."Phone Number";
                                NewCustomer."E-Mail" := Line."School Email";
                                NewCustomer.Insert(true);
                            end;
                        until Line.Next() = 0;

                    Message('Request approved and students inserted into student list.');
                end;
            }
            // --- Admin sends to Director ---
            action(SendToDirector)
            {
                Caption = 'Send to Director';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::Open;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Director Approval";
                    Rec.Modify(true);
                    Message('Request sent to Director for approval.');
                end;
            }

            // --- Director sends to HOD ---
            action(SendToHOD)
            {
                Caption = 'Send to HOD';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending Director Approval";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending HOD Feedback";
                    Rec.Modify(true);
                    Message('Request sent to HOD for slot verification.');
                end;
            }

            // --- HOD returns to Director ---
            action(ReturnToDirector)
            {
                Caption = 'Return to Director';
                Image = Approve;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending HOD Feedback";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Director Review (Post-HOD)";
                    Rec.Modify(true);
                    Message('HOD feedback sent back to Director.');
                end;
            }

            // --- Director sends back to Admin after HOD feedback ---
            action(ReturnToAdmin)
            {
                Caption = 'Return to Admin';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Director Review (Post-HOD)";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending External Confirmation";
                    Rec.Modify(true);
                    Message('Director returned request to Admin for external confirmation.');
                end;
            }

            // --- Admin sends to Finance after external confirmation ---
            action(SendToAdmssions)
            {
                Caption = 'Send to Admisssions';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending External Confirmation";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Admissions";
                    Rec.Modify(true);
                    Message('Request forwarded to Admissions office for admissions.');
                end;
            }

            // --- Admissions  sends to Finance ---
            action(SendToFinance)
            {
                Caption = 'Send to Finance';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending Admissions";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Finance";
                    Rec.Modify(true);
                    Message(' Request forwarded to Finance for fee processing.');
                end;
            }

            // --- Finance completes the process ---
            action(MarkAsCompleted)
            {
                Caption = 'Finance Complete';
                Image = Approve;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending Finance";
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::Completed;
                    Rec.Modify(true);
                    Message(' Request process completed successfully.');
                end;
            }

            // --- Reject at any stage ---
            action(RejectRequest)
            {
                Caption = 'Reject Request';
                Image = Cancel;
                Visible = Rec."Approval Status" in
                    [Rec."Approval Status"::"Pending Director Approval",
                     Rec."Approval Status"::"Pending HOD Feedback",
                     Rec."Approval Status"::"Director Review (Post-HOD)",
                     Rec."Approval Status"::"Pending External Confirmation",
                     Rec."Approval Status"::"Pending Finance",
                     Rec."Approval Status"::"Pending Admissions"];
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Approval Status" := Rec."Approval Status"::Rejected;
                    Rec.Modify(true);
                    Message('Request has been rejected.');
                end;
            }


            action(RejectRequest2)
            {
                Caption = 'Reject Request';
                Image = Cancel;
                Visible = Rec.Status = Rec.Status::"Pending Approval";
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                    Message('Request has been rejected.');
                end;
            }
        }
    }

}
