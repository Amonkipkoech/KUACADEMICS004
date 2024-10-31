codeunit 86007 "Workflow Setup Ext."
{
    var
        WorkflowSetup: CodeUnit "Workflow Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext.";
        /*Repair Request */

        RepairRequestWorkflowCategoryTxt: TextConst ENU = 'Repair Request';
        RepairRequestWorkflowCategoryDescTxt: TextConst ENU = 'Repair Request Document';
        RepairRequestWorkflowCodeTxt: TextConst ENU = 'SAAW';
        RepairRequestWorkfowDescTxt: TextConst ENU = 'Repair Request Approval Workflow';
        RepairRequestTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=RepairRequest>%1</DataItem></DataItems></ReportParameters>';
        /* Maintence Schedule */


        MaintenceScheduleWorkflowCategoryTxt: TextConst ENU = 'Maintence Schedule';
        MaintenceScheduleWorkflowCategoryDescTxt: TextConst ENU = 'Maintence Schedule Document';
        MaintenceScheduleWorkflowCodeTxt: TextConst ENU = 'MCAW';
        MaintenceScheduleWorkfowDescTxt: TextConst ENU = 'Maintence Schedule Approval Workflow';
        MaintenceScheduleTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=MaintenceSchedule>%1</DataItem></DataItems></ReportParameters>';
        /* Maintenance Request */

        MaintenanceRequestWorkflowCategoryTxt: TextConst ENU = 'Maintenance Request';
        MaintenanceRequestWorkflowCategoryDescTxt: TextConst ENU = 'Maintenance Request Document';
        MaintenanceRequestWorkflowCodeTxt: TextConst ENU = 'MRAW';
        MaintenanceRequestWorkfowDescTxt: TextConst ENU = 'Maintenance Request Approval Workflow';
        MaintenanceRequestTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=MaintenanceRequest>%1</DataItem></DataItems></ReportParameters>';
        /* Utility Bill */

        UtilityBillWorkflowCategoryTxt: TextConst ENU = 'Utility Bill';
        UtilityBillWorkflowCategoryDescTxt: TextConst ENU = 'Utility Bill Document';
        UtilityBillWorkflowCodeTxt: TextConst ENU = 'UBAW';
        UtilityBillWorkfowDescTxt: TextConst ENU = 'Utility Bill Approval Workflow';
        UtilityBillTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=UtilityBill>%1</DataItem></DataItems></ReportParameters>';
        //meetingbooking
        meetingInfo: Record "Student Clerance";
        MeetingBookingInfoWorkflowCategoryTxt: TextConst ENU = 'Meeting APR';
        MeetingBookingWorkflowCategoryDescTxt: TextConst ENU = 'Meeting Request Document';
        MeetingBookingWorkflowCodeTxt: TextConst ENU = 'MBAW';
        MeetingWorkfowDescTxt: TextConst ENU = 'Meeting Request Approval Workflow';
        meetingBookingTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=UtilityBill>%1</DataItem></DataItems></ReportParameters>';
        //Student Clesrance
        studentClearance: Record "Student Clerance";
        StudentClearanceInfoWorkflowCategoryTxt: TextConst ENU = 'STUD CLR';
        StudentClearanceWorkflowCategoryDescTxt: TextConst ENU = 'Student Clearance Request';
        StudentClearanceWorkflowCodeTxt: TextConst ENU = 'STDCLR';
        StudentClearanceWorkfowDescTxt: TextConst ENU = 'Student Clearance Request Approval Workflow';
        StudentClearanceTypeCondTxt: TextConst ENU = '<?xml version = "1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=StudentClearance>%1</DataItem></DataItems></ReportParameters>';




    /* ************************************************************************************************************************************8 */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]

    local procedure OnAddWorkflowCategoriesToLibrary()

    begin
        /*Repair Request */
        WorkflowSetup.InsertWorkflowCategory(RepairRequestWorkflowCategoryTxt, RepairRequestWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(MaintenceScheduleWorkflowCategoryTxt, MaintenceScheduleWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(MaintenanceRequestWorkflowCategoryTxt, MaintenanceRequestWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(UtilityBillWorkflowCategoryTxt, UtilityBillWorkflowCategoryDescTxt);
        WorkflowSetup.InsertWorkflowCategory(StudentClearanceInfoWorkflowCategoryTxt, StudentClearanceWorkflowCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]

    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin


        WorkflowSetup.InsertTableRelation(Database::"Student Clerance", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]

    local procedure OnInsertWorkflowTemplates()
    begin


        InsertMeetingBookingWorkflowTemplate();
        InsertStudentClearanceWorkflowTemplate();
    end;

    /* ************************************************************************************************************************************8 */
    //MEETING BOOKING
    local procedure InsertMeetingBookingWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, MeetingBookingWorkflowCodeTxt, MeetingWorkfowDescTxt, MeetingBookingInfoWorkflowCategoryTxt);


        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;




    local procedure BuildMeetingBookingTypeConditions(Status: Integer): Text
    begin
        meetingInfo.Reset;
        meetingInfo.SetRange(Status, Status);
        exit(StrSubstNo(meetingBookingTypeCondTxt, WorkflowSetup.Encode(meetingInfo.GetView(false))))
    end;
    //Student Clearance
    local procedure InsertStudentClearanceWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, StudentClearanceWorkflowCodeTxt, studentClearanceWorkfowDescTxt, StudentClearanceInfoWorkflowCategoryTxt);


        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertStudentClearanceWorkflowDetails(var Workflow: Record Workflow)
    begin
        WorkflowSetup.initWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildStudentClearanceTypeConditions(studentClearance.Status::Open),
            WorkflowEventHandling.RunWorkflowOnSendStudentClearanceForApprovalCode,
            BuildMeetingBookingTypeConditions(studentClearance.Status::Pending),
            WorkflowEventHandling.RunWorkflowOnCancelStudentClearanceCode,
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildStudentClearanceTypeConditions(Status: Integer): Text
    begin
        studentClearance.Reset;
        studentClearance.SetRange(Status, Status);
        exit(StrSubstNo(StudentClearanceTypeCondTxt, WorkflowSetup.Encode(studentClearance.GetView(false))))
    end;

    /* Utility Bill */









    /* Maintenance Request */





    /* Maintence Schedule */








    /*Repair Request */








}
