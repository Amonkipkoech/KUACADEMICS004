page 68967 "ACA-Clearance templates"
{
    Caption = 'Clearance templates';
    PageType = List;
    SourceTable = "ACA-Clearance templates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Clearance Level Code"; Rec."Clearance Level Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Approvers Exists"; Rec."Approvers Exists")
                {
                    ApplicationArea = All;
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Departmental Clearance Users")
            {
                Caption = 'Departmental Clearance Users';
                Image = ApprovalSetup;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 68968;
                RunPageLink = "Clearance Level Code" = FIELD("Clearance Level Code"),
                              Department = FIELD(Department);
                ApplicationArea = All;
            }
        }
    }
}

