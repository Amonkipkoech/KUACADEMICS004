page 68968 "ACA-Clearance Dept. Approvers"
{
    Caption = 'Clearance Dept. Approvers';
    PageType = List;
    SourceTable = "ACA-Clearance Dept. Approvers";

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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Clear By Id"; Rec."Clear By Id")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
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
    }
}

