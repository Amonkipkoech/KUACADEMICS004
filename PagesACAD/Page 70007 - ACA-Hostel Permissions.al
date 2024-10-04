page 70007 "ACA-Hostel Permissions"
{
    PageType = List;
    SourceTable = "ACA-Hostel Permissions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("Can Allocate Room"; Rec."Can Allocate Room")
                {
                    ApplicationArea = All;
                }
                field("Can Check-Out"; Rec."Can Check-Out")
                {
                    ApplicationArea = All;
                }
                field("Can Switch Room"; Rec."Can Switch Room")
                {
                    ApplicationArea = All;
                }
                field("Can Transfer Student"; Rec."Can Transfer Student")
                {
                    ApplicationArea = All;
                }
                field("Can Reverse Allocation"; Rec."Can Reverse Allocation")
                {
                    ApplicationArea = All;
                }
                field("Can Print Invoice"; Rec."Can Print Invoice")
                {
                    ApplicationArea = All;
                }
                field("Can Create Hostel"; Rec."Can Create Hostel")
                {
                    ApplicationArea = All;
                }
                field("Can Create Room"; Rec."Can Create Room")
                {
                    ApplicationArea = All;
                }
                field("Can Create Room Space"; Rec."Can Create Room Space")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF NOT UserSetup.FINDFIRST THEN ERROR('Access denied!');
        IF UserSetup."Can Post Cust. Deposits" = FALSE THEN ERROR('Access denied!');
    end;

    var
        UserSetup: Record "User Setup";
}

