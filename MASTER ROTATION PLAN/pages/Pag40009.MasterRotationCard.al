page 40009 "Master Rotation Plan Card"

{
    PageType = Card;
    SourceTable = "Master Rotation Table";

    Caption = 'Master Rotation Plan';

    layout
    {
        area(content)
        {
            group("HoD Information")
            {
                field("Plan ID"; rec."Plan ID") { ApplicationArea = All; }
                field("HoD Name"; "HoD Name") { ApplicationArea = All; }
                field("Department"; Department) { ApplicationArea = All; }
                field("School"; School) { ApplicationArea = All; }
                field("Phone Number"; "Phone Number") { ApplicationArea = All; }
                field("Email"; Email) { ApplicationArea = All; }
                field("Program Code"; "Program Code") { ApplicationArea = All; }
                field("Program Name"; "Program Name") { ApplicationArea = All; }
            }

            group("Theoretical Classes")
            {
                field("Block Name"; "Block Name") { ApplicationArea = All; }
                field("Start Date"; "Start Date") { ApplicationArea = All; }
                field("Start Month"; "Start Month") { ApplicationArea = All; }
                field("End Date"; "End Date") { ApplicationArea = All; }
                field("End Month"; "End Month") { ApplicationArea = All; }
                field("Number of Weeks"; rec."Number of Weeks") { ApplicationArea = All; }
                field("Category"; rec.Category) { ApplicationArea = All; }
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
            // action("Send For Approval")
            // {
            //     trigger OnAction()
            //     begin
            //         rec.status := rec.status::"Pending Approval";
            //     end;
            // }
            // action("Approve")
            // {
            //     trigger OnAction()
            //     begin
            //         rec.status := rec.status::Approved;
            //     end;
            // }
        }
    }
}

