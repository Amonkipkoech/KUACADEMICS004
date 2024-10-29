page 86022 "Student Request"

{
    Caption = 'Student requests';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
    actions
    {
        area(sections)
        {
            group("Student Requests")
            {
                action("Open Request")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Open);

                }
                action("Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Approved);
                }
                action("Rejected Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Deffered Students";
                    RunPageLink = Status = const(Cancelled);
                }
                action("All Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Deffered Students";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled);
                }
            }
            group("Student Clearance")
            {
                action("Grad")
                {
                    Caption = 'Graduation Award List';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Graduation Award List";

                }
                action("Open Requests")
                {
                    Caption = 'Open Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Open);

                }
                action("Pending Approvals")
                {
                    Caption = 'Pending Approval';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Requestss")
                {
                    Caption = 'Approved Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Approved);
                }
                action("Rejected Requestss")
                {
                    Caption = 'Rejected Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student clearance List";
                    RunPageLink = Status = const(Cancelled);
                }
                action("All Requestss")
                {
                    Caption = 'All Clearance Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Student clearance List";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled);
                }
            }
            group("Gown Issuance Register")
            {
                action("Gown Issuance")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Gown Issuance Card";
                }
                action("Gown Journal")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Gown Issuance Ledger";
                }
            }

            group("Certificate Issuance")
            {
                action("Certificate Issuance List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "ACA-Certificates Issued";

                }
            }

        }
    }
}
