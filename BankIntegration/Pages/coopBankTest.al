page 84528 coopBankIntergration
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    SourceTable = "Coop Bank Intergration - Test";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(transactionReferenceCode; Rec.transactionReferenceCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the transactionReferenceCode field.';
                }
                field(messageID; Rec.messageID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the messageID field.';
                }
                field(accountName; Rec.accountName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the accountName field.';
                }
                field(institutionCode; Rec.institutionCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the institutionCode field.';
                }
                field(institutionName; Rec.institutionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the institutionName field.';
                }
                field(paymentAmount; Rec.paymentAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the paymentAmount field.';
                }
                field(statusCode; Rec.statusCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the statusCode field.';
                }
                field(statusDescription; Rec.statusDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the statusDescription field.';
                }
                field(transactionDate; Rec.transactionDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the transactionDate field.';
                }
                field(currency; Rec.currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the currency field.';
                }
                field(additionalInfo; Rec.additionalInfo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the additionalInfo field.';
                }
                field(accountNumber; Rec.accountNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the accountNumber field.';
                }
                field(posted; Rec.posted)
                {
                    ApplicationArea = All;

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(PostReceipts)
            {
                ApplicationArea = All;


                trigger OnAction();
                begin
                    coopBankCode := '29';
                    PostReceipt(Rec.transactionReferenceCode, Rec.accountNumber, Rec.paymentAmount, coopBankCode, Rec.accountName);
                end;
            }
        }
    }
    var
        coopBankCode: Code[20];

    local procedure PostReceipt(TransactionNo: Code[20]; StudentNo: Code[20]; BillAmounts: Decimal; BankCode: Code[20]; StudentName: Text[150])
    var
        cust2: Record Customer;
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";
        TotalApplied: Decimal;
        Sems: Record "ACA-Semesters";
        DueDate: Date;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CReg: Record "ACA-Course Registration";
        CustLedg: Record "Cust. Ledger Entry";
        StudentPay: Record "ACA-Std Payments";
        ProgrammeSetUp: Record "ACA-Programme";
        CourseReg: Code[20];
        LastReceiptNo: Code[20];
        "No. Series Line": Record "No. Series Line";
        "Last No": Code[20];
        Prog: Record "ACA-Programme";
        BankRec: Record "Bank Account";
        [InDataSet]
        "Amount to payEnable": Boolean;
        [InDataSet]
        "Cheque NoEnable": Boolean;
        [InDataSet]
        "Drawer NameEnable": Boolean;
        [InDataSet]
        "Bank No.Enable": Boolean;
        [InDataSet]
        "Bank Slip DateEnable": Boolean;
        [InDataSet]
        "Applies to Doc NoEnable": Boolean;
        [InDataSet]
        "Apply to OverpaymentEnable": Boolean;
        [InDataSet]
        "CDF AccountEnable": Boolean;
        [InDataSet]
        "CDF DescriptionEnable": Boolean;
        [InDataSet]
        ApplicationEnable: Boolean;
        [InDataSet]
        "Unref. Entry No.Enable": Boolean;
        [InDataSet]
        "Staff Invoice No.Enable": Boolean;
        [InDataSet]
        "Staff DescriptionEnable": Boolean;
        [InDataSet]
        "Payment ByEnable": Boolean;
        StudHostel: Record "ACA-Students Hostel Rooms";
        HostLedg: Record "ACA-Hostel Ledger";
        BankName: Text[100];
        ACAStdPayments: Record "ACA-Std Payments";
        BankIntergration: Record "Bank Intergration - Final";
        KCBBankIntergrationFinal: Record "Coop Bank Intergration - Test";


    begin
        ///////??????????????????????????????????????????????????? - Post Receipt
        //Insert into Receipts
        if StudentNo = '4031097' then exit;
        if Rec.posted = true then
            Error('Transaction Already Posted!');

        ACAStdPayments.Init;
        ACAStdPayments.Validate(ACAStdPayments."Student No.", StudentNo);
        ACAStdPayments.Validate(ACAStdPayments."Payment Mode", ACAStdPayments."Payment Mode"::"Bank Slip");
        ACAStdPayments.Validate(ACAStdPayments."Cheque No", TransactionNo);
        ACAStdPayments.Validate(ACAStdPayments."Amount to pay", BillAmounts);
        ACAStdPayments.Validate(ACAStdPayments."Bank Slip Date", Today);
        ACAStdPayments.Validate(ACAStdPayments."Bank No.", BankCode);
        ACAStdPayments.Validate(ACAStdPayments."Payment By", StudentName);
        ACAStdPayments.Validate(ACAStdPayments."Transaction Date", Today);
        ACAStdPayments.Validate(ACAStdPayments."Drawer Name", 'AUTOPOST');
        ACAStdPayments.Insert(true);

        if ((ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::"Bank Slip") or
        (ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::Cheque)) then begin
            // // TESTFIELD("Bank Slip Date");
            // // TESTFIELD("Bank No.");
        end;
        CustLedg.Reset;
        CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
        //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
        CustLedg.SetRange(CustLedg.Open, true);
        CustLedg.SetRange(CustLedg.Reversed, false);
        if CustLedg.Find('-') then begin
            repeat
                TotalApplied := TotalApplied + CustLedg."Amount Applied";
            until CustLedg.Next = 0;
        end;

        if ACAStdPayments."Amount to pay" > TotalApplied then begin

        end;
        if Cust.Get(StudentNo) then begin
            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
            Cust.Status := Cust.Status::Current;
            Cust.Modify;
        end;

        if Cust.Get(ACAStdPayments."Student No.") then
            GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;

        GenSetUp.Get();
        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;

        GenSetUp.TestField(GenSetUp."Pre-Payment Account");
        //Charge Student if not charged
        /*StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.",ACAStdPayments."Student No.");
        StudentCharges.SETRANGE(StudentCharges.Recognized,FALSE);
        IF StudentCharges.FIND('-') THEN BEGIN
        REPEAT
        DueDate:=StudentCharges.Date;
        IF Sems.GET(StudentCharges.Semester) THEN BEGIN
        IF Sems.From<>0D THEN BEGIN
        IF Sems.From > DueDate THEN
        DueDate:=Sems.From;
        END;
        END;
        
        GenJnl.INIT;
        GenJnl."Line No." := GenJnl."Line No." + 10000;
        GenJnl."Posting Date":=TODAY;
        GenJnl."Document No.":=ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name":='SALES';
        GenJnl."Journal Batch Name":='STUD PAY';
        GenJnl."Account Type":=GenJnl."Account Type"::Customer;
        //
        IF Cust.GET(ACAStdPayments."Student No.") THEN BEGIN
        IF Cust."Bill-to Customer No." <> '' THEN
        GenJnl."Account No.":=Cust."Bill-to Customer No."
        ELSE
        GenJnl."Account No.":=StudentNo;
        END;
        GenJnl.Amount:=StudentCharges.Amount;
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl.Description:=StudentCharges.Description;
        GenJnl."Bal. Account Type":=GenJnl."Account Type"::"G/L Account";
        IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") AND
           (StudentCharges.Charge = FALSE) THEN BEGIN
        GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
        
        CReg.RESET;
        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
        CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
        CReg.SETRANGE(CReg."Student No.",StudentCharges."Student No.");
        IF CReg.FIND('-') THEN BEGIN
        IF CReg."Register for"=CReg."Register for"::Stage THEN BEGIN
        Stages.RESET;
        Stages.SETRANGE(Stages."Programme Code",CReg.Programme);
        Stages.SETRANGE(Stages.Code,CReg.Stage);
        IF Stages.FIND('-') THEN BEGIN
        IF (Stages."Modules Registration" = TRUE) AND (Stages."Ignore No. Of Units"= FALSE) THEN BEGIN
        CReg.CALCFIELDS(CReg."Units Taken");
        IF CReg. Modules <> CReg."Units Taken" THEN;
        //ERROR('Units Taken must be equal to the no of modules registered for.');
        END;
        END;
        END;
        CReg.Posted:=TRUE;
        CReg.MODIFY;
        END;
        
        END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") AND
                    (StudentCharges.Charge = FALSE) THEN BEGIN
        GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
        
        CReg.RESET;
        CReg.SETCURRENTKEY(CReg."Reg. Transacton ID");
        CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
        IF CReg.FIND('-') THEN BEGIN
        CReg.Posted:=TRUE;
        CReg.MODIFY;
        END;
        
        END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" THEN BEGIN
        IF ExamsByStage.GET(StudentCharges.Programme,StudentCharges.Stage,StudentCharges.Semester,StudentCharges.Code) THEN
        GenJnl."Bal. Account No.":=ExamsByStage."G/L Account";
        
        END ELSE IF StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" THEN BEGIN
        IF ExamsByUnit.GET(StudentCharges.Programme,StudentCharges.Stage,ExamsByUnit."Unit Code",StudentCharges.Semester,
        StudentCharges.Code) THEN
        GenJnl."Bal. Account No.":=ExamsByUnit."G/L Account";
        
        END ELSE IF (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) OR
                    (StudentCharges.Charge = TRUE) THEN BEGIN
        IF Charges.GET(StudentCharges.Code) THEN
        GenJnl."Bal. Account No.":=Charges."G/L Account";
        END;
        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.",ACAStdPayments."Student No.");
        CReg.SETRANGE(CReg.Reversed,FALSE) ;
        IF CReg.FIND('+') THEN BEGIN
        IF ProgrammeSetUp.GET(CReg.Programme) THEN BEGIN
        ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
        GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
        IF cust2.GET() THEN
        IF cust2."Global Dimension 2 Code"<>'' THEN
        GenJnl."Shortcut Dimension 2 Code":=cust2."Global Dimension 2 Code";
        //ELSE ERROR('Department haiko!')
        //else
        //GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
        END;
        END;
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        GenJnl."Due Date":=DueDate;
        GenJnl.VALIDATE(GenJnl."Due Date");
        IF StudentCharges."Recovery Priority" <> 0 THEN
        GenJnl."Recovery Priority":=StudentCharges."Recovery Priority"
        ELSE
        GenJnl."Recovery Priority":=25;
        GenJnl.INSERT;
        
        //Distribute Money
        IF StudentCharges."Tuition Fee" = TRUE THEN BEGIN
        IF Stages.GET(StudentCharges.Programme,StudentCharges.Stage) THEN BEGIN
        IF (Stages."Distribution Full Time (%)" > 0) OR (Stages."Distribution Part Time (%)" > 0) THEN BEGIN
        Stages.TESTFIELD(Stages."Distribution Account");
        StudentCharges.TESTFIELD(StudentCharges.Distribution);
        IF Cust.GET(ACAStdPayments."Student No.") THEN BEGIN
        CustPostGroup.GET(Cust."Customer Posting Group");
        
        GenJnl.INIT;
        GenJnl."Line No." := GenJnl."Line No." + 10000;
        GenJnl."Posting Date":=TODAY;
        GenJnl."Document No.":=ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
        //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name":='SALES';
        GenJnl."Journal Batch Name":='STUD PAY';
        GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
        GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
        GenJnl."Account No.":=GenSetUp."Pre-Payment Account";
        GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl.Description:='Fee Distribution';
        GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
        GenJnl."Bal. Account No.":=Stages."Distribution Account";
        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.",ACAStdPayments."Student No.");
        CReg.SETRANGE(CReg.Reversed,FALSE) ;
        IF CReg.FIND('+') THEN BEGIN
        IF ProgrammeSetUp.GET(CReg.Programme) THEN BEGIN
        ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
        GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
        GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
        END;
        END;
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        
        GenJnl.INSERT;
        END;
        END;
        END;
        END ELSE BEGIN
        //Distribute Charges
        IF StudentCharges.Distribution > 0 THEN BEGIN
        StudentCharges.TESTFIELD(StudentCharges."Distribution Account");
        IF Charges.GET(StudentCharges.Code) THEN BEGIN
        Charges.TESTFIELD(Charges."G/L Account");
        GenJnl.INIT;
        GenJnl."Line No." := GenJnl."Line No." + 10000;
        GenJnl."Posting Date":=TODAY;
        GenJnl."Document No.":=ACAStdPayments."Cheque No";//StudentCharges."Transacton ID";
        GenJnl.VALIDATE(GenJnl."Document No.");
        GenJnl."Journal Template Name":='SALES';
        GenJnl."Journal Batch Name":='STUD PAY';
        GenJnl."Account Type":=GenJnl."Account Type"::"G/L Account";
        GenJnl."Account No.":=StudentCharges."Distribution Account";
        GenJnl.Amount:=StudentCharges.Amount * (StudentCharges.Distribution/100);
        GenJnl.VALIDATE(GenJnl."Account No.");
        GenJnl.VALIDATE(GenJnl.Amount);
        GenJnl.Description:='Fee Distribution';
        GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
        GenJnl."Bal. Account No.":=Charges."G/L Account";
        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
        //Stages.TESTFIELD(Stages.Department);
        CReg.RESET;
        CReg.SETRANGE(CReg."Student No.",ACAStdPayments."Student No.");
        CReg.SETRANGE(CReg.Reversed,FALSE) ;
        IF CReg.FIND('+') THEN BEGIN
        IF ProgrammeSetUp.GET(CReg.Programme) THEN BEGIN
        ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
        GenJnl."Shortcut Dimension 1 Code":=Cust."Global Dimension 1 Code";
        GenJnl."Shortcut Dimension 2 Code":=ProgrammeSetUp."Department Code";
        END;
        END;
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
        
        GenJnl.INSERT;
        
        END;
        END;
        END;
        //End Distribution
        
        StudentCharges.Recognized:=TRUE;
        StudentCharges.MODIFY;
        
        UNTIL StudentCharges.NEXT = 0;
        
        //Post New
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name",'SALES');
        GenJnl.SETRANGE("Journal Batch Name",'STUD PAY');
        IF GenJnl.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B2",GenJnl);
        END;
        
        //Post New
        
        END;
        */
        //BILLING

        "Last No" := '';
        "No. Series Line".Reset;
        BankRec.Get(ACAStdPayments."Bank No.");
        BankRec.TestField(BankRec."Receipt No. Series");
        "No. Series Line".SetRange("No. Series Line"."Series Code", BankRec."Receipt No. Series");
        if "No. Series Line".Find('-') then begin

            "Last No" := IncStr("No. Series Line"."Last No. Used");
            "No. Series Line"."Last No. Used" := IncStr("No. Series Line"."Last No. Used");
            "No. Series Line".Modify;
        end;


        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;



        Cust.Status := Cust.Status::Current;
        //Cust.MODIFY;

        // //
        // // IF "Payment Mode"="Payment Mode"::"Applies to Overpayment" THEN
        // // ERROR('Overpayment must be applied manualy.');


        /////////////////////////////////////////////////////////////////////////////////
        //Receive payments
        if ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::"Applies to Overpayment" then begin

            //Over Payment
            TotalApplied := 0;

            CustLedg.Reset;
            CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
            //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
            CustLedg.SetRange(CustLedg.Open, true);
            CustLedg.SetRange(CustLedg.Reversed, false);
            if CustLedg.Find('-') then begin
                repeat
                    TotalApplied := TotalApplied + CustLedg."Amount Applied";
                until CustLedg.Next = 0;
            end;

            CReg.Reset;
            CReg.SetCurrentKey(CReg."Reg. Transacton ID");
            //CReg.SETRANGE(CReg."Reg. Transacton ID",StudentCharges."Reg. Transacton ID");
            CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
            if CReg.Find('+') then
                CourseReg := CReg."Reg. Transacton ID";

            Receipt.Init;
            Receipt."Receipt No." := "Last No";
            //Receipt.VALIDATE(Receipt."Receipt No.");
            Receipt."Student No." := ACAStdPayments."Student No.";
            Receipt.Date := ACAStdPayments."Transaction Date";
            Receipt."KCA Rcpt No" := ACAStdPayments."KCA Receipt No";
            Receipt."Bank Slip Date" := ACAStdPayments."Bank Slip Date";
            Receipt."Bank Slip/Cheque No" := ACAStdPayments."Cheque No";
            Receipt.Validate("Bank Slip/Cheque No");
            Receipt."Bank Account" := ACAStdPayments."Bank No.";
            if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::"Bank Slip" then
                Receipt."Payment Mode" := Receipt."Payment Mode"::"Bank Slip" else
                if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::Cheque then
                    Receipt."Payment Mode" := Receipt."Payment Mode"::Cheque else
                    if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::Cash then
                        Receipt."Payment Mode" := Receipt."Payment Mode"::Cash else
                        Receipt."Payment Mode" := ACAStdPayments."Payment Mode";
            Receipt.Amount := ACAStdPayments."Amount to pay";
            Receipt."Payment By" := ACAStdPayments."Payment By";
            Receipt."Transaction Date" := Today;
            Receipt."Transaction Time" := Time;
            Receipt."User ID" := UserId;
            Receipt."Reg ID" := CourseReg;
            Receipt.Insert;

            Receipt.Reset;
            if Receipt.Find('+') then begin


                CustLedg.Reset;
                CustLedg.SetRange(CustLedg."Customer No.", ACAStdPayments."Student No.");
                //CustLedg.SETRANGE(CustLedg."Apply to",TRUE);
                CustLedg.SetRange(CustLedg.Open, true);
                CustLedg.SetRange(CustLedg.Reversed, false);
                if CustLedg.Find('-') then begin

                    GenSetUp.Get();


                end;

            end;

            //Bank Entry
            if BankRec.Get(ACAStdPayments."Bank No.") then
                BankName := BankRec.Name;

            if (ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::Unreferenced) and
            (ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::"Staff Invoice")
            and (ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::Weiver) and (ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::CDF)
            and (ACAStdPayments."Payment Mode" <> ACAStdPayments."Payment Mode"::HELB) then begin

                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := ACAStdPayments."Cheque No";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::"Bank Account";
                GenJnl."Account No." := ACAStdPayments."Bank No.";
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := Format(ACAStdPayments."Payment Mode") + '-' + Format(ACAStdPayments."Bank Slip Date") + '-' + BankName;
                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::Customer;
                if Cust."Bill-to Customer No." <> '' then
                    GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                else
                    GenJnl."Bal. Account No." := ACAStdPayments."Student No.";


                GenJnl.Validate(GenJnl."Bal. Account No.");

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                GenJnl.Insert;
            end;
            if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::Unreferenced then begin
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := ACAStdPayments."Drawer Name";
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                GenJnl."Account No." := 'UNREF';
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := Cust.Name;
                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::Customer;
                if Cust."Bill-to Customer No." <> '' then
                    GenJnl."Bal. Account No." := Cust."Bill-to Customer No."
                else
                    GenJnl."Bal. Account No." := ACAStdPayments."Student No.";

                //GenJnl."Applies-to Doc. No." := ACAStdPayments."Applies to Doc No";
                GenJnl.Validate(GenJnl."Applies-to Doc. No.");
                GenJnl.Insert;

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");


            end;
            // BKK...Staff Invoice
            if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::"Staff Invoice" then begin
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := '';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := 'Staff Invoice No. ' + ACAStdPayments."Staff Invoice No.";
                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                GenJnl."Bal. Account No." := '200012';

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                GenJnl.Insert;


            end;
            // BKK...CDF
            if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::CDF then begin
                GenSetUp.TestField(GenSetUp."CDF Account");
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := 'CDF';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := ACAStdPayments."CDF Description";
                //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::"G/L Account";
                //GenJnl."Bal. Account No.":=;
                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                GenJnl.Insert;

                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := 'CDF';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                GenJnl."Account No." := GenSetUp."CDF Account";
                GenJnl.Amount := ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := ACAStdPayments."Student No.";

                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        ProgrammeSetUp.TestField(ProgrammeSetUp."Department Code");
                        //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;
                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                GenJnl.Insert;


            end;

            if ACAStdPayments."Payment Mode" = ACAStdPayments."Payment Mode"::HELB then begin
                GenSetUp.TestField(GenSetUp."Helb Account");
                GenJnl.Init;
                GenJnl."Line No." := GenJnl."Line No." + 10000;
                GenJnl."Posting Date" := ACAStdPayments."Bank Slip Date";
                GenJnl."Document No." := "Last No";
                GenJnl."External Document No." := '';
                GenJnl.Validate(GenJnl."Document No.");
                GenJnl."Journal Template Name" := 'SALES';
                GenJnl."Journal Batch Name" := 'STUD PAY';
                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                GenJnl."Account No." := ACAStdPayments."Student No.";
                GenJnl.Amount := -ACAStdPayments."Amount to pay";
                GenJnl.Validate(GenJnl."Account No.");
                GenJnl.Validate(GenJnl.Amount);
                GenJnl.Description := 'HELB';
                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                GenJnl."Bal. Account No." := GenSetUp."Helb Account";
                CReg.Reset;
                CReg.SetRange(CReg."Student No.", ACAStdPayments."Student No.");
                CReg.SetRange(CReg.Reversed, false);
                if CReg.Find('+') then begin
                    if ProgrammeSetUp.Get(CReg.Programmes) then begin
                        GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                    end;
                end;

                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                GenJnl.Insert;


            end;

            //Post

            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            if GenJnl.Find('-') then begin

                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post B2", GenJnl);
                ACAStdPayments.Modify;
            end;

            // Hostel Allocations
            StudHostel.Reset;
            StudHostel.SetRange(StudHostel.Student, ACAStdPayments."Student No.");
            StudHostel.SetRange(StudHostel.Billed, false);
            if StudHostel.Find('-') then begin
                StudHostel.Billed := true;
                StudHostel.Modify;
                Receipts.Reset;
                if Receipts.Get("Last No") then begin
                    Receipts."Room No" := StudHostel."Space No";
                    Receipts.Modify;
                end;

                HostLedg.Reset;
                HostLedg.SetRange(HostLedg."Space No", StudHostel."Space No");
                HostLedg.SetRange(HostLedg."Hostel No", StudHostel."Hostel No");
                if HostLedg.Find('-') then begin
                    HostLedg.Status := HostLedg.Status::"Partially Occupied";
                    HostLedg.Modify;
                end;
            end;



            // // ACAStdPayments.

        end;
        // if BankCode = '12204' then begin
        //     BankIntergration.Reset;
        //     BankIntergration.SetRange(bankreference, TransactionNo);
        //     if BankIntergration.Find('-') then begin
        //         BankIntergration.Posted := true;
        //         BankIntergration.Modify(true);
        //     end;
        // end else
        //     if BankCode = '122046' then begin
        //         KCBBankIntergrationFinal.Reset;
        //         KCBBankIntergrationFinal.SetRange(transactionReferenceCode, TransactionNo);
        //         if KCBBankIntergrationFinal.Find('-') then begin
        //             KCBBankIntergrationFinal.Posted := true;
        //             KCBBankIntergrationFinal.Modify(true);
        //         end;
        //     end;
        Rec.posted := true;
        Rec.Modify();
        Message('Posted Successfully');

    end;
}