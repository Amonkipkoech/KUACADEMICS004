page 40037 "Dept Timetable "
{
    Caption = 'Dept Timetable ';
    PageType = Card;
    SourceTable = "Dept TimeTable List ";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Academic Year"; rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Session Year"; rec."Session Year")
                {
                    ApplicationArea = all;
                }
                field("Department "; rec."Department ")
                {
                    ApplicationArea = all;

                }
                field(Campus; rec.Campus)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status2)
                {
                    Caption = 'Status';
                    ApplicationArea = all;
                }
                field("HoI Comment"; rec."HoI Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }

            }
            group("Time Table Units")
            {
                part("time table list part"; "time table list part")
                {
                    SubPageLink = "Academic Year" = field("Academic Year"), Semester = field("Session Year"), Department = field("Department "), Campus = field(Campus);
                    UpdatePropagation = Both
                    ;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendForApproval)
            {
                Caption = 'Send for Approval';
                Image = Send;
                ApplicationArea = All;
                Enabled = (rec.Status2 = rec.Status2::Open);
                trigger OnAction()
                begin
                    rec.Status2 := rec.Status2::"Pending Approval";
                    // rec.Modify();
                    // CurrPage.Update(); // Refreshes subpage data
                    Message('Timetable sent for approval.');
                end;
            }

            action(ApproveTimetable)
            {
                Caption = 'Approve Timetable';
                Image = Approve;
                ApplicationArea = All;
                Enabled = (rec.Status2 = rec.Status2::"Pending Approval");
                trigger OnAction()
                begin
                    rec.Status2 := rec.Status2::Approved;
                    // rec.Modify();
                    // CurrPage.Update(); // Refreshes subpage data
                    Message('Timetable approved.');
                end;
            }

            action(RejectTimetable)
            {
                Caption = 'Reject Timetable';
                Image = Reject;
                ApplicationArea = All;
                Enabled = (rec.Status2 = rec.Status2::"Pending Approval");
                trigger OnAction()
                begin
                    rec.Status2 := rec.Status2::Rejected;
                    rec.Modify();
                    // CurrPage.Update(); // Refreshes subpage data
                    Message('Timetable rejected.');
                end;
            }
        }
    }
}
