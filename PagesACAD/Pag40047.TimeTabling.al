page 40047 TimeTabling
{
    Caption = 'TimeTabling';
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
            group(contrl)
            {
#pragma warning disable AL0269
                part("Students List"; "ACA-Std Card List")
#pragma warning restore AL0269
                {
                    ApplicationArea = All;
                    Caption = 'Students List';
                }
            }




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

                    action(Buildings)
                    {
                        Image = Insurance;
                        RunObject = Page "ACA-Buildings Setup";
                        ApplicationArea = All;
                    }
                    action(lecHalls)
                    {
                        Image = RefreshDiscount;
                        RunObject = Page "ACA-LectureHalls Setup";
                        ApplicationArea = All;
                    }

                }
            }
        }
        area(embedding)
        {
        }
        area(sections)
        {
            group(Timetabling)
            {
                Caption = 'Teaching Timetable Management';
                Image = Statistics;
                action("Lecture Buildings")
                {
                    Caption = 'Lecture Buildings';
                    Image = Register;
                    RunObject = Page "Aca Buildings ";
                    ApplicationArea = All;

                }
                action("Lecture Halls")
                {
                    Caption = 'Lecture Halls';
                    Image = Register;
                    RunObject = Page "ACA-LectureHalls Setup";
                    ApplicationArea = All;

                }
                action(OpenTimetables)
                {
                    Caption = 'Open Departmental Timetables';
                    Image = List;
                    RunObject = Page "Time Table List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Open));
                }

                action(PendingApprovalTimetables)
                {
                    Caption = 'Pending Departmental Approval Timetables';
                    Image = List;
                    RunObject = Page "Time Table List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER("Pending Approval"));
                }

                action(RejectedTimetables)
                {
                    Caption = 'Rejected Departmental Timetables';
                    Image = List;
                    RunObject = Page "Time Table List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Rejected));
                }

                action(ApprovedTimetables)
                {
                    Caption = 'Approved Departmental Timetables';
                    Image = List;
                    RunObject = Page "Time Table List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Approved));
                }
                action(TimetableCentral1)
                {
                    Caption = 'Consolidated Teaching Timetable';
                    Image = Register;
                    RunObject = Page "ConsolidateD Teaching Tbl";
                    ApplicationArea = All;

                }

            }
            group(TimetablingExam)
            {
                Caption = 'Exam Timetable Management';
                Image = Statistics;
                action("Exam Lecture Buildings")
                {
                    Caption = 'Lecture Buildings';
                    Image = Register;
                    RunObject = Page "Aca Buildings ";
                    ApplicationArea = All;

                }
                action("Exam Lecture Halls")
                {
                    Caption = 'Lecture Halls';
                    Image = Register;
                    RunObject = Page "ACA-LectureHalls Setup";
                    ApplicationArea = All;

                }
                action(OpenExamTimetables)
                {
                    Caption = 'Open Departmental Exam Timetables';
                    Image = List;
                    RunObject = Page "Examination Timetable List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Open));
                }

                action(PendingApprovalExamTimetables)
                {
                    Caption = 'Pending Departmental Approval Exam Timetables';
                    Image = List;
                    RunObject = Page "Examination Timetable List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER("Pending Approval"));
                }

                action(RejectedExamTimetables)
                {
                    Caption = 'Rejected Departmental Exam Timetables';
                    Image = List;
                    RunObject = Page "Examination Timetable List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Rejected));
                }

                action(ApprovedExamTimetables)
                {
                    Caption = 'Approved Departmental Exam Timetables';
                    Image = List;
                    RunObject = Page "Examination Timetable List";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Approved));
                }


            }

            group(Setups)
            {
                Caption = 'Setups';
                Image = Setup;
                action(Programmes)
                {
                    Caption = 'Programmes';
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action(Nationality)
                {
                    Caption = 'Nationality';
                    RunObject = Page 68868;
                    ApplicationArea = All;
                }
                action("Marketing Strategies")
                {
                    Caption = 'Marketing Strategies';
                    RunObject = Page 68865;
                    ApplicationArea = All;
                }
                action("Schools/Faculties")
                {
                    Caption = 'Schools/Faculties';
                    RunObject = Page 68832;
                    ApplicationArea = All;
                }
                action(Religions)
                {
                    Caption = 'Religions';
                    RunObject = Page 68841;
                    ApplicationArea = All;
                }
                action(Denominations)
                {
                    Caption = 'Denominations';
                    RunObject = Page 68842;
                    ApplicationArea = All;
                }
                action("Insurance Companies")
                {
                    Caption = 'Insurance Companies';
                    ApplicationArea = All;
                    //RunObject = Page 68844;
                }
                action(Relationships)
                {
                    Caption = 'Relationships';
                    RunObject = Page 68845;
                    ApplicationArea = All;
                }
                action(Counties)
                {
                    Caption = 'Counties';
                    RunObject = Page 68871;
                    ApplicationArea = All;
                }
                action("Clearance Codes")
                {
                    Caption = 'Clearance Codes';
                    Image = Setup;
                    RunObject = Page 68966;
                    ApplicationArea = All;
                }
                action("Registration List")
                {
                    Image = Allocations;
                    RunObject = Page 69187;
                    ApplicationArea = All;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page 658;
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page 662;
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page 68970;
                    ApplicationArea = All;
                }
            }

        }
        area(reporting)
        {
            group(Periodic)
            {
                Caption = 'Periodic Reports';

            }
        }


    }
}

