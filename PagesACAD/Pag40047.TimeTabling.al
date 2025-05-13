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
                        RunObject = Page "ACA-LectureHalls Setup";//TT-Days List
                        ApplicationArea = All;
                    }
                    action("Days Of Week")
                    {
                        Image = RefreshDiscount;
                        RunObject = Page "TT-Days List";//TT-Daily Lessons List
                        ApplicationArea = All;
                    }
                    action("Times Of The Day")
                    {
                        Image = RefreshDiscount;
                        RunObject = Page "TT-Daily Lessons List";
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
            group("General Set Up Management")
            {
                action(Buildings2)
                {
                    Caption = 'Buildings';
                    Image = Insurance;
                    RunObject = Page "ACA-Buildings Setup";
                    ApplicationArea = All;
                }
                action(lecHalls2)
                {
                    Image = RefreshDiscount;
                    Caption = 'Lecture Halls';
                    RunObject = Page "ACA-LectureHalls Setup";//TT-Days List
                    ApplicationArea = All;
                }
                action("Days Of Week2")
                {
                    Image = RefreshDiscount;
                    Caption = 'Days Of Week';
                    RunObject = Page "TT-Days List";//TT-Daily Lessons List
                    ApplicationArea = All;
                }
                action("Times Of The Day2")
                {
                    Image = RefreshDiscount;
                    Caption = 'Times Of The Day';
                    RunObject = Page "TT-Daily Lessons List";
                    ApplicationArea = All;
                }
            }
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
                    RunObject = Page "Examination Timetable List";//"Consolidated Exam list"
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Approved));
                }
                action("Consolidated Exam list")
                {
                    Caption = 'Consolidated Exam TimeTable';
                    Image = List;
                    RunObject = Page "Consolidated Exam list";
                    ApplicationArea = All;
                    RunPageView = WHERE(Status2 = FILTER(Approved));
                }

            }



        }
        area(reporting)
        {
            group(Periodic)
            {
                Caption = 'Periodic Reports';
                action("Teaching TimeTable")
                {
                    ApplicationArea = basic, suit;
                    Caption = 'Consolidated  Teaching Timetable';
                    Image = Report;
                    RunObject = report "Teaching  Timetable";
                }
                action("Exam TimeTable")
                {
                    ApplicationArea = basic, suit;
                    Caption = 'Consolidated  Exam Timetable';
                    Image = Report;
                    RunObject = report "ExamTimetable";
                }


            }
        }


    }
}

