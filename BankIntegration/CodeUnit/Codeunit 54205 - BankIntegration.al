codeunit 54205 BankIntegration
{

    trigger OnRun()
    var
        BankIntergrationFinal: Record "Bank Intergration - Final";
        KCBBankIntergrationFinal: Record "KCB Bank Intergration - Final";
        AmountsDecimal: Decimal;
    begin
        //PostReceipt('2020070854806451','SED/MAST/02132/019',1,'12204','SED/MAST/02132/019')
        /*BankIntergrationFinal.RESET;
        BankIntergrationFinal.SETRANGE(Posted,FALSE);
        BankIntergrationFinal.SETRANGE(bankreference,'2020070854806451');
        BankIntergrationFinal.SETFILTER(billAmount,'>0');
        IF BankIntergrationFinal.FIND('-') THEN BEGIN //Post for Equity
          REPEAT
            BEGIN
             RegisterNewStudent(BankIntergrationFinal.customerRefNumber);
             IF EVALUATE(AmountsDecimal,BankIntefrgrationFinal.billAmount) THEN;
            // PostUnpostedBills(BankIntergrationFinal.customerRefNumber);
             PostReceipt(BankIntergrationFinal.bankreference,BankIntergrationFinal.customerRefNumber,
             AmountsDecimal,'12204',BankIntergrationFinal.customerRefNumber);
            END;
            UNTIL BankIntergrationFinal.NEXT=0;
            END;*/
        /*
        KCBBankIntergrationFinal.RESET;
        KCBBankIntergrationFinal.SETRANGE(Posted,FALSE);
        KCBBankIntergrationFinal.SETRANGE(bankreference,'551639873');
        IF KCBBankIntergrationFinal.FIND('-') THEN BEGIN //Post for KCB
          REPEAT
            BEGIN
             RegisterNewStudent(KCBBankIntergrationFinal.customerRefNumber);
             IF EVALUATE(AmountsDecimal,KCBBankIntergrationFinal.billAmount) THEN;
             PostUnpostedBills(KCBBankIntergrationFinal.customerRefNumber);
             PostReceipt(KCBBankIntergrationFinal.bankreference,KCBBankIntergrationFinal.customerRefNumber,
             AmountsDecimal,'BNK0002',KCBBankIntergrationFinal.customerRefNumber);
            END;
            UNTIL KCBBankIntergrationFinal.NEXT=0;
            END;
            */

    end;

    var
        KUCCPSImports: Record "KUCCPS Imports";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure ValidateEqtyAccount(incustomerRefNumber: Code[20]) AccountStatus: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "KCB Bank Intergration - Test";
        KCBIntegerationValidation: Record "KCB Bank Intergration - Test";
        KUCCPSImports: Record "KUCCPS Imports";
    begin
        Clear(AccountStatus);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Check if the Student is an Applicant
            KUCCPSImports.Reset;
            KUCCPSImports.SetRange(Admin, incustomerRefNumber);
            if KUCCPSImports.Find('-') then begin
                AccountStatus := 'SUCCESS:' + KUCCPSImports.Names + '::' + '0.0' + '::' + 'Final_Account_3' + '::' + '33333333' + '::' + 'Fees' + '::' + 'success' + '::' + '1';
            end else
                //Student Does Not Exist
                AccountStatus := 'FAIL:Invalid Student number' + '::' + '0.0' + '::' + 'Final_Account_3' + '::' + '33333333' + '::' + 'Fees' + '::' + 'success' + '::' + '1';
            //EXIT;
        end else begin
            //Student Exists
            AccountStatus := 'SUCCESS:' + Cust.Name + '::' + '0.0' + '::' + 'Final_Account_3' + '::' + '33333333' + '::' + 'Fees' + '::' + 'success' + '::' + '1';
        end;
        // Insert into the Data Table
        //  KCBIntegerationValidation.INIT;
        // //    KCBIntegerationValidation."Validation Date":=TODAY;
        // //    KCBIntegerationValidation."Validation Time":=TIME;
        // //    KCBIntegerationValidation."Student No.":=incustomerRefNumber;
        // //    KCBIntegerationValidation."Transaction Response":=AccountStatus;
        // //    IF KCBIntegerationValidation.INSERT THEN;
    end;

    procedure GetAccountDetails(incustomerRefNumber: Code[20]) AccountStatus: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "Coop Bank Intergration - Test";
    begin
        Clear(AccountStatus);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if Cust.Find('-') then begin
            AccountStatus := Cust."No." + ':::' + '' + Cust.Name;
        end;
    end;

    procedure MessageIdExists(messageid: Code[50]) AccountStatus: Boolean
    var
        BankIntergration: Record "Coop Bank Intergration - Test";
    begin
        Clear(AccountStatus);
        BankIntergration.Reset;
        BankIntergration.SetRange(messageID, messageid);
        if BankIntergration.Find('-') then begin
            AccountStatus := true;
        end;
    end;

    procedure TransactionCodeExists(transcode: Code[20]) AccountStatus: Boolean
    var
        BankIntergration: Record "Coop Bank Intergration - Test";
    begin
        Clear(AccountStatus);
        BankIntergration.Reset;
        BankIntergration.SetRange(BankIntergration.transactionReferenceCode, transcode);
        if BankIntergration.Find('-') then begin
            AccountStatus := true;
        end;
    end;

    procedure PostCoopBTransaction(messageid: Code[50]; statuscode: Code[20]; statusdesc: Text[200]; transrefcode: Code[50]; transDate: DateTime; totalamount: Decimal; accountNo: Code[20]; accountName: Text[100]; institutioncode: Code[20]; institutionName: Text[100]) Status: Boolean
    var
        Cust: Record Customer;
        BankIntergration: Record "Coop Bank Intergration - Test";
        AmountsDecimal: Decimal;
    begin
        Clear(Status);
        Cust.Reset;
        Cust.SetRange("No.", accountNo);
        if Cust.Find('-') then begin
            BankIntergration.Reset;
            BankIntergration.SetRange(transactionReferenceCode, transrefcode);
            if not BankIntergration.Find('-') then begin
                BankIntergration.Init;
                BankIntergration.messageID := messageid;
                BankIntergration.statusCode := statuscode;
                BankIntergration.statusDescription := statusdesc;
                BankIntergration.transactionReferenceCode := transrefcode;
                BankIntergration.transactionDate := transDate;
                BankIntergration.paymentAmount := totalamount;
                BankIntergration.accountNumber := accountNo;
                BankIntergration.accountName := accountName;
                BankIntergration.institutionCode := institutioncode;
                BankIntergration.institutionName := institutionName;
                BankIntergration.Insert;
                Status := true;
                if status = true then begin
                    PostCoopReceipt(transrefcode, accountNo, totalamount, '29', accountName);
                end
            end;
        end;
    end;

    local procedure PostNcbaReceipt(TransactionNo: Code[20]; StudentNo: Code[20]; BillAmounts: Decimal; BankCode: Code[20]; StudentName: Text[150])
    var
        cust2: Record Customer;
        bankTrans: Record "KCB Bank Intergration - Test";
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
        bankTrans.Reset;
        bankTrans.SetRange(bankTrans.bankreference, TransactionNo);
        if bankTrans.Find('-') then begin
            bankTrans.Posted := true;
            bankTrans.Modify(true);
        end;

    end;

    local procedure PostCoopReceipt(TransactionNo: Code[20]; StudentNo: Code[20]; BillAmounts: Decimal; BankCode: Code[20]; StudentName: Text[150])
    var
        cust2: Record Customer;
        copTrans: Record "Coop Bank Intergration - Test";
        equityTrans: Record "Bank Intergration - Final";
        ncbaTrans: Record "KCB Bank Intergration - Test";
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
        copTrans.Reset;
        copTrans.SetRange(transactionReferenceCode, TransactionNo);
        if copTrans.Find('-') then begin
            copTrans.Posted := true;
            copTrans.Modify(true);
        end;
        equityTrans.Reset();
        equityTrans.SetRange(bankreference, TransactionNo);
        if equityTrans.Find('-') then begin
            equityTrans.Posted := true;
            equityTrans.Modify();
        end;
        ncbaTrans.Reset();
        ncbaTrans.SetRange(bankreference, TransactionNo);
        if ncbaTrans.Find('-') then begin
            ncbaTrans.Posted := true;
            ncbaTrans.Modify();
        end


    end;

    procedure FnGetAccountDetails(appno: code[20]) msg: Text
    var
        applist: Record "ACA-Applic. Form Header";
    begin
        applist.reset;
        applist.setrange("Application No.", appno);
        if applist.FIND('-') then begin
            msg := applist."Application No.";
        end;
    end;

    procedure FnInsertTransaction(transrefno: code[20]; accno: code[20]; accname: text[100]; phone: text[20]; transamt: decimal; accbal: decimal) inserted: Text
    var
        mpesavalidate: Record "M-pesa Validation";
    begin
        mpesavalidate.reset;
        mpesavalidate.setrange(transactionRefNo, transrefno);
        if mpesavalidate.Find('-') then begin
            inserted := 'Already Inserted'
        end else begin
            mpesavalidate.init;
            mpesavalidate.transactionRefNo := transrefno;
            mpesavalidate.accountNo := accno;
            mpesavalidate.accountName := accname;
            mpesavalidate.telephoneNo := phone;
            mpesavalidate.transactionAmount := transamt;
            mpesavalidate.accountBalance := accbal;
            mpesavalidate.insert;
            inserted := 'TRUE';
        end
    end;

    procedure FnInsertMpesaTransaction(transrefno: code[20]; accno: code[20]; accname: text[100]; phone: text[20]; transamt: decimal; accbal: decimal; paybillno: code[20]) inserted: Text
    var
        mpesaconfirmed: Record confirmedMpesaTransaction;
    begin
        mpesaconfirmed.reset;
        mpesaconfirmed.setrange(transactionRefNo, transrefno);
        if mpesaconfirmed.Find('-') then begin
            inserted := 'REFEXISTS'
        end else begin
            mpesaconfirmed.init;
            mpesaconfirmed.transactionRefNo := transrefno;
            mpesaconfirmed.accountNo := accno;
            mpesaconfirmed.accountName := accname;
            mpesaconfirmed.telephoneNo := phone;
            mpesaconfirmed.transactionAmount := transamt;
            mpesaconfirmed.accountBalance := accbal;
            mpesaconfirmed.paybillNo := paybillno;
            mpesaconfirmed.insert;
            inserted := 'TRUE';
        end
    end;

    procedure GetPayEqtyTrans(inbankreference: Code[50]; indebitaccount: Code[20]; intransactionDate: Code[20]; inbillAmount: Decimal; inpaymentMode: Code[20]; inphonenumber: Code[20]; incustomerRefNumber: Code[20]; indebitcustname: Text[150]) Status: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "Bank Intergration - Final";
        AmountsDecimal: Decimal;
    begin
        // // // CLEAR(Status);
        // // // Cust.RESET;
        // // // Cust.SETRANGE("No.",incustomerRefNumber);
        // // // IF NOT Cust.FIND('-') THEN BEGIN
        // // //  //Student Does Not Exist
        // // //  Status:='FAIL:'+'::'+''+ incustomerRefNumber +' Does not exist';
        // // //  //EXIT;
        // // //  END  ELSE BEGIN
        // // //    //Student Exists
        // // //    BankIntergration.RESET;
        // // //    BankIntergration.SETRANGE(bankreference,inbankreference);
        // // //    IF BankIntergration.FIND('-') THEN BEGIN
        // // //      //The Transaction Already Exists
        // // //      Status:='FAIL:'+'::'+'Transaction '+inbankreference+' Already Exists';
        // // //      END ELSE BEGIN
        // // //        //The Transaction Does Not Exist
        // // //                BankIntergration.INIT;
        // // //                BankIntergration.bankreference:=inbankreference;
        // // //                BankIntergration.customerRefNumber:=incustomerRefNumber;
        // // //                BankIntergration.debitaccount:=indebitaccount;
        // // //                BankIntergration.debitcustname:=indebitcustname;
        // // //                BankIntergration.paymentMode:=inpaymentMode;
        // // //                BankIntergration.transactionDate:=intransactionDate;
        // // //                BankIntergration.phonenumber:=inphonenumber;
        // // //                BankIntergration.billAmount:=inbillAmount;
        // // //                BankIntergration.INSERT;
        // // //                Status:='OK'+'::'+'SUCCESSFULL';
        // // //              END;
        // // //    END;
        Clear(Status);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Check if the Student is an Applicant
            KUCCPSImports.Reset;
            KUCCPSImports.SetRange(Admin, incustomerRefNumber);
            if KUCCPSImports.Find('-') then begin
                //  AccountStatus:='SUCCESS:'+KUCCPSImports.Names+'::'+'0.0'+'::'+'Test_Account_3'+'::'+'33333333'+'::'+'Fees'+'::'+'success'+'::'+'1';
                //Student Exists
                BankIntergration.Reset;
                BankIntergration.SetRange(bankreference, inbankreference);
                if BankIntergration.Find('-') then begin
                    //The Transaction Already Exists
                    Status := 'FAIL:' + '::' + 'Transaction ' + inbankreference + ' Already Exists';
                end else begin
                    //The Transaction Does Not Exist
                    BankIntergration.Init;
                    BankIntergration.bankreference := inbankreference;
                    BankIntergration.customerRefNumber := incustomerRefNumber;
                    BankIntergration.debitaccount := indebitaccount;
                    BankIntergration.debitcustname := indebitcustname;
                    BankIntergration.paymentMode := inpaymentMode;
                    BankIntergration.transactionDate := intransactionDate;
                    BankIntergration.phonenumber := inphonenumber;
                    BankIntergration.billAmount := inbillAmount;
                    BankIntergration."New Student" := true;
                    BankIntergration.Insert;
                    Status := 'OK' + '::' + 'SUCCESSFULL';

                end;
            end else
                //Student Does Not Exist
                Status := 'FAIL:' + '::' + '' + incustomerRefNumber + ' Does not exist';
            //EXIT;
        end else begin
            //Student Exists
            BankIntergration.Reset;
            BankIntergration.SetRange(bankreference, inbankreference);
            if BankIntergration.Find('-') then begin
                //The Transaction Already Exists
                Status := 'FAIL:' + '::' + 'Transaction ' + inbankreference + ' Already Exists';
            end else begin
                //The Transaction Does Not Exist
                Cust.Reset;
                Cust.Setrange("No.", incustomerRefNumber);
                IF Cust.FIND('-') THEN BEGIN
                    BankIntergration.Init;
                    BankIntergration.bankreference := inbankreference;
                    BankIntergration.customerRefNumber := incustomerRefNumber;
                    BankIntergration.debitaccount := indebitaccount;
                    BankIntergration.debitcustname := Cust.Name; //indebitcustname;
                    BankIntergration.paymentMode := inpaymentMode;
                    BankIntergration.transactionDate := intransactionDate;
                    BankIntergration.phonenumber := inphonenumber;
                    BankIntergration.billAmount := inbillAmount;
                    BankIntergration.Insert;
                    Status := 'OK' + '::' + 'SUCCESSFULL';
                    PostCoopReceipt(inbankreference, incustomerRefNumber, inbillAmount, '46', indebitcustname);
                END
            end;

        end;

        // if incustomerRefNumber <> '4031097' then begin
        //     if Status = 'OK::SUCCESSFULL' then begin
        //         Clear(AmountsDecimal);
        //         RegisterNewStudent(incustomerRefNumber);
        //         if Evaluate(AmountsDecimal, inbillAmount) then;
        //         //PostUnpostedBills(incustomerRefNumber);
        //         PostReceipt(inbankreference, incustomerRefNumber, AmountsDecimal, '12204', indebitcustname)
        //     end;
        // end;
    end;

    local procedure PostEqtyReceipt()
    begin
    end;

    procedure ValidateKCBAccount(incustomerRefNumber: Code[20]) AccountStatus: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "KCB Bank Intergration - Test";
        KCBIntegerationValidation: Record "KCB-Integeration Validation";
    begin
        Clear(AccountStatus);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Student Does Not Exist
            AccountStatus := 'FAIL' + '::' + 'Invalid Student number';
            //EXIT;
        end else begin
            //Student Exists
            AccountStatus := 'SUCCESS' + '::' + '' + Cust.Name;
        end;
        //Insert into the Data Table
        KCBIntegerationValidation.Init;
        KCBIntegerationValidation."Validation Date" := Today;
        KCBIntegerationValidation."Validation Time" := Time;
        KCBIntegerationValidation."Student No." := incustomerRefNumber;
        KCBIntegerationValidation."Transaction Response" := AccountStatus;
        if KCBIntegerationValidation.Insert then;
    end;

    procedure GetPayKCBTrans(inbankreference: Code[50]; indebitaccount: Code[20]; intransactionDate: Code[20]; inbillAmount: Decimal; inpaymentMode: Code[20]; inphonenumber: Code[20]; incustomerRefNumber: Code[20]; indebitcustname: Text[150]) Status: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "KCB Bank Intergration - Test";
        AmountsDecimal: Decimal;
        transStat: Text[200];
    begin
        Clear(Status);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Student Does Not Exist
            Status := 'FAIL' + '::' + '' + incustomerRefNumber + ' Does not exist';
            //EXIT;
        end else begin
            //Student Exists
            BankIntergration.Reset;
            BankIntergration.SetRange(bankreference, inbankreference);
            if BankIntergration.Find('-') then begin
                //The Transaction Already Exists
                Status := 'FAIL' + '::' + 'Transaction ' + inbankreference + ' Already Exists';
            end else begin
                //The Transaction Does Not Exist
                BankIntergration.Init;
                BankIntergration.bankreference := inbankreference;
                BankIntergration.customerRefNumber := incustomerRefNumber;
                BankIntergration.debitaccount := indebitaccount;
                BankIntergration.debitcustname := indebitcustname;
                BankIntergration.paymentMode := inpaymentMode;
                BankIntergration.transactionDate := intransactionDate;
                BankIntergration.phonenumber := inphonenumber;
                BankIntergration.billAmount := inbillAmount;
                BankIntergration.Insert;
                PostCoopReceipt(inbankreference, incustomerRefNumber, inbillAmount, '35', indebitcustname);
                Status := 'OK' + '::' + 'POSTED';


            end;
        end;

        /*if Status = 'SUCCESS:' + '::' + 'Posted' then begin
            Clear(AmountsDecimal);
            RegisterNewStudent(incustomerRefNumber);
            if Evaluate(AmountsDecimal, inbillAmount) then;
            PostUnpostedBills(incustomerRefNumber);
            PostReceipt(inbankreference, incustomerRefNumber, AmountsDecimal, 'BNK0002', indebitcustname)
        end;*/
    end;

    local procedure InitiaTePost(AdminNo: Code[20])
    begin
    end;

    local procedure PostUnpostedBills(StudentNo: Code[20])
    var
        PictureExists: Boolean;
        StudentPayments: Record "ACA-Std Payments";
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
        StudentCharges2: Record "ACA-Std Charges";
        CourseReg: Record "ACA-Course Registration";
        CurrentBill: Decimal;
        GLEntry: Record "G/L Entry";
        CustLed: Record "Cust. Ledger Entry";
        BankLedg: Record "Bank Account Ledger Entry";
        DCustLedg: Record "Detailed Cust. Ledg. Entry";
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record "Vendor Ledger Entry";
        DVendLedg: Record "Detailed Vendor Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CReg: Record "ACA-Course Registration";
        StudCharges: Record "ACA-Std Charges";
        CustLed2: Record "Cust. Ledger Entry";
        Receipt2: Record "ACA-Receipt";
        Cont: Boolean;
        Cust: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        window: Dialog;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Receipts: Record "ACA-Receipt";
        CustLedg: Record "Cust. Ledger Entry";
        DueDate: Date;
        Sems: Record "ACA-Semesters";
        ChangeLog: Record "Change Log Entry";
        CurrentBal: Decimal;
        Prog: Record "ACA-Programme";
        "Settlement Type": Record "ACA-Settlement Type";
        AccPayment: Boolean;
        SettlementType: Code[20];
        SettlementTypes: Record "ACA-Settlement Type";
    begin
        /////////**************************************************************************************************************************
        //BILLING
        AccPayment := false;
        StudentCharges.Reset;
        StudentCharges.SetRange(StudentCharges."Student No.", StudentNo);
        StudentCharges.SetRange(StudentCharges.Recognized, false);
        StudentCharges.SetFilter(StudentCharges.Code, '<>%1', '');
        if StudentCharges.Find('-') then begin
            //IF NOT CONFIRM('Un-billed charges will be posted. Do you wish to continue?',FALSE) = TRUE THEN
            // ERROR('You have selected to Abort Student Billing');
            if Cust.Get(StudentNo) then;

            SettlementType := '';
            CReg.Reset;
            CReg.SetFilter(CReg."Settlement Type", '<>%1', '');
            CReg.SetRange(CReg."Student No.", StudentNo);
            if CReg.Find('-') then
                SettlementType := CReg."Settlement Type";
            // // ELSE
            // // ERROR('The Settlement Type Does not Exists in the Course Registration');

            SettlementTypes.Get(SettlementType);
            SettlementTypes.TestField(SettlementTypes."Tuition G/L Account");




            // MANUAL APPLICATION OF ACCOMODATION FOR PREPAYED STUDENTS//
            if StudentCharges.Count = 1 then begin
                Cust.CalcFields(Balance);
                if Cust.Balance < 0 then begin
                    if Abs(Cust.Balance) > StudentCharges.Amount then begin
                        Cust."Application Method" := Cust."Application Method"::Manual;
                        AccPayment := true;
                        Cust.Modify;
                    end;
                end;
            end;

        end;


        //ERROR('TESTING '+FORMAT("Application Method"));

        if Cust.Get(StudentNo) then;

        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", 'SALES');
        GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
        GenJnl.DeleteAll;

        GenSetUp.Get();
        //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");

        //Charge Student if not charged
        StudentCharges.Reset;
        StudentCharges.SetRange(StudentCharges."Student No.", StudentNo);
        StudentCharges.SetRange(StudentCharges.Recognized, false);
        if StudentCharges.Find('-') then begin

            repeat
                if StudentCharges.Amount <> 0 then begin
                    DueDate := StudentCharges.Date;
                    if Sems.Get(StudentCharges.Semester) then begin
                        if Sems.From <> 0D then begin
                            if Sems.From > DueDate then
                                DueDate := Sems.From;
                        end;
                    end;


                    GenJnl.Init;
                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                    GenJnl."Posting Date" := Today;
                    GenJnl."Document No." := StudentCharges."Transacton ID";
                    GenJnl.Validate(GenJnl."Document No.");
                    GenJnl."Journal Template Name" := 'SALES';
                    GenJnl."Journal Batch Name" := 'STUD PAY';
                    GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                    //
                    if Cust.Get(StudentNo) then begin
                        if Cust."Bill-to Customer No." <> '' then
                            GenJnl."Account No." := Cust."Bill-to Customer No."
                        else
                            GenJnl."Account No." := StudentNo;
                    end;

                    GenJnl.Amount := StudentCharges.Amount;
                    GenJnl.Validate(GenJnl."Account No.");
                    GenJnl.Validate(GenJnl.Amount);
                    GenJnl.Description := StudentCharges.Description;
                    GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";

                    if (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Fees") and
                       (StudentCharges.Charge = false) then begin
                        GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                        CReg.Reset;
                        CReg.SetCurrentKey(CReg."Reg. Transacton ID");
                        CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                        CReg.SetRange(CReg."Student No.", StudentCharges."Student No.");
                        if CReg.Find('-') then begin
                            if CReg."Register for" = CReg."Register for"::Stage then begin
                                Stages.Reset;
                                Stages.SetRange(Stages."Programme Code", CReg.Programmes);
                                Stages.SetRange(Stages.Code, CReg.Stage);
                                if Stages.Find('-') then begin
                                    if (Stages."Modules Registration" = true) and (Stages."Ignore No. Of Units" = false) then begin
                                        CReg.CalcFields(CReg."Units Taken");
                                        // // IF CReg. Modules <> CReg."Units Taken" THEN
                                        // // ERROR('Units Taken must be equal to the no of modules registered for.');

                                    end;
                                end;
                            end;

                            CReg.Posted := true;
                            CReg.Modify;
                        end;


                    end else
                        if (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Fees") and
                           (StudentCharges.Charge = false) then begin
                            //GenJnl."Bal. Account No.":=GenSetUp."Pre-Payment Account";
                            StudentCharges.CalcFields(StudentCharges."Settlement Type");
                            GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";


                            CReg.Reset;
                            CReg.SetCurrentKey(CReg."Reg. Transacton ID");
                            CReg.SetRange(CReg."Reg. Transacton ID", StudentCharges."Reg. Transacton ID");
                            if CReg.Find('-') then begin
                                CReg.Posted := true;
                                CReg.Modify;
                            end;



                        end else
                            if StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Stage Exam Fees" then begin
                                if ExamsByStage.Get(StudentCharges.Programme, StudentCharges.Stage, StudentCharges.Semester, StudentCharges.Code) then
                                    GenJnl."Bal. Account No." := ExamsByStage."G/L Account";

                            end else
                                if StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::"Unit Exam Fees" then begin
                                    if ExamsByUnit.Get(StudentCharges.Programme, StudentCharges.Stage, ExamsByUnit."Unit Code", StudentCharges.Semester,
                                    StudentCharges.Code) then
                                        GenJnl."Bal. Account No." := ExamsByUnit."G/L Account";

                                end else
                                    if (StudentCharges."Transaction Type" = StudentCharges."Transaction Type"::Charges) or
                                       (StudentCharges.Charge = true) then begin
                                        if Charges.Get(StudentCharges.Code) then
                                            GenJnl."Bal. Account No." := Charges."G/L Account";
                                    end;


                    GenJnl.Validate(GenJnl."Bal. Account No.");
                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    if Prog.Get(StudentCharges.Programme) then begin
                        Prog.TestField(Prog."Department Code");
                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                    end;



                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                    GenJnl."Due Date" := DueDate;
                    GenJnl.Validate(GenJnl."Due Date");
                    if StudentCharges."Recovery Priority" <> 0 then
                        GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                    else
                        GenJnl."Recovery Priority" := 25;
                    GenJnl.Insert;

                    //Distribute Money
                    if StudentCharges."Tuition Fee" = true then begin
                        if Stages.Get(StudentCharges.Programme, StudentCharges.Stage) then begin
                            if (Stages."Distribution Full Time (%)" > 0) or (Stages."Distribution Part Time (%)" > 0) then begin
                                Stages.TestField(Stages."Distribution Account");
                                StudentCharges.TestField(StudentCharges.Distribution);
                                if Cust.Get(StudentNo) then begin
                                    CustPostGroup.Get(Cust."Customer Posting Group");

                                    GenJnl.Init;
                                    GenJnl."Line No." := GenJnl."Line No." + 10000;
                                    GenJnl."Posting Date" := Today;
                                    GenJnl."Document No." := StudentCharges."Transacton ID";
                                    //GenJnl."Document Type":=GenJnl."Document Type"::Payment;
                                    GenJnl.Validate(GenJnl."Document No.");
                                    GenJnl."Journal Template Name" := 'SALES';
                                    GenJnl."Journal Batch Name" := 'STUD PAY';
                                    GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                    //GenSetUp.TESTFIELD(GenSetUp."Pre-Payment Account");
                                    GenJnl."Account No." := SettlementTypes."Tuition G/L Account";
                                    GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                    GenJnl.Validate(GenJnl."Account No.");
                                    GenJnl.Validate(GenJnl.Amount);
                                    GenJnl.Description := 'Fee Distribution';
                                    GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                    //GenJnl."Bal. Account No.":=Stages."Distribution Account";

                                    StudentCharges.CalcFields(StudentCharges."Settlement Type");
                                    SettlementTypes.Get(StudentCharges."Settlement Type");
                                    GenJnl."Bal. Account No." := SettlementTypes."Tuition G/L Account";

                                    GenJnl.Validate(GenJnl."Bal. Account No.");
                                    GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                    if Prog.Get(StudentCharges.Programme) then begin
                                        Prog.TestField(Prog."Department Code");
                                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                    end;

                                    GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                                    GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");

                                    GenJnl.Insert;

                                end;
                            end;
                        end;
                    end else begin
                        //Distribute Charges
                        if StudentCharges.Distribution > 0 then begin
                            StudentCharges.TestField(StudentCharges."Distribution Account");
                            if Charges.Get(StudentCharges.Code) then begin
                                Charges.TestField(Charges."G/L Account");
                                GenJnl.Init;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := Today;
                                GenJnl."Document No." := StudentCharges."Transacton ID";
                                GenJnl.Validate(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
                                GenJnl."Account No." := StudentCharges."Distribution Account";
                                GenJnl.Amount := StudentCharges.Amount * (StudentCharges.Distribution / 100);
                                GenJnl.Validate(GenJnl."Account No.");
                                GenJnl.Validate(GenJnl.Amount);
                                GenJnl.Description := 'Fee Distribution';
                                GenJnl."Bal. Account Type" := GenJnl."Bal. Account Type"::"G/L Account";
                                GenJnl."Bal. Account No." := Charges."G/L Account";
                                GenJnl.Validate(GenJnl."Bal. Account No.");
                                GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";

                                if Prog.Get(StudentCharges.Programme) then begin
                                    Prog.TestField(Prog."Department Code");
                                    GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                                end;
                                GenJnl.Validate(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.Validate(GenJnl."Shortcut Dimension 2 Code");
                                GenJnl.Insert;

                            end;
                        end;
                    end;
                    //End Distribution


                    StudentCharges.Recognized := true;
                    StudentCharges.Modify;
                    //.......BY TTT (Tom Temba Tinga)
                    StudentCharges.Posted := true;
                    StudentCharges.Modify;

                    CReg.Posted := true;
                    CReg.Modify;


                    //.....END TTT (Tom Temba Tinga)
                end;
            until StudentCharges.Next = 0;

            //Post New
            GenJnl.Reset;
            GenJnl.SetRange("Journal Template Name", 'SALES');
            GenJnl.SetRange("Journal Batch Name", 'STUD PAY');
            if GenJnl.Find('-') then begin
                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnl);
            end;
            //Post New
            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
            Cust.Status := Cust.Status::Current;
            Cust.Modify;
        end;

        //BILLING

        StudentPayments.Reset;
        StudentPayments.SetRange(StudentPayments."Student No.", StudentNo);
        if StudentPayments.Find('-') then
            StudentPayments.DeleteAll;


        StudentPayments.Reset;
        StudentPayments.SetRange(StudentPayments."Student No.", StudentNo);
        if AccPayment = true then begin
            if Cust.Get(StudentNo) then
                Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
            Cust.Modify;
        end;
        //PAGE.RUN(68788,StudentPayments);
        //Receipt Here
        /////////**************************************************************************************************************************
    end;

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
        KCBBankIntergrationFinal: Record "KCB Bank Intergration - Final";
    begin
        ///////??????????????????????????????????????????????????? - Post Receipt
        //Insert into Receipts
        if StudentNo = '4031097' then exit;

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
        if BankCode = '12204' then begin
            BankIntergration.Reset;
            BankIntergration.SetRange(bankreference, TransactionNo);
            if BankIntergration.Find('-') then begin
                BankIntergration.Posted := true;
                BankIntergration.Modify(true);
            end;
        end else
            if BankCode = '122046' then begin
                KCBBankIntergrationFinal.Reset;
                KCBBankIntergrationFinal.SetRange(bankreference, TransactionNo);
                if KCBBankIntergrationFinal.Find('-') then begin
                    KCBBankIntergrationFinal.Posted := true;
                    KCBBankIntergrationFinal.Modify(true);
                end;
            end;

    end;

    local procedure TransferToAdmission(AdmissionNumber: Code[20])
    var
        AdminSetup: Record "KUCCPS Imports";
        NewAdminCode: Code[20];
        Customer: Record Customer;
        CourseRegistration: Record "ACA-Course Registration";
        Admissions: Record "ACA-Adm. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        ACAApplicSetupCounty: Record "ACA-Applic. Setup County";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        MedicalCondition: Record "ACA-Medical Condition";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        Immunization: Record "ACA-Immunization";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
    begin
        /*This function transfers the fieldsin the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/

        AdminSetup.Reset;
        AdminSetup.SetRange(AdminSetup.Admin, AdmissionNumber);
        if AdminSetup.Find('-') then begin
            Customer.Init;
            Customer."No." := AdminSetup.Admin;
            Customer.Name := CopyStr(AdminSetup.Names, 1, 80);
            Customer."Search Name" := UpperCase(CopyStr(AdminSetup.Names, 1, 80));
            Customer.Address := AdminSetup.Admin;
            if AdminSetup.Admin <> '' then
                Customer."Address 2" := CopyStr(AdminSetup."Permanent Residence", 1, 30);
            // IF AdminSetup.Gender<>'' THEN
            Customer.Gender := AdminSetup.Gender;
            //  Customer."Telex No.":=Rec."Fax No.";
            Customer."E-Mail" := AdminSetup.Email;
            Customer."ID No" := AdminSetup."ID Number/Birth Certificate";
            // Customer."Date Of Birth":=AdminSetup."Date of Birth";
            Customer."Date Registered" := Today;
            Customer."Customer Type" := Customer."Customer Type"::Student;
            //Customer."Student Type":=FORMAT(Enrollment."Student Type");
            //Customer."Date Of Birth":=AdminSetup."Date of Birth";
            // Customer."ID No":=AdminSetup."ID Number/Birth Certificate";
            Customer."Application No." := AdminSetup.Admin;
            //Customer."Marital Status":=AdminSetup."Marital Status";
            //Customer.Citizenship:=FORMAT(AdminSetup.Nationality);
            Customer."Current Programme" := AdminSetup.Prog;
            Customer."Current Semester" := 'SEM 1 2021/2022';
            Customer."Current Stage" := 'Y1S1';
            //Customer.Religion:=FORMAT(AdminSetup.Religion);
            Customer."Application Method" := Customer."Application Method"::"Apply to Oldest";
            Customer."Customer Posting Group" := 'STUDENT';
            Customer.Validate(Customer."Customer Posting Group");
            Customer."Global Dimension 1 Code" := 'MAIN';
            //Customer.County:=AdminSetup.County;
            Customer.Insert();

            ////////////////////////////////////////////////////////////////////////////////////////


            Customer.Reset;
            Customer.SetRange("No.", AdminSetup.Admin);
            //Customer.SETFILTER("Date Registered",'=%1',TODAY);
            if Customer.Find('-') then begin
                if AdminSetup.Gender = AdminSetup.Gender::Female then begin
                    Customer.Gender := Customer.Gender::Female;
                end else begin
                    Customer.Gender := Customer.Gender::Male;
                end;
                Customer.Modify;
            end;

            Customer.Reset;
            Customer.SetRange("No.", AdminSetup.Admin);
            Customer.SetFilter("Date Registered", '=%1', Today);
            if Customer.Find('-') then begin
                CourseRegistration.Reset;
                CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                CourseRegistration.SetRange(Semester, 'SEM 1 2022/2023');
                if not CourseRegistration.Find('-') then begin
                    CourseRegistration.Init;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.Validate(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := AdminSetup.Admin;
                    CourseRegistration.Programmes := AdminSetup.Prog;
                    CourseRegistration.Semester := 'SEM 1 2022/2023';
                    CourseRegistration.Stage := 'Y1S1';
                    CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
                    CourseRegistration."Registration Date" := Today;
                    CourseRegistration."Settlement Type" := 'KUCCPS';
                    CourseRegistration."Academic Year" := '2021/2023';

                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.Insert;
                    CourseRegistration.Reset;
                    CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                    CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                    CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                    CourseRegistration.SetRange(Semester, 'SEM 1 2022/2023');
                    if CourseRegistration.Find('-') then begin
                        CourseRegistration."Settlement Type" := 'KUCCPS';
                        CourseRegistration.Validate(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2021/2023';
                        CourseRegistration."Registration Date" := Today;
                        CourseRegistration.Validate(CourseRegistration."Registration Date");
                        CourseRegistration.Modify;

                    end;
                end else begin
                    CourseRegistration.Reset;
                    CourseRegistration.SetRange("Student No.", AdminSetup.Admin);
                    CourseRegistration.SetRange("Settlement Type", 'KUCCPS');
                    CourseRegistration.SetRange(Programmes, AdminSetup.Prog);
                    CourseRegistration.SetRange(Semester, 'SEM 1 2022/2023');
                    CourseRegistration.SetFilter(Posted, '=%1', false);
                    if CourseRegistration.Find('-') then begin
                        CourseRegistration."Settlement Type" := 'KUCCPS';
                        CourseRegistration.Validate(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := '2021/2023';
                        CourseRegistration."Registration Date" := Today;
                        CourseRegistration.Validate(CourseRegistration."Registration Date");
                        CourseRegistration.Modify;

                    end;
                end;
            end;
            /*Get the record and transfer the details to the admissions database*/
            //ERROR('TEST- '+NewAdminCode);
            /*Transfer the details into the admission database table*/
            NewAdminCode := AdmissionNumber;
            Admissions.Init;
            Admissions."Admission No." := NewAdminCode;
            Admissions.Validate("Admission No.");
            Admissions.Date := Today;
            Admissions."Application No." := Format(AdminSetup.ser);
            Admissions."Admission Type" := 'KUCCPS';
            Admissions."Academic Year" := '2021/2023';
            Admissions.Surname := AdminSetup.Index;
            // Admissions."Other Names":=AdminSetup.Names;
            Admissions.Status := Admissions.Status::Admitted;
            Admissions."Degree Admitted To" := AdminSetup.Prog;
            Admissions.Validate("Degree Admitted To");
            //Admissions."Date Of Birth":=AdminSetup."Date of Birth";
            Admissions.Gender := AdminSetup.Gender;
            //Admissions."Marital Status":=AdminSetup."Marital Status";
            //Admissions.County:=AdminSetup.County;
            Admissions.Campus := 'MAIN';
            //Admissions.Nationality:=AdminSetup.Nationality;
            Admissions."Correspondence Address 1" := AdminSetup.Admin;
            //Admissions."Correspondence Address 2":=AdminSetup.Codes;
            //Admissions."Correspondence Address 3":=AdminSetup.Town;
            Admissions."Telephone No. 1" := AdminSetup.Phone;
            Admissions."Telephone No. 2" := AdminSetup.Phone;
            //Admissions."Former School Code":=AdminSetup."Former School Code";
            Admissions."Index Number" := AdminSetup.Admin;
            Admissions."Stage Admitted To" := 'Y1S1';
            Admissions."Semester Admitted To" := 'SEM 1 2022/2023';
            Admissions."Settlement Type" := 'KUCCPS';
            //Admissions."Intake Code":=AdminSetup."Intake Code";
            //Admissions."ID Number":=AdminSetup."ID Number/Birth Certificate";
            Admissions."E-Mail" := AdminSetup.Names;
            // Admissions."Telephone No. 1":=AdminSetup."Telephone No. 1";
            // Admissions."Telephone No. 2":=AdminSetup."Telephone No. 1";
            Admissions.Insert();
            AdminSetup.Admin := NewAdminCode;
            /*Get the subject details and transfer the  same to the admissions subject*/
            ApplicationSubject.Reset;
            ApplicationSubject.SetRange(ApplicationSubject."Application No.", AdminSetup.Admin);
            if ApplicationSubject.Find('-') then begin
                /*Get the last number in the admissions table*/
                AdmissionSubject.Reset;
                if AdmissionSubject.Find('+') then begin
                    LineNo := AdmissionSubject."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;

                /*Insert the new records into the database table*/
                repeat
                    with AdmissionSubject do begin
                        Init;
                        "Line No." := LineNo + 1;
                        "Admission No." := NewAdminCode;
                        "Subject Code" := ApplicationSubject."Subject Code";
                        Grade := Grade;
                        Insert();
                        LineNo := LineNo + 1;
                    end;
                until ApplicationSubject.Next = 0;
            end;
            /*Insert the medical conditions into the admission database table containing the medical condition*/
            MedicalCondition.Reset;
            MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
            if MedicalCondition.Find('-') then begin
                /*Get the last line number from the medical condition table for the admissions module*/
                AdmissionMedical.Reset;
                if AdmissionMedical.Find('+') then begin
                    LineNo := AdmissionMedical."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;
                AdmissionMedical.Reset;
                /*Loop thru the medical conditions*/
                repeat
                    AdmissionMedical.Init;
                    AdmissionMedical."Line No." := LineNo + 1;
                    AdmissionMedical."Admission No." := NewAdminCode;
                    AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionMedical.Insert();
                    LineNo := LineNo + 1;
                until MedicalCondition.Next = 0;
            end;
            /*Insert the details into the family table*/
            MedicalCondition.Reset;
            MedicalCondition.SetRange(MedicalCondition.Mandatory, true);
            MedicalCondition.SetRange(MedicalCondition.Family, true);
            if MedicalCondition.Find('-') then begin
                /*Get the last number in the family table*/
                AdmissionFamily.Reset;
                if AdmissionFamily.Find('+') then begin
                    LineNo := AdmissionFamily."Line No.";
                end
                else begin
                    LineNo := 0;
                end;
                repeat
                    AdmissionFamily.Init;
                    AdmissionFamily."Line No." := LineNo + 1;
                    AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                    AdmissionFamily."Admission No." := NewAdminCode;
                    AdmissionFamily.Insert();
                    LineNo := LineNo + 1;
                until MedicalCondition.Next = 0;
            end;

            /*Insert the immunization details into the database*/
            Immunization.Reset;
            //Immunization.SETRANGE(Immunization.Mandatory,TRUE);
            if Immunization.Find('-') then begin
                /*Get the last line number from the database*/
                AdmissionImmunization.Reset;
                if AdmissionImmunization.Find('+') then begin
                    LineNo := AdmissionImmunization."Line No." + 1;
                end
                else begin
                    LineNo := 1;
                end;
                /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
                repeat
                    AdmissionImmunization.Init;
                    AdmissionImmunization."Line No." := LineNo + 1;
                    AdmissionImmunization."Admission No." := NewAdminCode;
                    AdmissionImmunization."Immunization Code" := Immunization.Code;
                    AdmissionImmunization.Insert();
                until Immunization.Next = 0;
            end;

            TakeStudentToRegistration(NewAdminCode);
        end;

    end;

    local procedure TakeStudentToRegistration(AdmissNo: Code[20])
    var
        Admissions: Record "ACA-Adm. Form Header";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentKin: Record "ACA-Student Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
    begin
        Admissions.Reset;
        Admissions.SetRange("Admission No.", AdmissNo);
        if Admissions.Find('-') then begin

            //insert the details related to the next of kin of the student into the database
            AdminKin.Reset;
            AdminKin.SetRange(AdminKin."Admission No.", Admissions."Admission No.");
            if AdminKin.Find('-') then begin
                repeat
                    StudentKin.Reset;
                    StudentKin.Init;
                    StudentKin."Student No" := Admissions."Admission No.";
                    StudentKin.Relationship := AdminKin.Relationship;
                    StudentKin.Name := AdminKin."Full Name";
                    //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                    //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                    //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                    //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                    StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                    StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                    //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                    StudentKin.Insert;
                until AdminKin.Next = 0;
            end;

            //insert the details in relation to the guardian/sponsor into the database in relation to the current student
            if Admissions."Mother Alive Or Dead" = Admissions."Mother Alive Or Dead"::Alive then begin
                if Admissions."Mother Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Mother Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Father Alive Or Dead" = Admissions."Father Alive Or Dead"::Alive then begin
                if Admissions."Father Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Father Full Name";
                    StudentGuardian.Insert;
                end;
            end;
            if Admissions."Guardian Full Name" <> '' then begin
                if Admissions."Guardian Full Name" <> '' then begin
                    StudentGuardian.Reset;
                    StudentGuardian.Init;
                    StudentGuardian."Student No." := Admissions."Admission No.";
                    StudentGuardian.Names := Admissions."Guardian Full Name";
                    StudentGuardian.Insert;
                end;
            end;
        end;
    end;

    // local procedure SubmitReferral(Username: Text; Reason: Text)
    // var
    //     EmployeeCard: Record "HRM-Employee (D)";
    //     Referrralll: Record "HMS-Referral Header";
    //     NextLeaveApplicationNo: Code[20];
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    // begin

    //     NextLeaveApplicationNo := NoSeriesMgt.GetNextNo('HOSPAPP', 0D, true);
    //     EmployeeCard.Reset;
    //     EmployeeCard.SetRange(EmployeeCard."No.", Username);
    //     if EmployeeCard.Find('-') then begin
    //         Referrralll.Init;
    //         Referrralll."Treatment no." := NextLeaveApplicationNo;
    //         Referrralll."Date Referred" := Today;
    //         Referrralll."Referral Reason" := Reason;
    //         Referrralll.Status := Referrralll.Status::New;
    //         Referrralll.Surname := EmployeeCard."Last Name";
    //         Referrralll."Middle Name" := EmployeeCard."Middle Name";
    //         Referrralll."Last Name" := EmployeeCard."First Name";
    //         Referrralll."ID Number" := EmployeeCard."First Name";
    //         Referrralll."Correspondence Address 1" := EmployeeCard."Postal Address";
    //         Referrralll."Telephone No. 1" := EmployeeCard."Cellular Phone Number";
    //         Referrralll.Email := EmployeeCard."Company E-Mail";
    //         //Referrralll."Staff No":=Username;
    //         //Referrralll."No. Series":='HOSPAPP';
    //         Referrralll.Insert();
    //     end;
    // end;

    local procedure RegisterNewStudent(AdmissionNoz: Code[20])
    var
        AdminSetup: Record "KUCCPS Imports";
        NewAdminCode: Code[20];
        Customer: Record Customer;
        CourseRegistration: Record "ACA-Course Registration";
        Admissions: Record "ACA-Adm. Form Header";
        ApplicationSubject: Record "ACA-Applic. Form Academic";
        ACAApplicSetupCounty: Record "ACA-Applic. Setup County";
        AdmissionSubject: Record "ACA-Adm. Form Academic";
        LineNo: Integer;
        MedicalCondition: Record "ACA-Medical Condition";
        AdmissionMedical: Record "ACA-Adm. Form Medical Form";
        AdmissionFamily: Record "ACA-Adm. Form Family Medical";
        Immunization: Record "ACA-Immunization";
        AdmissionImmunization: Record "ACA-Adm. Form Immunization";
        Cust: Record Customer;
        FacultyName: Text[30];
        DegreeName: Text[200];
        AgeText: Text[100];
        NationalityName: Text[30];
        ReligionName: Text[30];
        FormerSchoolName: Text[30];
        HasValue: Boolean;
        StudentKin: Record "ACA-Student Kin";
        AdminKin: Record "ACA-Adm. Form Next of Kin";
        StudentGuardian: Record "ACA-Student Sponsors Details";
        [InDataSet]
        "Guardian Full NameEnable": Boolean;
        [InDataSet]
        "Guardian OccupationEnable": Boolean;
        [InDataSet]
        "Spouse NameEnable": Boolean;
        [InDataSet]
        "Spouse Address 1Enable": Boolean;
        [InDataSet]
        "Spouse Address 2Enable": Boolean;
        [InDataSet]
        "Spouse Address 3Enable": Boolean;
        [InDataSet]
        "Family ProblemEnable": Boolean;
        [InDataSet]
        "Health ProblemEnable": Boolean;
        [InDataSet]
        "Overseas ScholarshipEnable": Boolean;
        [InDataSet]
        "Course Not PreferenceEnable": Boolean;
        [InDataSet]
        EmploymentEnable: Boolean;
        [InDataSet]
        "Other ReasonEnable": Boolean;
    begin
        // Pick from KUCCPS
        if not Cust.Get(AdmissionNoz) then begin
            //Capture KUCCPS
            TransferToAdmission(AdmissionNoz);
        end;
        Admissions.Reset;
        Admissions.SetRange("Admission No.", AdmissionNoz);
        if Admissions.Find('-') then begin
            if not Cust.Get(AdmissionNoz) then begin
                with Admissions do begin
                    Cust.Init;
                    Cust."No." := "Admission No.";
                    Cust.Name := CopyStr(Surname + ' ' + "Other Names", 1, 30);
                    Cust."Search Name" := UpperCase(CopyStr(Surname + ' ' + "Other Names", 1, 30));
                    Cust.Address := "Correspondence Address 1";
                    Cust."Address 2" := CopyStr("Correspondence Address 2" + ',' + "Correspondence Address 3", 1, 30);
                    Cust."Phone No." := "Telephone No. 1" + ',' + "Telephone No. 2";
                    Cust."Telex No." := "Fax No.";
                    Cust."E-Mail" := "E-Mail";
                    Cust.Gender := Gender;
                    Cust."Date Of Birth" := "Date Of Birth";
                    Cust."Date Registered" := Today;
                    Cust."Customer Type" := Cust."Customer Type"::Student;
                    //        Cust."Student Type":=FORMAT(Enrollment."Student Type");
                    //        Cust."ID No":=;
                    Cust."Application No." := "Admission No.";
                    Cust."Marital Status" := "Marital Status";
                    Cust.Citizenship := Format(Nationality);
                    Cust.Religion := Format(Religion);
                    Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                    Cust."Customer Posting Group" := 'STUDENT';
                    Cust.Validate(Cust."Customer Posting Group");
                    Cust."ID No" := "ID Number";
                    Cust."Global Dimension 1 Code" := Campus;
                    Cust.Insert();


                    //insert the course registration details
                    CourseRegistration.Reset;
                    CourseRegistration.Init;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.Validate(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := "Admission No.";
                    CourseRegistration.Programmes := "Degree Admitted To";
                    CourseRegistration.Semester := "Semester Admitted To";
                    CourseRegistration.Stage := "Stage Admitted To";
                    CourseRegistration."Student Type" := CourseRegistration."Student Type"::"Full Time";
                    CourseRegistration."Registration Date" := Today;
                    CourseRegistration."Settlement Type" := "Settlement Type";
                    CourseRegistration."Academic Year" := GetCurrYear();

                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.Insert;

                    CourseRegistration.Reset;
                    CourseRegistration.SetRange(CourseRegistration."Student No.", "Admission No.");
                    if CourseRegistration.Find('+') then begin
                        CourseRegistration."Registration Date" := Today;
                        CourseRegistration.Validate(CourseRegistration."Registration Date");
                        CourseRegistration."Settlement Type" := "Settlement Type";
                        CourseRegistration.Validate(CourseRegistration."Settlement Type");
                        CourseRegistration."Academic Year" := GetCurrYear();
                        CourseRegistration.Modify;

                    end;



                    //insert the details related to the next of kin of the student into the database
                    AdminKin.Reset;
                    AdminKin.SetRange(AdminKin."Admission No.", "Admission No.");
                    if AdminKin.Find('-') then begin
                        repeat
                            StudentKin.Reset;
                            StudentKin.Init;
                            StudentKin."Student No" := "Admission No.";
                            StudentKin.Relationship := AdminKin.Relationship;
                            StudentKin.Name := AdminKin."Full Name";
                            //StudentKin."Other Names":=EnrollmentNextofKin."Other Names";
                            //StudentKin."ID No/Passport No":=EnrollmentNextofKin."ID No/Passport No";
                            //StudentKin."Date Of Birth":=EnrollmentNextofKin."Date Of Birth";
                            //StudentKin.Occupation:=EnrollmentNextofKin.Occupation;
                            StudentKin."Office Tel No" := AdminKin."Telephone No. 1";
                            StudentKin."Home Tel No" := AdminKin."Telephone No. 2";
                            //StudentKin.Remarks:=EnrollmentNextofKin.Remarks;
                            StudentKin.Insert;
                        until AdminKin.Next = 0;
                    end;

                    //insert the details in relation to the guardian/sponsor into the database in relation to the current student
                    if "Mother Alive Or Dead" = "Mother Alive Or Dead"::Alive then begin
                        if "Mother Full Name" <> '' then begin
                            StudentGuardian.Reset;
                            StudentGuardian.Init;
                            StudentGuardian."Student No." := "Admission No.";
                            StudentGuardian.Names := "Mother Full Name";
                            StudentGuardian.Insert;
                        end;
                    end;
                    if "Father Alive Or Dead" = "Father Alive Or Dead"::Alive then begin
                        if "Father Full Name" <> '' then begin
                            StudentGuardian.Reset;
                            StudentGuardian.Init;
                            StudentGuardian."Student No." := "Admission No.";
                            StudentGuardian.Names := "Father Full Name";
                            StudentGuardian.Insert;
                        end;
                    end;
                    if "Guardian Full Name" <> '' then begin
                        if "Guardian Full Name" <> '' then begin
                            StudentGuardian.Reset;
                            StudentGuardian.Init;
                            StudentGuardian."Student No." := "Admission No.";
                            StudentGuardian.Names := "Guardian Full Name";
                            StudentGuardian.Insert;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure GetCurrYear() CurrYear: Text[100]
    var
        acadYear: Record "ACA-Academic Year";
    begin
        acadYear.Reset;
        acadYear.SetRange(acadYear.Current, true);
        if acadYear.Find('-') then begin
            CurrYear := acadYear.Code;
        end else
            Error('No current academic year specified.');
    end;
}

