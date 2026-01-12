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
                Caption = 'Rotation Areas Management';
                action("Rotation Areas 2")
                {
                    Image = Allocate;
                    Caption = 'Rotation Areas';
                    RunObject = Page "Rotation Areas";//"Rotation Area Wards"
                    ApplicationArea = All;
                }
                action("Rotation Area Wards")
                {
                    Image = Allocate;
                    Caption = 'Rotation Area Wards';
                    RunObject = Page "Rotation Area Wards";//"Institute List"
                    ApplicationArea = All;
                }
            }
            group("External Request Management")
            {
                action("Institute List")
                {
                    Image = Allocate;
                    Caption = 'Institute Master List';
                    RunObject = Page "Institute List";
                    ApplicationArea = All;
                }

                action("Requests - Open")
                {
                    Image = List;
                    Caption = 'Requests - Open';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST(Open));
                    ApplicationArea = All;
                }

                action("Requests - Director Approval")
                {
                    Image = Question;
                    Caption = 'Requests - Pending Director';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Pending Director Approval"));
                    ApplicationArea = All;
                }

                action("Requests - HOD Feedback")
                {
                    Image = Question;
                    Caption = 'Requests - Pending HOD';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Pending HOD Feedback"));
                    ApplicationArea = All;
                }

                action("Requests - Director Review")
                {
                    Image = Question;
                    Caption = 'Requests - Director (Post-HOD)';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Director Review (Post-HOD)"));
                    ApplicationArea = All;
                }

                action("Requests - External Confirmation")
                {
                    Image = Question;
                    Caption = 'Requests - External Confirmation';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Pending External Confirmation"));
                    ApplicationArea = All;
                }

                action("Requests - Admissions")
                {
                    Image = Approve;
                    Caption = 'Requests - Pending Admissions';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Pending Admissions"));
                    ApplicationArea = All;
                }

                action("Requests - Finance")
                {
                    Image = Approve;
                    Caption = 'Requests - Pending Finance';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST("Pending Finance"));
                    ApplicationArea = All;
                }

                action("Requests - Completed")
                {
                    Image = Approve;
                    Caption = 'Requests - Completed';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST(Completed));
                    ApplicationArea = All;
                }

                action("Requests - Rejected")
                {
                    Image = Cancel;
                    Caption = 'Requests - Rejected';
                    RunObject = Page "Institution Request List";
                    RunPageView = WHERE("Approval Status" = CONST(Rejected));
                    ApplicationArea = All;
                }
            }

            group("Student MRP  Management")
            {
                action("Student Group  Assignmnets ")
                {
                    Image = Allocate;
                    RunObject = Page "Group Assignmnets ";
                    ApplicationArea = All;
                }
                action("Student Ward Performance ")
                {
                    Image = Allocate;
                    RunObject = Page "Student Ward Performance";
                    ApplicationArea = All;
                }
            }

            group(GroupName)
            {

                Caption = 'Institute MRP Management';
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
                    Visible = false;
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
                    RunObject = Page "Mrp Approved ";//"Consolidated Ward MRP"
                    ApplicationArea = All;
                }
                action("Consolidated  MRP ")
                {
                    Image = Allocate;
                    Caption = 'Consolidated  MRP';
                    RunObject = Page "Consolidated Ward MRP";
                    ApplicationArea = All;
                }
            }
            group("Hospital Ward  Management")
            {
                action("Consolidated Ward MRP ")
                {
                    Image = Allocate;
                    Caption = 'Ward MRP Distributions';
                    RunObject = Page "Consolidated Ward MRP";
                    ApplicationArea = All;
                }
            }
            group("Duty Rota  Management")
            {
                action("View Open Rotas")
                {
                    ApplicationArea = All;
                    Caption = 'Open Duty Rotas';
                    Image = View;
                    RunObject = Page "Student Duty Rotas List";
                    RunPageView = where(Status = filter(Open));

                }

                action("View Released Rotas")
                {
                    ApplicationArea = All;
                    Caption = 'Released Duty Rotas';
                    Image = View;
                    RunObject = Page "Student Duty Rotas List";
                    RunPageView = where(Status = filter(Released));
                }
                action("Student Duty Rotas List")
                {
                    ApplicationArea = All;
                    Caption = 'Student Duty Rotas List';
                    Image = View;
                    RunObject = Page "Student Duty Rotas List";
                    RunPageView = where(Status = filter(Released));
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
                    RunObject = report "Mrp Report 3 ";//"Student Ward Performance Repor"
                    ApplicationArea = ALL;
                }
                action("Student Ward Performance Report")
                {
                    Image = Register;
                    Caption = 'Student Ward Performance Report';
                    RunObject = report "Student Ward Performance Repor";
                    ApplicationArea = ALL;
                }



            }
        }


    }
}

