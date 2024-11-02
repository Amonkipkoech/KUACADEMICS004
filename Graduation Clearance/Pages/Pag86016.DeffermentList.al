page 86016 "Deffered Students"

{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = defferedStudents;
    CardPageId = "Deffered Students Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Request No"; "Request No")
                {
                    ApplicationArea = all;
                }
                field(studentNo; Rec.studentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNo field.';
                }
                field(studentName; Rec.studentName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentName field.';
                }
                field(programme; Rec.programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the programme field.';
                }
                field(stage; Rec.stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the stage field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Accept the Application?', true) = false then exit;
                    Rec.status := Rec.status::Approved;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to Reject the Application?', true) = false then exit;
                    Rec.status := Rec.status::Cancelled;
                    Rec.Modify();
                end;
            }
            action(Readmission)
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::Approved;

                trigger OnAction();
                begin
                    if Rec.Get() then
                        if Confirm('Do you want to readmit the Student?', true) = false then exit;
                    Rec.status := Rec.status::Cancelled;
                    Rec.Modify();
                end;
            }
        }
    }
}
