page 40045 "Exam Dept Card "
{
    Caption = 'Exam Dept Card ';
    PageType = Card;
    SourceTable = "Exam Dept Timetable";

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
                part("Exam Time table list part"; "Exam ListPart")
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
                    ExamLine: Record "Examination Timetable";
                begin
                    Rec.Status2 := Rec.Status2::"Pending Approval";
                    Rec.Modify();

                    ExamLine.Reset();
                    ExamLine.SetRange(Campus, Rec.Campus);
                    ExamLine.SetRange("Academic Year", Rec."Academic Year");
                    ExamLine.SetRange(Semester, Rec."Session Year");
                    ExamLine.SetRange(Department, Rec."Department ");
                    if ExamLine.FindSet() then
                        repeat
                            ExamLine.Status := ExamLine.Status::"Pending Approval";
                            ExamLine.Modify();
                        until ExamLine.Next() = 0;

                    CurrPage.Update();
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
                    ExamLine: Record "Examination Timetable";
                begin
                    Rec.Status2 := Rec.Status2::Approved;
                    Rec.Modify();

                    ExamLine.Reset();
                    ExamLine.SetRange(Campus, Rec.Campus);
                    ExamLine.SetRange("Academic Year", Rec."Academic Year");
                    ExamLine.SetRange(Semester, Rec."Session Year");
                    ExamLine.SetRange(Department, Rec."Department ");
                    if ExamLine.FindSet() then
                        repeat
                            ExamLine.Status := ExamLine.Status::Approved;
                            ExamLine.Modify();
                        until ExamLine.Next() = 0;

                    CurrPage.Update();
                    Message('Timetable approved and released to students and Lectures for viewing ');
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
                    ExamLine: Record "Examination Timetable";
                begin
                    Rec.Status2 := Rec.Status2::Rejected;
                    Rec.Modify();

                    ExamLine.Reset();
                    ExamLine.SetRange(Campus, Rec.Campus);
                    ExamLine.SetRange("Academic Year", Rec."Academic Year");
                    ExamLine.SetRange(Semester, Rec."Session Year");
                    ExamLine.SetRange(Department, Rec."Department ");
                    if ExamLine.FindSet() then
                        repeat
                            ExamLine.Status := ExamLine.Status::Rejected;
                            ExamLine.Modify();
                        until ExamLine.Next() = 0;

                    CurrPage.Update();
                    Message('Timetable rejected.');
                end;
            }

        }
    }
}

