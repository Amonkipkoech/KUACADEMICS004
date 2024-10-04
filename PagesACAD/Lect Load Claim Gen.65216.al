page 65216 "Lect Load Claim Gen."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65201;
    SourceTableView = WHERE("Courses Count" = FILTER(> 0));

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
                        //Rec.SETFILTER("Semester Code",'=%1',semesterfilter);
                        CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Group)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
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
                field(Amount; Rec.Amount)
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
                action(GenClaim)
                {
                    Caption = 'Generate Claim';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F2';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        counted: Integer;
                        PurchaseHeader: Record 38;
                        PurchaseLine: Record 39;
                    begin
                        IF Rec."Claim No." <> '' THEN ERROR('Claim Already Created!');
                        LectLoadCentralSetup.RESET;
                        IF LectLoadCentralSetup.FIND('-') THEN BEGIN
                            LectLoadCentralSetup.TESTFIELD("Part-Time Expenses Account");
                            LectLoadCentralSetup.TESTFIELD("Gen. Bus. Posting Group");
                            LectLoadCentralSetup.TESTFIELD("Vendor Posting Group");
                        END;

                        Rec.CALCFIELDS("Exists Part-Time", "Pending Marks");
                        IF NOT Rec."Exists Part-Time" THEN ERROR(Rec."Lecturer Name" + ' has no part-time units');
                        //IF NOT Approve THEN ERROR('Not Approved');
                        //IF "Pending Marks" THEN ERROR('Some Marks are not submitted by the Lecturer');

                        IF CONFIRM('Create Claim?', TRUE) = FALSE THEN ERROR('You cancelled the process');
                        CLEAR(NextOderNo);
                        IF NOT Vendor.GET(Rec."Lecturer Code") THEN BEGIN
                            Rec.CALCFIELDS("Lecturer Name");
                            Vendor.INIT;
                            Vendor."No." := Rec."Lecturer Code";
                            Vendor.Name := Rec."Lecturer Name";
                            Vendor."Search Name" := Rec."Lecturer Name";
                            Vendor."Gen. Bus. Posting Group" := LectLoadCentralSetup."Gen. Bus. Posting Group";
                            Vendor."Vendor Posting Group" := LectLoadCentralSetup."Vendor Posting Group";
                            Vendor.INSERT;


                        END;
                        IF Vendor.GET(Rec."Lecturer Code") THEN BEGIN
                            IF PurchasesSetup.GET() THEN PurchasesSetup.TESTFIELD("Invoice Nos.");
                            NextOderNo := NoSeriesMgt.GetNextNo(PurchasesSetup."Invoice Nos.", TODAY, TRUE);
                            /////////////////////////////////////////88888888888888888888888888
                            PurchasesHeader.INIT;
                            PurchasesHeader."Document Type" := PurchasesHeader."Document Type"::Invoice;
                            PurchasesHeader."No." := NextOderNo;
                            PurchasesHeader."Buy-from Vendor No." := Rec."Lecturer Code";
                            PurchasesHeader."Pay-to Vendor No." := Rec."Lecturer Code";
                            PurchasesHeader."Document Date" := TODAY;
                            PurchasesHeader."Posting Date" := TODAY;
                            PurchasesHeader."Posting Description" := COPYSTR('Part-Time Lecturer Invoice for: ' + Rec."Lecturer Code", 1, 50);
                            PurchasesHeader."Order Date" := TODAY;
                            PurchasesHeader."Due Date" := TODAY;
                            PurchasesHeader."Vendor Invoice No." := COPYSTR((Rec."Semester Code" + FORMAT(TODAY) + FORMAT(TIME)), 1, 35);
                            PurchasesHeader.INSERT(TRUE);
                            lineNo := 0;

                            //Create the Lines Here
                            LectLoadCustProdSource.RESET;
                            LectLoadCustProdSource.SETRANGE(Semester, Rec."Semester Code");
                            LectLoadCustProdSource.SETRANGE(Lecturer, Rec."Lecturer Code");
                            //LectLoadCustProdSource.SETFILTER("Marks Submitted",'%1',TRUE);
                            //LectLoadCustProdSource.SETFILTER(Approved,'%1',TRUE);
                            LectLoadCustProdSource.SETFILTER("Unit Cost", '>%1', 0);
                            IF LectLoadCustProdSource.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    lineNo := lineNo + 100;
                                    IF GLAccount.GET(LectLoadCentralSetup."Part-Time Expenses Account") THEN BEGIN
                                        GLAccount.TESTFIELD("Gen. Prod. Posting Group");
                                        PurchasesLine.INIT;
                                        PurchasesLine."Document Type" := PurchasesLine."Document Type"::Invoice;
                                        PurchasesLine."Document No." := NextOderNo;
                                        PurchasesLine."Line No." := lineNo;
                                        PurchasesLine.Type := PurchasesLine.Type::"G/L Account";
                                        PurchasesLine."No." := LectLoadCentralSetup."Part-Time Expenses Account";
                                        PurchasesLine.VALIDATE("No.");
                                        PurchasesLine.Description := COPYSTR('Part-Time(' + LectLoadCustProdSource.Unit + ':' + LectLoadCustProdSource.Description + ')', 1, 35);
                                        PurchasesLine.Quantity := 1;
                                        PurchasesLine.VALIDATE(Quantity);
                                        //PurchasesLine."Qty. to Ship":=1;
                                        PurchasesLine."Qty. to Invoice" := 1;
                                        PurchasesLine."Expected Receipt Date" := TODAY;
                                        PurchasesLine."Gen. Bus. Posting Group" := Vendor."Gen. Bus. Posting Group";
                                        PurchasesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                                        //PurchaseLine."VAT Bus. Posting Group":='STD';
                                        PurchasesLine."Planned Receipt Date" := TODAY;
                                        PurchasesLine."Direct Unit Cost" := LectLoadCustProdSource."Unit Cost";
                                        PurchasesLine.VALIDATE("Unit Cost");
                                        //PurchasesLine."Line Amount":=LectLoadCustProdSource."Unit Cost";
                                        //PurchasesLine.VALIDATE("Line Amount");
                                        PurchasesLine.INSERT(TRUE);

                                        counted := counted + 1;

                                    END;
                                END;
                                UNTIL LectLoadCustProdSource.NEXT = 0;
                            END;
                            //Set The Load Status as Posted and released then post
                            PurchasesHeader.RESET;
                            PurchasesHeader.SETRANGE(PurchasesHeader."Document Type", PurchasesHeader."Document Type"::Invoice);
                            PurchasesHeader.SETRANGE(PurchasesHeader."No.", NextOderNo);
                            IF PurchasesHeader.FIND('-') THEN BEGIN
                                //Send Approval Request
                                PurchasesHeader.VALIDATE(PurchasesHeader."Buy-from Vendor No.");
                                PurchasesHeader.VALIDATE(PurchasesHeader."Pay-to Vendor No.");
                                PurchasesHeader.MODIFY;
                                PurchasesHeader.Status := PurchasesHeader.Status::"Pending Approval";
                                PurchasesHeader.MODIFY;
                            END;
                            Rec."Claim No." := NextOderNo;
                            Rec.MODIFY;
                            //Post the Load Here...
                            //CODEUNIT.RUN(81,PurchasesHeader);
                            // Get and populate The Invoice and the shipment Numbers Here...
                            // // // SalesInvoiceHeader.RESET;
                            // // // SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Load No.",NextOderNo);
                            // // // IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                            // // //  Rec."PV No.":=SalesInvoiceHeader."No.";
                            // // //  END;
                            /*
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Load No.",NextOderNo);
                            IF SalesShipmentHeader.FIND('-') THEN BEGIN
                              Rec."Claim No.":=SalesShipmentHeader."No.";
                              END;
                              Rec.MODIFY;*/

                            Rec.Claimed := TRUE;
                            Rec.MODIFY
                        END;// ELSE ERROR('Part-timer not created as a service Provide!');

                        MESSAGE('The Claim has been created but requires approval by the HOD');

                    end;
                }
                action(PrintDispInv)
                {
                    Caption = 'Print &Disp. and Invoice';
                    Image = PrintAcknowledgement;
                    Promoted = true;
                    PromotedIsBig = true;
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
                    //RunObject = Report 65208;
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
        LectLoadBatches: Record 65200;
        NextOderNo: Code[20];
        PurchasesSetup: Record 312;

        PurchasesHeader: Record 38;
        PurchasesLine: Record 39;
        CustLedgEntry: Record 21;

        NoSeriesMgt: Codeunit 396;

        Vendor: Record 23;
        LectLoadCustProdSource: Record 65202;

        [InDataSet]

        JobQueueVisible: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CustomerSelected: Boolean;
        OpenPostedSalesCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Sales Credit Memos window?';

        LectLoadCentralSetup: Record 65204;
        GLAccount: Record 15;

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

