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
                Enabled = (Rec.Status2 = Rec.Status2::Open);

                trigger OnAction()
                var
                    DeplistPart: Record Timetable;
                begin
                    // Update header status
                    Rec.Status2 := Rec.Status2::"Pending Approval";
                    Rec.Modify(); // Save the change

                    // Update related timetable lines
                    DeplistPart.Reset();
                    DeplistPart.SetRange(Campus, Rec.Campus);
                    DeplistPart.SetRange("Academic Year", Rec."Academic Year");
                    DeplistPart.SetRange(Semester, Rec."Session Year");
                    DeplistPart.SetRange(Department, Rec."Department ");
                    if DeplistPart.FindSet() then begin
                        repeat
                            DeplistPart.Status := DeplistPart.Status::"Pending Approval";
                            DeplistPart.Modify();
                        until DeplistPart.Next() = 0;
                    end;

                    CurrPage.Update(); // Refresh UI
                    Message('Timetable sent for approval.');
                end;
            }


            action(ApproveTimetable)
            {
                Caption = 'Approve Timetable';
                Image = Approve;
                ApplicationArea = All;
                Enabled = (Rec.Status2 = Rec.Status2::"Pending Approval");

                trigger OnAction()
                var
                    DeplistPart: Record Timetable;
                begin
                    // Update header status
                    Rec.Status2 := Rec.Status2::Approved;
                    Rec.Modify(); // Save the change

                    // Update related timetable lines
                    DeplistPart.Reset();
                    DeplistPart.SetRange(Campus, Rec.Campus);
                    DeplistPart.SetRange("Academic Year", Rec."Academic Year");
                    DeplistPart.SetRange(Semester, Rec."Session Year");
                    DeplistPart.SetRange(Department, Rec."Department ");
                    if DeplistPart.FindSet() then begin
                        repeat
                            DeplistPart.Status := DeplistPart.Status::Approved;
                            DeplistPart.Modify();
                        until DeplistPart.Next() = 0;
                    end;

                    CurrPage.Update(); // Refresh UI
                    Message('Timetable approved and released to students and lecturers for viewing');
                end;
            }


            action(RejectTimetable)
            {
                Caption = 'Reject Timetable';
                Image = Reject;
                ApplicationArea = All;
                Enabled = (Rec.Status2 = Rec.Status2::"Pending Approval");

                trigger OnAction()
                var
                    DeplistPart: Record Timetable;
                begin
                    // Update header status
                    Rec.Status2 := Rec.Status2::Rejected;
                    Rec.Modify(); // Save the change

                    // Update related timetable lines
                    DeplistPart.Reset();
                    DeplistPart.SetRange(Campus, Rec.Campus);
                    DeplistPart.SetRange("Academic Year", Rec."Academic Year");
                    DeplistPart.SetRange(Semester, Rec."Session Year");
                    DeplistPart.SetRange(Department, Rec."Department ");
                    if DeplistPart.FindSet() then begin
                        repeat
                            DeplistPart.Status := DeplistPart.Status::Rejected;
                            DeplistPart.Modify();
                        until DeplistPart.Next() = 0;
                    end;

                    CurrPage.Update(); // Refresh UI
                    Message('Timetable rejected and sent back for revision.');
                end;
            }

        }
    }
}
