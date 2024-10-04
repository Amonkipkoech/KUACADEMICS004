page 68969 "ACA-Clearance Std Approvers"
{
    Caption = 'Clearance Std Approvers';
    PageType = List;
    SourceTable = "ACA-Clearance Std Approvers";

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
                field("Clear By Id"; Rec."Clear By Id")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
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

