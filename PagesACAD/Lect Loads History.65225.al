page 65225 "Lect Loads History"
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
            repeater(Group)
            {
                FreezeColumn = "Courses Count";
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
                field("PV No."; Rec."PV No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Courses Count"; Rec."Courses Count")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
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
            action(PostLoad)
            {
                Caption = 'Post Load';
                Image = PostPrint;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*IF Rec."PV No."<>'' THEN ERROR('Load Already Created!');
                    IF CONFIRM('Post Load?',TRUE)=FALSE THEN EXIT;
                    CLEAR(NextOderNo);
                    IF Customer.GET(Rec."Lecturer Code") THEN BEGIN
                    IF SalesSetup.GET() THEN SalesSetup.TESTFIELD("Load Nos.");
                    NextOderNo:=NoSeriesMgt.GetNextNo(SalesSetup."Load Nos.",TODAY,TRUE);
                    SalesHeader.INIT;
                    SalesHeader."Document Type":=SalesHeader."Document Type"::Load;
                    SalesHeader."No.":=NextOderNo;
                    SalesHeader."Sell-to Customer No.":=Rec."Lecturer Code";
                    SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
                    SalesHeader."Bill-to Customer No.":=Rec."Lecturer Code";
                    SalesHeader.VALIDATE(SalesHeader."Bill-to Customer No.");
                    SalesHeader."Document Date":="Semester Code";
                    SalesHeader."Posting Date":="Semester Code";
                    SalesHeader."Posting Description":='Lect Sale-'+SalesHeader."Sell-to Customer Name";
                    SalesHeader."Load Date":="Semester Code";
                    SalesHeader."Due Date":="Semester Code";
                    SalesHeader."Salesperson Code":=Rec."Sales Person";
                    SalesHeader.Route:=Rec."Route Code";
                    SalesHeader."Location Code":='COLDROOM 2';
                    SalesHeader.VALIDATE("Location Code");
                    SalesHeader.INSERT(TRUE);
                    lineNo:=0;
                    //Create the Lines Here
                    LectLoadCustProdSource.RESET;
                    LectLoadCustProdSource.SETRANGE(Lecturer,Rec."Semester Code");
                    LectLoadCustProdSource.SETRANGE(Programme,Rec."Lecturer Code");
                    LectLoadCustProdSource.SETFILTER(Stage,'<>%1','');
                    LectLoadCustProdSource.SETFILTER("No. Of Hours Contracted",'>%1',0);
                    IF LectLoadCustProdSource.FIND('-') THEN BEGIN
                      REPEAT
                        BEGIN
                        lineNo:=lineNo+100;
                        IF Item.GET(LectLoadCustProdSource.Stage) THEN BEGIN
                    SalesLine.INIT;
                    SalesLine."Document Type":=SalesLine."Document Type"::Load;
                    SalesLine."Document No.":=NextOderNo;
                    SalesLine."Line No.":=lineNo;
                    SalesLine.Type:=SalesLine.Type::Item;
                    SalesLine."No.":=LectLoadCustProdSource.Stage;
                    SalesLine.VALIDATE("No.");
                    SalesLine."Unit of Measure":=LectLoadCustProdSource."Unit of Measure";
                    SalesLine."Location Code":='COLDROOM 2';
                    SalesLine.VALIDATE("Location Code");
                    SalesLine.Quantity:=LectLoadCustProdSource.Remarks;
                    SalesLine.VALIDATE(Quantity);
                    SalesLine."Qty. to Ship":=LectLoadCustProdSource.Remarks;
                    SalesLine."Qty. to Invoice":=LectLoadCustProdSource.Remarks;
                    SalesLine."Planned Delivery Date":=Rec."Semester Code";
                    SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                    SalesLine."Gen. Prod. Posting Group":=Item."Gen. Prod. Posting Group";
                    //SalesLine."VAT Bus. Posting Group":=Item.v
                    SalesLine."VAT Prod. Posting Group":=Item."VAT Prod. Posting Group";
                    SalesLine."Planned Shipment Date":=Rec."Semester Code";
                    SalesLine."Unit Price":=LectLoadCustProdSource."No. Of Hours";
                    //SalesLine.VALIDATE(Quantity);
                    //SalesLine.VALIDATE("No.");
                    //SalesLine.VALIDATE("Location Code");
                    
                    SalesLine.INSERT(TRUE);
                          END;
                    END;
                    UNTIL LectLoadCustProdSource.NEXT=0;
                    END;
                    //Set The Load Status as Posted and released then post
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE(SalesHeader."Document Type",SalesHeader."Document Type"::Load);
                    SalesHeader.SETRANGE(SalesHeader."No.",NextOderNo);
                    IF SalesHeader.FIND('-') THEN BEGIN
                      SalesHeader.Status:=SalesHeader.Status::Released;
                      SalesHeader.MODIFY;
                      END;
                    Rec."Load No.":=NextOderNo;
                    //Post the Load Here...
                    CODEUNIT.RUN(81,SalesHeader);
                    // Get and populate The Invoice and the shipment Numbers Here...
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Load No.",NextOderNo);
                    IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                      Rec."PV No.":=SalesInvoiceHeader."No.";
                      END;
                    
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Load No.",NextOderNo);
                    IF SalesShipmentHeader.FIND('-') THEN BEGIN
                      Rec."Claim No.":=SalesShipmentHeader."No.";
                      END;
                      Rec.MODIFY;
                      END;
                      */

                end;
            }
            action(PrintDispInv)
            {
                Caption = 'Print Disp. and Invoice';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*IF Rec."Load No."='' THEN ERROR('Post the Load first!');
                    
                          // Just print since the Load already posted
                          // Get and populate The Invoice and the shipment Numbers Here...
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Load No.",Rec."Load No.");
                    IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                       REPORT.RUN(65211,FALSE,TRUE,SalesInvoiceHeader);
                    //  Rec."Invoice No":=SalesInvoiceHeader."No.";
                      END;
                    
                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Load No.",Rec."Load No.");
                    IF SalesShipmentHeader.FIND('-') THEN BEGIN
                     // Rec."Shipment Number":=SalesShipmentHeader."No.";
                       REPORT.RUN(65210,FALSE,TRUE,SalesShipmentHeader);
                      END;
                      */

                end;
            }
            action(PrinAppointment)
            {
                Caption = 'Print Appointment Letter';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                Visible = statusVisible;
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

    trigger OnAfterGetRecord()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        IF Rec.Approve THEN statusVisible := TRUE ELSE statusVisible := FALSE;
    end;

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Batch Date",'=%1',DateFilter);
        //DateFilter:=TODAY;
    end;

    var
        statusVisible: Boolean;
        lineNo: Integer;

        NextOderNo: Code[20];

        SalesHeader: Record 36;

        OpenPostedSalesCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Sales Credit Memos window?';
        LectLoadPermissions: Record 65207;

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
        SalesHeader.RESET;
        SalesHeader.SETRANGE(SalesHeader."No.",DocNo);
        IF SalesHeader.FIND('-') THEN BEGIN
        
        SalesHeader.SendToPosting(PostingCodeunitID);
        DocumentIsPosted := NOT SalesHeader.GET(SalesHeader."Document Type"::"Credit Memo",DocNo);
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
        //CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        //CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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


    //[Scope('Internal')]
    procedure ShowPreview(DocNo: Code[20])
    var
        SalesPostYesNo: Codeunit 81;
    begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", DocNo);
        IF SalesHeader.FIND('-') THEN
            SalesPostYesNo.Preview(SalesHeader);
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



    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        SalesCrMemoHeader: Record 114;
        InstructionMgt: Codeunit 1330;
    begin
        SalesCrMemoHeader.SETRANGE("Pre-Assigned No.", PreAssignedNo);
        IF SalesCrMemoHeader.FINDFIRST THEN
            IF InstructionMgt.ShowConfirm(OpenPostedSalesCrMemoQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                PAGE.RUN(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record 36; var Handled: Boolean)
    begin
    end;
}

