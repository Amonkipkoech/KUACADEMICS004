codeunit 86006 "Workflow Event Handling Ext."
{

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        /*Repair Request */
        RepairRequestSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Repair Request is Requested';
        RepairRequestRequestCancelEventDescTxt: TextConst ENU = 'Approval of Repair Request is Canceled';
        /* Maintence Schedule */
        MaintenceScheduleSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Maintence Schedule is Requested';
        MaintenceScheduleRequestCancelEventDescTxt: TextConst ENU = 'Approval of Maintence Schedule is Canceled';
        /* Maintenance Request */
        MaintenanceRequestSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Maintenance Request is Requested';
        MaintenanceRequestRequestCancelEventDescTxt: TextConst ENU = 'Approval of Maintenance Request is Canceled';
        /* Utility Bill */
        UtilityBillSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Utility Bill is Requested';
        UtilityBillRequestCancelEventDescTxt: TextConst ENU = 'Approval of Utility Bill is Canceled';
        //meeting Booking
        meetingBookingSendForApprovalEventDescTxt: TextConst ENU = 'Approval of Meeting Booking is Requested';
        meetingBookingRequestCancelEventDescTxt: TextConst ENU = 'Approval of Meeting Booking is Canceled';
        //studentClearance
        studentClearanceForApprovalEventDescTxt: TextConst ENU = 'Approval of Student Clearance is Requested';
        studentclearanceRequestCancelEventDescTxt: TextConst ENU = 'Approval of Student Clearance is Canceled';
        //XYstudentClearance
        XyClearanceForApprovalEventDescTxt: TextConst ENU = 'Approval of Xy Clearance is Requested';
        XyclearanceRequestCancelEventDescTxt: TextConst ENU = 'Approval of Xy Clearance is Canceled';



    /* *************************************************************************************************************************************/
    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin


        //StudentClearance
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStudentClearanceForApprovalCode, Database::"Student Clerance", studentClearanceForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStudentClearanceCode, Database::"Student Clerance", studentclearanceRequestCancelEventDescTxt, 0, false);

        //XyClearance
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendXyForApprovalCode, Database::"ACA-XY-FORM", XyClearanceForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelXyClearanceCode, Database::"ACA-XY-FORM", XyclearanceRequestCancelEventDescTxt, 0, false);


    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin




        //studentClearance
        case EventFunctionName of
            RunWorkflowOnCancelStudentClearanceCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelStudentClearanceCode, RunWorkflowOnSendStudentClearanceForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStudentClearanceForApprovalCode);
        end;
        //xyclearance
        case EventFunctionName of
            RunWorkflowOnCancelXyClearanceCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelxyClearanceCode, RunWorkflowOnSendXyForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendXyForApprovalCode);
        end;

    end;

    /*************************************************************************************************************************** */
    //meetingBooking





    //Student clearance 
    procedure RunWorkflowOnSendStudentClearanceForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStudentClearanceForApproval'));
    end;

    procedure RunWorkflowOnSendXyForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendXyForApprovalCode'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendStudentClearanceForApproval', '', true, true)]
    local procedure RunWorkflowOnSendStudentClearanceForApproval(Var StudentClearance: Record "Student Clerance")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStudentClearanceForApprovalCode, StudentClearance)
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnSendXyClearanceForApproval', '', true, true)]
    local procedure RunWorkflowOnSendXyClearanceForApproval(var XyRequest: Record "ACA-XY-FORM")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendStudentClearanceForApprovalCode, XyRequest)
    end;


    procedure RunWorkflowOnCancelStudentClearanceCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStudentClearance'));
    end;

    procedure RunWorkflowOnCancelXyClearanceCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelXyClearance'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelStudentClearanceForApproval', '', true, true)]
    local procedure RunWorkflowOnCancelStudentClearance(Var StudentClearance: Record "Student Clerance")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUtilityBillCode, StudentClearance);
        StudentClearance.Reset();
        StudentClearance.SetRange("Clearance No", StudentClearance."Clearance No");
        if StudentClearance.FindFirst() then begin
            StudentClearance.Status := StudentClearance.Status::Open;
            StudentClearance.Modify()
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgnt. Util.", 'OnCancelStudentClearanceForApproval', '', true, true)]
    // local procedure RunWorkflowOnCancelXyClearance(var XyRequest: Record "ACA-XY-FORM")//
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelUtilityBillCode, StudentClearance);
    //     StudentClearance.Reset();
    //     StudentClearance.SetRange("Clearance No", StudentClearance."Clearance No");
    //     if StudentClearance.FindFirst() then begin
    //         StudentClearance.Status := StudentClearance.Status::Open;
    //         StudentClearance.Modify()
    //     end;
    // end;


    /* Utility Bill */
    procedure RunWorkflowOnSendUtilityBillForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendUtilityBillForApproval'));
    end;




    procedure RunWorkflowOnCancelUtilityBillCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelUtilityBill'));
    end;



    /* Maintenance Request */
    procedure RunWorkflowOnSendMaintenanceRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMaintenanceRequestForApproval'));
    end;



    procedure RunWorkflowOnSendBContrForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendBContrForApproval'));
    end;

    procedure RunWorkflowOnCancelBContrApprovalRequestCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelBContrApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseBContrCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseBContr'));
    end;
}
