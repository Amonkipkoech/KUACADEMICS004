page 65226 "Lecturer Load Pending Dept. Ap"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65201;

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
                // action(Approve)
                // {
                //     Caption = 'Approve Claim';
                //     Image = PostPrint;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     ShortCutKey = 'F2';

                //     trigger OnAction()
                //     var
                //         counted: Integer;
                //         PurchaseHeader: Record 38;
                //         PurchaseLine: Record 39;
                //         ApprovalMgt: Codeunit 439;
                //         showmessage: Boolean;
                //         ManualCancel: Boolean;
                //         State: Option Open,"Pending Approval",Cancelled,Approved;
                //         DocType: Option Quote,Load,Invoice,"Credit Memo","Blanket Load","Return Load","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                //         tableNo: Integer;
                //     begin
                //         LectLoadPermissions.RESET;
                //         LectLoadPermissions.SETRANGE("User Id", USERID);
                //         IF LectLoadPermissions.FIND('-') THEN BEGIN
                //             LectLoadPermissions.TESTFIELD("Can Approve Claim");
                //             LectLoadPermissions.TESTFIELD("Claims Department", Rec."Department Code");
                //             LectLoadPermissions.TESTFIELD("Claim Campus", Rec.Campus);
                //         END ELSE
                //             ERROR('Access Denied!');

                //         //IF Rec."Claim No."='' THEN ERROR('No Clain to Approve!');
                //         LectLoadCentralSetup.RESET;
                //         IF LectLoadCentralSetup.FIND('-') THEN BEGIN
                //             LectLoadCentralSetup.TESTFIELD("Part-Time Expenses Account");
                //             LectLoadCentralSetup.TESTFIELD("Payment Type");
                //         END;

                //         CALCFIELDS("Exists Part-Time", "Pending Marks");
                //         IF NOT "Exists Part-Time" THEN ERROR("Lecturer Name" + ' has no part-time units');
                //         //IF NOT Approve THEN ERROR('Not Approved');
                //         //IF "Pending Marks" THEN ERROR('Some Marks are not submitted by the Lecturer');

                //         IF CONFIRM('Approve Claim?', TRUE) = FALSE THEN ERROR('You cancelled the process');

                //         FINCashOfficeSetup.RESET;
                //         IF FINCashOfficeSetup.FIND('-') THEN BEGIN
                //             FINCashOfficeSetup.TESTFIELD(FINCashOfficeSetup."Normal Payments No");
                //             FINCashOfficeSetup.TESTFIELD(FINCashOfficeSetup."PV  Batch");
                //             FINCashOfficeSetup.TESTFIELD(FINCashOfficeSetup."PV Template");

                //         END;
                //         CLEAR(NextOderNo);
                //         NextOderNo := NoSeriesMgt.GetNextNo(FINCashOfficeSetup."Normal Payments No", TODAY, TRUE);
                //         FINPaymentsHeader.INIT;
                //         FINPaymentsHeader."No." := NextOderNo;
                //         FINPaymentsHeader.Date := TODAY;
                //         FINPaymentsHeader.Payee := Rec."Lecturer Name";
                //         FINPaymentsHeader."On Behalf Of" := Rec.Campus;
                //         FINPaymentsHeader.Cashier := USERID;
                //         FINPaymentsHeader."Global Dimension 1 Code" := Rec.Campus;
                //         FINPaymentsHeader."Shortcut Dimension 2 Code" := Rec."Department Code";
                //         FINPaymentsHeader."Vendor No." := Rec."Lecturer Code";
                //         FINPaymentsHeader."Responsibility Center" := 'KARU';
                //         FINPaymentsHeader.INSERT;

                //         VendorLedgerEntry.RESET;
                //         VendorLedgerEntry.SETRANGE("Vendor No.", Rec."Lecturer Code");
                //         VendorLedgerEntry.SETRANGE("Document No.", "Claim No.");
                //         IF VendorLedgerEntry.FIND('-') THEN BEGIN
                //             VendorLedgerEntry."Applies-to ID" := "Claim No.";
                //         END;
                //         FINPaymentLine.INIT;
                //         FINPaymentLine."Line No." := 1000;
                //         FINPaymentLine.No := NextOderNo;
                //         FINPaymentLine.Type := LectLoadCentralSetup."Payment Type";
                //         FINPaymentLine."Applies-to Doc. No." := Rec."Claim No.";
                //         FINPaymentLine.VALIDATE(FINPaymentLine."Applies-to Doc. No.");
                //         FINPaymentLine."Applies-to Doc. Type" := FINPaymentLine."Applies-to Doc. Type"::Invoice;
                //         FINPaymentLine."Applies-to ID" := Rec."Claim No.";
                //         FINPaymentLine.VALIDATE(Type);
                //         FINPaymentLine."Account No." := Rec."Lecturer Code";
                //         FINPaymentLine.VALIDATE("Account No.");
                //         FINPaymentLine.Date := TODAY;
                //         FINPaymentLine."Received From" := Rec."Lecturer Name";
                //         FINPaymentLine."On Behalf Of" := Rec.Campus;
                //         FINPaymentLine.Cashier := USERID;
                //         Rec.CALCFIELDS(Amount);
                //         FINPaymentLine.Amount := Rec.Amount;
                //         FINPaymentLine.VALIDATE(Amount);
                //         FINPaymentLine."Global Dimension 1 Code" := Rec.Campus;
                //         FINPaymentLine.Payee := Rec."Lecturer Name";
                //         FINPaymentLine."Shortcut Dimension 2 Code" := Rec."Department Code";
                //         FINPaymentLine."Journal Template" := FINCashOfficeSetup."PV Template";
                //         FINPaymentLine."Journal Batch" := FINCashOfficeSetup."PV  Batch";
                //         FINPaymentLine.INSERT;



                //         // Get and populate The PV Number Here...
                //         FINPaymentsHeader.RESET;
                //         FINPaymentsHeader.SETRANGE(FINPaymentsHeader."No.", NextOderNo);
                //         IF FINPaymentsHeader.FIND('-') THEN BEGIN
                //             Rec."PV No." := NextOderNo;
                //             Rec.Invoiced := TRUE;
                //             Rec.MODIFY;
                //             // Send PV for Approval
                //             //Release the PV for Approval
                //             State := State::Open;
                //             /* IF FINPaymentsHeader.Status<>FINPaymentsHeader.Status::Pending THEN State:=State::"Pending Approval";
                //              DocType:=DocType::"Payment Voucher";
                //              CLEAR(tableNo);
                //              tableNo:=DATABASE::"FIN-Payments Header";
                //              FINPaymentsHeader.CALCFIELDS(FINPaymentsHeader."Total Payment Amount");
                //              IF ApprovalMgt.SendApproval(tableNo,Rec."PV No.",DocType,State,'',FINPaymentsHeader."Total Payment Amount") THEN;*/
                //         END;

                //         //Set The Claim Status as Posted and released then post
                //         PurchasesHeader.RESET;
                //         PurchasesHeader.SETRANGE(PurchasesHeader."Document Type", PurchasesHeader."Document Type"::Invoice);
                //         PurchasesHeader.SETRANGE(PurchasesHeader."No.", Rec."Claim No.");
                //         IF PurchasesHeader.FIND('-') THEN BEGIN
                //             PurchasesHeader.Status := PurchasesHeader.Status::Released;
                //             PurchasesHeader.MODIFY;
                //             // Post the Load Here...
                //             //CODEUNIT.RUN(91,PurchasesHeader);
                //         END;

                //         MESSAGE('The Claim has been approved and PV generated successfuly');

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
                /* action(PrintClaim)
                {
                    Caption = 'Print Claim';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        LectLoadBatchLines: Record 65201;
                        FINPaymentsHeader: Record "61688";
                        PurchInvHeader: Record 38;
                    begin
                        LectLoadBatchLines.RESET;
                        LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                        LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                        IF LectLoadBatchLines.FIND('-') THEN BEGIN
                            PurchInvHeader.RESET;
                            PurchInvHeader.SETRANGE("No.", LectLoadBatchLines."Claim No.");
                            IF PurchInvHeader.FIND('-') THEN
                                REPORT.RUN(51480, TRUE, FALSE, PurchInvHeader)
                            ELSE
                                ERROR('The Claim is not yet generated');

                        END;
                    end;
                } */
                action(ClassList)
                {
                    Caption = 'Class List';
                    Image = List;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    // RunObject = Report 65208;
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
        //Rec.SETFILTER("Semester Code",'=%1',semesterfilter);
    end;

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        ACASemesters.RESET;
        //ACASemesters.SETRANGE("Current Semester",TRUE);
        IF ACASemesters.FIND('-') THEN BEGIN
        END;
        IF ACASemesters.Code <> '' THEN
            semesterfilter := ACASemesters.Code;
    end;

    var
        VendorLedgerEntry: Record 25;
        ACASemesters: Record 61692;
        lineNo: Integer;
        semesterfilter: Code[20];
        OpenPostedSalesCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Sales Credit Memos window?';

    /* LectLoadCentralSetup: Record 65204;

    FINCashOfficeSetup: Record 61713;
    FINPaymentsHeader: Record "61688";
    FINPaymentLine: Record "61705"; */

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

