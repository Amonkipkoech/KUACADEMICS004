page 40009 "Master Rotation Plan Card"

{
    PageType = Card;
    SourceTable = "Master Rotation Plan2";

    Caption = 'Departmental MRP';

    layout
    {
        area(content)
        {
            group("HoD Information")
            {
                Caption = 'General Information';
                field("Plan ID"; rec."Plan ID") { ApplicationArea = All; }
                field(Session; rec.Session) { ApplicationArea = All; }
                field("Academic Year"; rec.Year) { ApplicationArea = all; }
                field("Program Code"; rec."Program Code") { ApplicationArea = All; }
                field("Program Name"; rec."Program Name") { ApplicationArea = All; }
                field("HoD Name"; rec."HoD Name") { ApplicationArea = All; }
                field("Department"; rec.Department) { ApplicationArea = All; }
                field("Phone Number"; rec."Phone Number") { ApplicationArea = All; }
                field("Email"; rec.Email) { ApplicationArea = All; }
                field(Status; rec.Status) { ApplicationArea = All; }
            }


            group("Theoretical Classes")
            {
                Caption = 'Block One Theory Period';
                field("Block "; rec.Block) { Caption = 'Level'; ApplicationArea = All; }
                field("Start Date"; rec."Start Date") { ApplicationArea = All; }
                field("Start Month"; rec."Start Month") { ApplicationArea = All; }
                field("End Date"; rec."End Date") { ApplicationArea = All; }
                field("End Month"; rec."End Month") { ApplicationArea = All; }
                field("Number of Weeks"; rec."Number of Weeks") { ApplicationArea = All; }

            }

            group("Clinical Classes")
            {
                Caption = 'End Of Block One Clinical Rotation';
                part("Clinical Rotation List"; "Clinical Rotation List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "Plan ID" = field("Plan ID"), Year = field("Year"), Session = field("Session"), Department = field("Department"), Status = field("Status");
                }
            }
            group("Theoretical Classes 2")
            {
                Caption = 'Block Two Theory Period';
                field("Block 2"; rec.Category) { Caption = 'Level'; ApplicationArea = All; }
                field("B2 Start Date"; rec."b2 Start Date") { ApplicationArea = All; }
                field("B2 Start Month"; rec."B2 Start Month") { ApplicationArea = All; }
                field("B2 End Date"; rec." B2 End Date") { ApplicationArea = All; }
                field("B2 End Month"; rec."b2 End Month") { ApplicationArea = All; }
                field("B2 Number of Weeks"; rec."B2 Number of Weeks") { ApplicationArea = All; }

            }

            group("Clinical Classes2")
            {
                Caption = 'End Of Block Two Clinical Rotation';
                part("Clinical Rotation List 2"; "Mrp block 2 rotation ")
                {
                    ApplicationArea = All;
                    SubPageLink = "Plan ID" = field("Plan ID"), Year = field("Year"), Session = field("Session"), Department = field("Department"), Status = field("Status");
                }
            }
            group(" Clinical Leave ")
            {
                Caption = 'Clinical Leave';
                field("leave Category"; rec."leave Category") { Caption = 'Level'; ApplicationArea = All; }
                field("Leave Start Date  "; rec."Leave Start Date  ") { ApplicationArea = All; }
                field("Leave end Date  "; rec."Leave end Date  ") { ApplicationArea = All; }
                field("Leave Period  "; rec."Leave Period  ") { ApplicationArea = All; }

            }
            group("Clinical Classes 3")
            {
                Caption = 'End Of Leave Clinical Rotation';
                part("Clinical Rotation List 3"; "Mrp  end Of Leave rotation")
                {
                    ApplicationArea = All;
                    SubPageLink = "Plan ID" = field("Plan ID"), Year = field("Year"), Session = field("Session"), Department = field("Department"), Status = field("Status");
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
                trigger OnAction()
                begin
                    rec.status := rec.status::"Pending Approval";
                    Message('Send For Approval Successfully');
                end;
            }
            action("Approve")
            {
                Caption = 'Approve';
                trigger OnAction()
                begin
                    rec.status := rec.status::Approved;
                    Message('Approved Successfully');
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

