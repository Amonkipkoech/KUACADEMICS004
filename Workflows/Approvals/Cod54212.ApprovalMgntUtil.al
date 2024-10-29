codeunit 86008 "Approval Mgnt. Util."
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
        NoWorkflowEnableErr: TextConst ENU = 'No approval worklow for this record type is enabled.';
        NothingToApproveErr: TextConst ENU = 'Lines Must Contain Record(s)';
        /*Repair Request */

        //studClearance
        studentClearance: Record "Student Clerance";
    /* ****************************************************************************************************************************************** */
    // StudentClearance
    [IntegrationEvent(false, false)]

    procedure OnSendstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;

    procedure CheckstudentClearanceWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean
    begin
        IF NOT IsstudentClearanceApplicationApprovalsWorkflowEnable(studentClearance) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsstudentClearanceApplicationApprovalsWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean

    begin
        IF studentClearance."Status" <> studentClearance."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(studentClearance, WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode()));
    end;

    //Meeting   Booking




}
