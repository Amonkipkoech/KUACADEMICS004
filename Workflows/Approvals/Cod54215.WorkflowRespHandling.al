codeunit 86005 "Workflow Resp. Handling"
{
    var


        StudentClearance: Record "Student Clerance";
        MasterRotationPlan: Record "Master Rotation Plan2";


    /*******************************************************************************************************************************************************/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        case RecRef.Number of
            /*Repair Request */


            //studentClearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Open;
                    StudentClearance.Modify;
                    Handled := true;
                end;
            /*Master Rotation Plan2 */
            Database::"Master Rotation Plan2":
                begin
                    RecRef.SetTable(MasterRotationPlan);
                    MasterRotationPlan.Status := MasterRotationPlan.Status::Open;
                    MasterRotationPlan.Modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]

    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    begin
        case RecRef.Number of
            /*Repair Request */


            //StudentClearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Approved;
                    StudentClearance.Modify;
                    Handled := true;
                end;

            /*Master Rotation Plan2 */
            Database::"Master Rotation Plan2":
                begin
                    RecRef.setTable(MasterRotationPlan);
                    MasterRotationPlan.Status := MasterRotationPlan.Status::Approved;
                    MasterRotationPlan.Modify();
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', true, true)]

    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean)
    begin
        case RecRef.Number of


            //Student Clearance
            Database::"Student Clerance":
                begin
                    RecRef.SetTable(StudentClearance);
                    StudentClearance.Status := StudentClearance.Status::Pending;
                    StudentClearance.Modify;
                    IsHandled := true;
                end;
            /*Master Rotation Plan2 */
            Database::"Master Rotation Plan2":
                begin
                    RecRef.setTable(MasterRotationPlan);
                    MasterRotationPlan.Status := MasterRotationPlan.Status::"Pending Approval";
                    MasterRotationPlan.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]

    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])

    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
    begin


        //StudentClearance
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelStudentClearanceCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelStudentClearanceCode);
        END;
        /*Master Rotation Plan2 */
        CASE ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMasterRotationPlanForApprovalCode);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEventHandling.RunWorkflowOnSendMasterRotationPlanForApprovalCode);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEventHandling.RunWorkflowOnCancelMasterRotationPlanCode);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelMasterRotationPlanCode);
        END;
    end;
}
