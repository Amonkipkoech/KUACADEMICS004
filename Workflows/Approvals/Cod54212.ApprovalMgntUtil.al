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
        XyRequest : Record "ACA-XY-FORM";
    /* ****************************************************************************************************************************************** */
    // StudentClearance
    [IntegrationEvent(false, false)]

    procedure OnSendstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;
    //xy request
    [IntegrationEvent(false, false)]
    procedure OnSendXyClearanceForApproval(var  XyRequest: Record "ACA-XY-FORM")
    begin

    end;

    [IntegrationEvent(false, false)]
   // CANCEL student request Clearance
    procedure OnCancelstudentClearanceForApproval(var studentClearance: Record "Student Clerance")
    begin

    end;
     // CANCEL XY request Clearance
     [IntegrationEvent(false, false)]
    procedure OnCancelXyForApproval(var  XyRequest: Record "ACA-XY-FORM")
    begin

    end;

    procedure CheckstudentClearanceWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean
    begin
        IF NOT IsstudentClearanceApplicationApprovalsWorkflowEnable(studentClearance) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;
    procedure CheckXyWorkflowEnable(var XyRequest: Record "ACA-XY-FORM"): Boolean
    begin
        IF NOT IsXyApplicationApprovalsWorkflowEnable(XyRequest) then
            Error(NoWorkflowEnableErr);
        exit(true)
    end;

    procedure IsstudentClearanceApplicationApprovalsWorkflowEnable(var studentClearance: Record "Student Clerance"): Boolean

    begin
        IF studentClearance."Status" <> studentClearance."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(studentClearance, WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode()));
    end;

    procedure IsXyApplicationApprovalsWorkflowEnable(var XyRequest: Record  "ACA-XY-FORM"): Boolean

    begin
        IF XyRequest."Status" <> XyRequest."Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(XyRequest, WorkflowEventHandling.RunWorkflowOnSendXyForApprovalCode()));
    end;

    //Meeting   Booking




}
