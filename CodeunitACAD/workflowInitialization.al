codeunit 51815 "Workflow Initialization"
{

    //"CAT-Meal Booking Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendMealBookingforApproval(VAR MealBooking: Record "CAT-Meal Booking Header");
    begin
    end;

    procedure IsMealBookingEnabled(var MealBooking: Record "CAT-Meal Booking Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Workflow Processing";
    begin
        exit(WFMngt.CanExecuteWorkflow(MealBooking, WFCode.RunWorkflowOnSendMealBookingApprovalCode()))
    end;

    local procedure CheckMealBookingWorkflowEnabled(): Boolean
    var
        MealBooking: Record "CAT-Meal Booking Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsMealBookingEnabled(MealBooking) then
            Error(NoWorkflowEnb);
    end;
    //Cancel "CAT-Meal Booking Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelMealBookingforApproval(VAR MealBooking: Record "CAT-Meal Booking Header");
    begin
    end;
    //End Cancel "CAT-Meal Booking Header"
    //"CAT-Meal Booking Header"

    //"Parttime Claim Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendParttimeClaimforApproval(VAR ParttimeClaim: Record "Parttime Claim Header");
    begin
    end;

    procedure IsParttimeClaimEnabled(var ParttimeClaim: Record "Parttime Claim Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Workflow Processing";
    begin
        exit(WFMngt.CanExecuteWorkflow(ParttimeClaim, WFCode.RunWorkflowOnSendParttimeClaimApprovalCode()))
    end;



    local procedure CheckParttimeClaimWorkflowEnabled(): Boolean
    var
        ParttimeClaim: Record "Parttime Claim Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsParttimeClaimEnabled(ParttimeClaim) then
            Error(NoWorkflowEnb);
    end;
    //Cancel "Parttime Claim Header"
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelParttimeClaimforApproval(VAR ParttimeClaim: Record "Parttime Claim Header");
    begin
    end;
    //End Cancel "Parttime Claim Header"
    //"Parttime Claim Header"
    //Graduation
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendGraduationCardforApproval(VAR graduation: Record "Graduation Clearance");
    begin
    end;

    procedure IsGraduationCardEnabled(VAR graduation: Record "Graduation Clearance"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "Workflow Processing";
    begin
        exit(WFMngt.CanExecuteWorkflow(graduation, WFCode.RunWorkflowOnSendGradClearance()))
    end;



    local procedure CheckGraduationCardWorkflowEnabled(): Boolean
    var
        graduation: Record "Graduation Clearance";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';

    begin
        if not IsGraduationCardEnabled(graduation) then
            Error(NoWorkflowEnb);
    end;
    //Cancel Graduation card
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelGraduationCardforApproval(var graduation: Record "Graduation Clearance");
    begin
    end;
    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry";
    WorkflowStepInstance: Record "Workflow Step Instance")
    var

        MealBooking: Record "CAT-Meal Booking Header";
        ParttimeClaim: Record "Parttime Claim Header";
        Graduation: Record "Graduation Clearance";
    begin
        case
            RecRef.Number of
            Database::"CAT-Meal Booking Header":
                begin
                    RecRef.SetTable(MealBooking);
                    ApprovalEntryArgument."Document No." := MealBooking."Booking Id";
                end;

            Database::"Parttime Claim Header":
                begin
                    RecRef.SetTable(ParttimeClaim);
                    ApprovalEntryArgument."Document No." := ParttimeClaim."No.";
                end;
            Database::"Graduation Clearance":
                begin
                    RecRef.SetTable(Graduation);
                    ApprovalEntryArgument."Document No." := Graduation."No.";
                end;
        end;
    end;
    //End Int Code Workflow
}