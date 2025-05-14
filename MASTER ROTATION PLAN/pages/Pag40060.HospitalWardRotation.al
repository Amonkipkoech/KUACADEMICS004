page 40060 "Hospital Ward Rotation"
{
    Caption = 'Hospital Ward Rotation';
    PageType = Card;
    SourceTable = "Ward Rotation Management";



    layout
    {
        area(content)
        {
            group("HoD Information")
            {
                Caption = 'General Information';

                field(Session; rec.Session)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; rec.Year) { ApplicationArea = all; }


            }




            group("Hospital Ward Rotation Distribution")
            {
                part("Clinical Rotation List"; "Clinical Rotation List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = Year = field("Year"), Session = field("Session");
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
        }
    }
}

