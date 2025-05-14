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
                field(Semester; Semester) { }
                field("Academic Year"; "Academic Year") { }
                field(Status; Status) { }
            }

            group("Students Involved")
            {
                part(Lines; "Institution Request Line Part")
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
                Visible = Rec.Status = Rec.Status::Open;
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
                Caption = 'Approve Request';
                Image = Approve;
                Visible = Rec.Status = Rec.Status::"Pending Approval";
                ApplicationArea = All;

                trigger OnAction()
                var
                    Line: Record "Institution Request Line";
                    CustomerRec: Record Customer;
                    NewCustomer: Record Customer;
                begin
                    Rec.Status := Rec.Status::Approved;
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

                    Message('Request approved and students inserted into customer list.');
                end;
            }

            action(RejectRequest)
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
