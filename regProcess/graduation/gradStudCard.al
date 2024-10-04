page 86626 "Graduation Clearance Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Graduation Clearance";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field(studNo; Rec.studNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studNo field.';
                }
                field(studentNames; Rec.studentNames)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNames field.';
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.';
                }
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the semester field.';
                }
                field(academicYear; Rec.academicYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the academicYear field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Request Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    if Approvalmgt.IsGraduationCardEnabled(Rec) = true then begin
                        Approvalmgt.OnSendGraduationCardforApproval(Rec);
                    end
                    ELSE
                        error('Check workflow');
                end;
            }
            // action("Approvals")
            // {
            //     ApplicationArea = All;
            //     Image = Approvals;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Fin-Approval Entries";
            //     RunPageLink = "Document No." = field("No.");
            // }
            action("Cancel Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    if Approvalmgt.IsGraduationCardEnabled(Rec) = true
                     then begin

                        Approvalmgt.OnSendGraduationCardforApproval(Rec);
                    end ELSE
                        error('Check Your workflow');
                end;
            }
        }
    }


    var
        Approvalmgt: Codeunit "Workflow Initialization";
}