page 65227 "Lecturer Load Approved"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65201;
    SourceTableView = WHERE(Approve = FILTER(true),
                            Claimed = FILTER(true),
                            Invoiced = FILTER(true));

    layout
    {
        area(content)
        {
            group("Filter")
            {
                Caption = 'Filters';
                field(DateFil; semesterfilter)
                {
                    Caption = 'Semester Filter';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETFILTER("Semester Code", '=%1', semesterfilter);
                        CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Group)
            {
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Courses Count"; Rec."Courses Count")
                {
                    ApplicationArea = All;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Claim Status"; Rec."Claim Status")
                {
                    ApplicationArea = All;
                }
                field("PV No."; Rec."PV No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PV Status"; Rec."PV Status")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Pending Marks"; Rec."Pending Marks")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(PrinAppointment)
                {
                    Caption = 'Print Appointment Letter';
                    Image = PrintAcknowledgement;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        counted: Integer;
                        LectLoadBatchLines: Record 65201;
                    begin
                        LectLoadBatchLines.RESET;
                        LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                        LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                        IF LectLoadBatchLines.FIND('-') THEN BEGIN
                            IF Rec.Approve THEN
                                REPORT.RUN(65201, TRUE, FALSE, LectLoadBatchLines);
                        END;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Approvalentries: Page "Approval Entries";
                        DocType: Option Quote,Load,Invoice,"Credit Memo","Blanket Load","Return Load","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    begin
                        // Approvalentries.Setfilters(DATABASE::"FIN-Payments Header", DocType::"Payment Voucher", Rec."PV No.");
                        Approvalentries.RUN;
                    end;
                }
                action(PrintClaim)
                {
                    Caption = 'Print Claim';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        LectLoadBatchLines: Record 65201;
                        //FINPaymentsHeader: Record "FIN-Payments Header";
                        PurchInvHeader: Record 122;
                    begin
                        LectLoadBatchLines.RESET;
                        LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                        LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                        IF LectLoadBatchLines.FIND('-') THEN BEGIN
                            PurchInvHeader.RESET;
                            PurchInvHeader.SETRANGE("No.", LectLoadBatchLines."Claim No.");
                            IF PurchInvHeader.FIND('-') THEN
                                REPORT.RUN(65211, TRUE, FALSE, PurchInvHeader)
                            ELSE
                                ERROR('The Claim is not yet generated');

                        END;
                    end;
                }
                // action(Print)
                // {
                //     Caption = 'Print PV';
                //     Image = ConfirmAndPrint;
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedIsBig = true;
                //     Visible = true;

                //     trigger OnAction()
                //     var
                //         LectLoadBatchLines: Record 65201;
                //         FINPaymentsHeader: Record "FIN-Payments Header";
                //     begin
                //         LectLoadBatchLines.RESET;
                //         LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                //         LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                //         IF LectLoadBatchLines.FIND('-') THEN BEGIN
                //             FINPaymentsHeader.RESET;
                //             FINPaymentsHeader.SETRANGE("No.", LectLoadBatchLines."PV No.");
                //             IF FINPaymentsHeader.FIND('-') THEN
                //                 REPORT.RUN(51054, TRUE, FALSE, FINPaymentsHeader)
                //             ELSE
                //                 ERROR('The PV is not yet generated');

                //         END;
                //     end;
                // }
                action(CourseLoad)
                {
                    Caption = 'Course Loading Summary';
                    Image = PrintAcknowledgement;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        counted: Integer;
                        LectLoadBatchLines: Record 65201;
                    begin
                        LectLoadBatchLines.RESET;
                        LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                        //LectLoadBatchLines.SETRANGE("Lecturer Code",Rec."Lecturer Code");
                        IF LectLoadBatchLines.FIND('-') THEN BEGIN
                            REPORT.RUN(69270, TRUE, FALSE, LectLoadBatchLines);
                        END;
                    end;
                }
                action(ClassList)
                {
                    Caption = 'Class List';
                    Image = List;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //  RunObject = Report 65208;
                }
                action(AttendanceList)
                {
                    Caption = 'Attendance List';
                    Image = ListPage;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ACALecturersUnits: Record 65202;
                    begin
                        ACALecturersUnits.RESET;
                        ACALecturersUnits.SETRANGE(Semester, Rec."Semester Code");
                        ACALecturersUnits.SETRANGE(Lecturer, Rec."Lecturer Code");
                        IF ACALecturersUnits.FIND('-') THEN BEGIN
                            REPORT.RUN(65207, TRUE, FALSE, ACALecturersUnits);
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Semester Code", '=%1', semesterfilter);
    end;

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        ACASemesters.RESET;
        ACASemesters.SETRANGE("Current Semester", TRUE);
        IF ACASemesters.FIND('-') THEN BEGIN
        END;
        IF ACASemesters.Code <> '' THEN
            semesterfilter := ACASemesters.Code;
    end;

    var
        ACASemesters: Record 61692;
        lineNo: Integer;
        semesterfilter: Code[20];

        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        InsertMode: Boolean;
        HideCreditCheckDialogue: Boolean;
        UpdateDocumentDate: Boolean;
        BilltoCustomerNoChanged: Boolean;


    local procedure Post(PostingCodeunitID: Integer; DocNo: Code[20])
    var
        SalesHeader: Record 36;
        SalesCrMemoHeader: Record 114;
        OfficeMgt: Codeunit 1630;
        InstructionMgt: Codeunit 1330;
        PreAssignedNo: Code[20];
    begin
        /*CheckSalesCheckAllLinesHaveQuantityAssigned(DocNo);
        PreAssignedNo := DocNo;
        PurchasesHeader.RESET;
        PurchasesHeader.SETRANGE(PurchasesHeader."No.",DocNo);
        IF PurchasesHeader.FIND('-') THEN BEGIN
        
        PurchasesHeader.SendToPosting(PostingCodeunitID);
        DocumentIsPosted := NOT PurchasesHeader.GET(PurchasesHeader."Document Type"::"Credit Memo",DocNo);
        {
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
        }
        IF PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" THEN
          EXIT;
          SalesCrMemoHeader.RESET;
          SalesCrMemoHeader.SETRANGE("Pre-Assigned No.",PreAssignedNo);
          IF SalesCrMemoHeader.FIND('-') THEN BEGIN
          "Credit Memo number":=SalesCrMemoHeader."No.";
          "Credit Memo by":=USERID;
          "Credit memo Created Date":=TODAY;
          "Credit Memo Time":=TIME;
          "Load No.":='';
          "PV No.":='';
          "Claim No.":='';
          MODIFY;
          END;
        
        IF OfficeMgt.IsAvailable THEN BEGIN
         SalesCrMemoHeader.RESET;
          SalesCrMemoHeader.SETRANGE("Pre-Assigned No.",PreAssignedNo);
          IF SalesCrMemoHeader.FINDFIRST THEN
            PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader);
        END ELSE
          IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            ShowPostedConfirmationMessage(PreAssignedNo);
          END;
          */

    end;

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchasesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        //CurrPage.PurchasesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit 1400;
        DocType: Option Quote,Load,Invoice,"Credit Memo","Blanket Load","Return Load",Reminder,FinChMemo;
    begin
        //DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::"Credit Memo","No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record 311;
    begin
        // SalesReceivablesSetup.GET;
        // ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;


    procedure ShowPreview(DocNo: Code[20])
    var
        SalesPostYesNo: Codeunit 81;
    begin
        /*PurchasesHeader.RESET;
        PurchasesHeader.SETRANGE("No.",DocNo);
        IF PurchasesHeader.FIND('-') THEN
          SalesPostYesNo.Preview(PurchasesHeader);
          */

    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        /*JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := "Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;
        
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        CustomerSelected := "Sell-to Customer No." <> '';
        */

    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned(DocNo: Code[20])
    var
        ApplicationAreaSetup: Record 9178;
    begin
        /*IF ApplicationAreaSetup.IsFoundationEnabled THEN BEGIN
          PurchasesHeader.RESET;
        PurchasesHeader.SETRANGE("No.",DocNo);
        IF PurchasesHeader.FIND('-') THEN BEGIN
          LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(PurchasesHeader);
          END;
          END;*/

    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        SalesCrMemoHeader: Record 114;
        InstructionMgt: Codeunit 1330;
    begin
        /*SalesCrMemoHeader.SETRANGE("Pre-Assigned No.",PreAssignedNo);
        IF SalesCrMemoHeader.FINDFIRST THEN
          IF InstructionMgt.ShowConfirm(OpenPostedSalesCrMemoQst,InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader);
          */

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record 36; var Handled: Boolean)
    begin
    end;
}

