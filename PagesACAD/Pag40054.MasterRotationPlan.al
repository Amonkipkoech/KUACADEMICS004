page 40054 "Master Rotation Plan"

{
    Caption = 'Master Rotation Plan';
    PageType = RoleCenter;



    layout
    {
        area(rolecenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            //             group(contrl)
            //             {
            // #pragma warning disable AL0269
            //                 part("Students List"; "ACA-Std Card List")
            // #pragma warning restore AL0269
            //                 {
            //                     ApplicationArea = All;
            //                     Caption = 'Students List';
            //                 }
            //             }




        }
    }

    actions
    {
        area(processing)
        {
            group("General Setups")
            {
                Caption = 'General Setups';
                group(SetupsG)
                {
                    Caption = 'Setups';

                    action("Rotation Areas 4")
                    {
                        Image = Allocate;
                        Caption = 'Rotation Areas';
                        RunObject = Page "Rotation Areas";
                        ApplicationArea = All;
                    }

                }
            }
        }
        area(embedding)
        {
            action("Rotation Areas 3")
            {
                Image = Allocate;
                Caption = 'Rotation Areas';
                RunObject = Page "Rotation Areas";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("General Set Up Management")
            {
                action("Rotation Areas 2")
                {
                    Image = Allocate;
                    Caption = 'Rotation Areas';
                    RunObject = Page "Rotation Areas";
                    ApplicationArea = All;
                }
            }

            group(GroupName)
            {

                Caption = 'Master Rotation Management';
                Image = ResourcePlanning;
                action("Students on Session")
                {
                    Image = Allocate;
                    RunObject = Page "Student Session Registration";
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Rotation Areas")
                {
                    Image = Allocate;
                    RunObject = Page "Rotation Areas";
                    ApplicationArea = All;
                }
                action("Group Assignmnets ")
                {
                    Image = Allocate;
                    RunObject = Page "Group Assignmnets ";
                    ApplicationArea = All;
                }

                action("Open Department MRP")
                {
                    Image = Allocate;
                    Caption = 'Open Department MRP';
                    RunObject = Page "MRP List";

                    ApplicationArea = All;
                }
                action("Pending Approval Dep MRP")
                {
                    Image = Allocate;
                    Caption = 'Pending Approval Dep MRP';
                    RunObject = Page "Mrp Pending Approval";

                    ApplicationArea = All;
                }
                action("Approved Dep MRP ")
                {
                    Image = Allocate;
                    Caption = ' Approved Dep MRP';
                    RunObject = Page "Mrp Approved ";
                    ApplicationArea = All;
                }
            }



        }
        area(reporting)
        {
            group(Periodic)
            {
                Caption = 'Periodic Reports';
                action("mrp")
                {
                    Image = Register;
                    Caption = 'Consolidated Master Rotation Report';
                    RunObject = report "Mrp Report 3 ";
                    ApplicationArea = ALL;
                }



            }
        }


    }
}

