page 40009 "Master Rotation Plan Card"

{
    PageType = Card;
    SourceTable = "Master Rotation Plan2";

    Caption = 'Master Rotation Plan';

    layout
    {
        area(content)
        {
            group("HoD Information")
            {
                field("Plan ID"; rec."Plan ID") { ApplicationArea = All; }
                field("HoD Name"; rec."HoD Name") { ApplicationArea = All; }
                field("Department"; rec.Department) { ApplicationArea = All; }
                field("Phone Number"; rec."Phone Number") { ApplicationArea = All; }
                field("Email"; rec.Email) { ApplicationArea = All; }
                field("Program Code"; rec."Program Code") { ApplicationArea = All; }
                field("Program Name"; rec."Program Name") { ApplicationArea = All; }
                field(Status; rec.Status) { ApplicationArea = All; }
            }


            group("Theoretical Classes")
            {
                field("Block "; rec."Block Name") { ApplicationArea = All; }
                field("Start Date"; rec."Start Date") { ApplicationArea = All; }
                field("Start Month"; rec."Start Month") { ApplicationArea = All; }
                field("End Date"; rec."End Date") { ApplicationArea = All; }
                field("End Month"; rec."End Month") { ApplicationArea = All; }
                field("Number of Weeks"; rec."Number of Weeks") { ApplicationArea = All; }

            }

            group("Clinical Classes")
            {

                part("Clinical Rotation List"; "Clinical Rotation List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "Plan ID" = field("Plan ID");
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
        }
    }
}

