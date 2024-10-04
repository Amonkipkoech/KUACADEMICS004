table 52012 "Parttime Claim Header"
{
    LookupPageId = "Parttime Claim List";
    DrillDownPageId = "Parttime Claim List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';
        }
        field(3; "Global Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            var
                HRMempD: Record "HRM-Employee (D)";
                parttimeLine: Record "Parttime Claim Lines";
            begin
                parttimeLine.Reset();
                parttimeLine.SetRange("Document No.", "No.");
                parttimeLine.DeleteAll();

                HRMempD.RESET;
                IF HRMempD.GET("Account No.") THEN BEGIN
                    payee := HRMempD."First Name" + ' ' + HRMempD."Middle Name" + ' ' + HRMempD."Last Name";
                END;
            end;
        }
        field(6; payee; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the claim voucher was taken';
        }
        field(7; "Payment Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Parttime Claim Lines".Amount WHERE("Document No." = FIELD("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
        }
        field(8; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.RESET;
                "Bank Name" := '';
                IF BankAcc.GET("Paying Bank Account") THEN BEGIN
                    "Bank Name" := BankAcc.Name;
                END;
            end;
        }
        field(9; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }

        field(10; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,Mpesa;
        }
        field(11; "Cheque No."; Code[20])
        {
        }
        field(12; "Payment Release Date"; Date)
        {
        }
        field(13; Purpose; Text[250])
        {
        }
        field(14; "Responsibility Center"; Code[50])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(15; Cashier; Code[30])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(16; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"Pending Approval",,Approved,Posted,Cancelled;
        }
        field(17; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(18; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(19; "Time Posted"; Time)
        {
        }
        field(20; "Posted By"; Code[20])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(21; Semester; code[30])
        {
            TableRelation = "ACA-Semesters"."Code";
            trigger OnValidate()
            var
                Acasem: Record "ACA-Semesters";
                parttimeLine: Record "Parttime Claim Lines";
            begin
                parttimeLine.Reset();
                parttimeLine.SetRange("Document No.", "No.");
                parttimeLine.DeleteAll();

                Acasem.Reset();
                Acasem.SetRange(Code, Semester);
                if Acasem.Find('-') then begin
                    "Academic Year" := Acasem."Academic Year";
                    "Semester Start Date" := Acasem.From;
                    "Semester End Date" := Acasem."To";
                end;
            end;
        }
        field(22; "Academic Year"; code[30])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(23; "Semester Start Date"; date)
        {

        }
        field(24; "Semester End Date"; date)
        {

        }
        field(25; "Expense AC"; code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(26; "Expense Ac Name"; Text[100])
        {

        }
        field(27; "Payee Code"; code[30])
        {
            TableRelation = "FIN-Tariff Codes".Code;
        }
        field(28; "Payee AC"; code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(29; "Payee Rates"; Decimal)
        {

        }
        field(30; "Payee Amount"; Decimal)
        {

        }
        field(31; "Main Bank"; Code[10])
        {
            TableRelation = "PRL-Bank Structure"."Bank Code";
        }
        field(32; "Main Bank Name"; Text[100])
        {

        }
        field(33; "Branch Bank"; Code[10])
        {
            TableRelation = "PRL-Bank Structure"."Branch Code" WHERE("Bank Code" = FIELD("Main Bank"));

            trigger OnValidate()
            var
                bankStructure: Record "PRL-Bank Structure";
            begin
                Rec.TestField("Main Bank");
                bankStructure.Reset();
                bankStructure.SetRange("Bank Code", rec."Main Bank");
                bankStructure.SetRange("Branch Code", Rec."Branch Bank");
                if bankStructure.FindFirst() then begin
                    "Main Bank Name" := bankStructure."Bank Name";
                    "Branch Bank Name" := bankStructure."Branch Name";
                end;
            end;
        }
        field(34; "Branch Bank Name"; Text[100])
        {

        }
        field(35; "Bank Account No."; Text[30])
        {

        }

        field(50; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF (Status = Status::Approved) OR (Status = Status::Posted) OR (Status = Status::"Pending Approval") THEN
            ERROR('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    begin
        GenLedgerSetup.Reset();
        GenLedgerSetup.SetRange("Primary Key", '1');
        if GenLedgerSetup.Find('-') then begin
            IF "No." = '' THEN BEGIN
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Staff Claim No");
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Parttimers Expense Account");
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Parttime payee code");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Staff Claim No", xRec."No. Series", 0D, "No.", "No. Series");
            END;
            "Expense AC" := GenLedgerSetup."Parttimers Expense Account";
            "Payee Code" := GenLedgerSetup."Parttime payee code";
            GLAcc.Reset();
            GLAcc.SetRange("No.", "Expense AC");
            if GLAcc.Find('-') then
                "Expense Ac Name" := GLAcc.Name;

            tcodes.Reset();
            tcodes.SetRange(Code, "Payee Code");
            if tcodes.Find('-') then begin
                "Payee AC" := tcodes."G/L Account";
                "Payee Rates" := tcodes.Percentage;
            end;

            Date := TODAY;
            Cashier := USERID;
            VALIDATE(Cashier);
        end;

    end;

    var
        tcodes: record "FIN-Tariff Codes";
        CStatus: Code[20];
        UserTemplate: Record "FIN-Cash Office User Template";
        GLAcc: Record "G/L Account";
        HRMempD: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Cash Office Setup";

        DimVal: Record "Dimension Value";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        ImpLines: Record "FIN-Imprest Lines";

    var
        Approvalmgt: Codeunit "Init Code";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';

        RecPayTypes: Record "FIN-Receipts and Payment Types";
        TarriffCodes: Record "FIN-Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Temp: Record "FIN-Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "50110";
        Post: Boolean;

        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record "FIN-Committment";
        UserMgt: Codeunit "User Setup Management";
        JournlPosted: Codeunit "Journal Post Successful";

        GenSetup: Record "General Ledger Setup";
        checkAmount: Decimal;
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        Payments: Record "Parttime Claim Header";
        PettyCashLine: Record "Parttime Claim Lines";
        EFTHeader: Record "EFT Batch Header";
        EFTline: Record "EFT batch Lines";



    procedure CommitBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin

        BCSetup.GET;
        //IF NOT ((BCSetup.Mandatory) AND (BCSetup."PV Budget Mandatory")) THEN EXIT;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Global Dimension 2 Code");
        //Get Current Lines to loop through
        // Check if budget exists
        Rec.TESTFIELD("Expense AC");
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", "Expense AC");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec."Global Dimension 2 Code");
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        FINBudgetEntries.RESET;
        FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
        FINBudgetEntries.SETRANGE("G/L Account No.", "Expense AC");
        FINBudgetEntries.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense,
         FINBudgetEntries."Transaction Type"::Commitment, FINBudgetEntries."Transaction Type"::Allocation);
        FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec.Date));
        IF FINBudgetEntries.FIND('-') THEN BEGIN
            IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                IF FINBudgetEntries.Amount > 0 THEN BEGIN
                    IF ("Payment Amount" > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                    PostBudgetEnties.CheckBudgetAvailability("Expense AC", Rec.Date, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code",
                    "Payment Amount", "Expense Ac Name", 'PartTime', Rec."No." + "Expense AC", Rec.Payee);
                END ELSE
                    ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
            END;
        END ELSE
            IF PostBudgetEnties.checkBudgetControl("Expense AC") THEN
                ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
    END;


    procedure ExpenseBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        //IF NOT ((BCSetup.Mandatory) AND (BCSetup."PV Budget Mandatory")) THEN EXIT;
        IF NOT ((BCSetup.Mandatory)) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        // Expense Budget Here
        TESTFIELD("Expense AC");
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", "Expense AC");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec."Global Dimension 1 Code");
        //DimensionValue.SETRANGE("Global Dimension No.", 2);
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        IF ("Payment Amount" > 0) THEN BEGIN
            PostBudgetEnties.ExpenseBudget("Expense AC", Rec.Date, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code",
            "Payment Amount", "Expense Ac Name", USERID, TODAY, 'PartTime', Rec."No." + "Expense AC", Payee);
        END;
    END;

    procedure CancelCommitment()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT (BCSetup.Mandatory) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Global Dimension 2 Code");
        //Get Current Lines to loop through
        // Expense Budget Here
        TESTFIELD("Expense AC");
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", "Expense AC");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec."Global Dimension 2 Code");
        DimensionValue.SETRANGE("Global Dimension No.", 2);
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        IF ("Payment Amount" > 0) THEN BEGIN
            // Commit Budget Here
            PostBudgetEnties.CancelBudgetCommitment("Expense AC", Rec.Date, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code",
            "Payment Amount", "Expense Ac Name", USERID, 'PartTime', Rec."No." + "Expense AC", Rec.Payee);
        END;
    END;

    procedure checkBudgetControl(var glAcc: Code[20]) IsBudgetControlled: Boolean
    var
        GLAccount: Record "G/L Account";
    begin
        CLEAR(IsBudgetControlled);
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", glAcc);
        IF GLAccount.FIND('-') THEN;
        IF GLAccount."Budget Controlled" THEN;
        IsBudgetControlled := GLAccount."Budget Controlled";
        //ELSE ERROR('Missing account');
    end;

    procedure PostClaim()
    var
        payeeAmount: Decimal;
        claimLines: Record "Parttime Claim Lines";
    begin

        if Status <> Status::approved then
            Error('Document not fully approved');
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Payment Release Date");
        Rec.TestField("Payment Amount");

        claimLines.Reset();
        claimLines.SetRange("Document No.", "No.");
        if claimLines.Find('-') then begin
            claimLines.CalcSums(Amount);
            payeeAmount := ("Payment Amount" - ("Payment Amount" * "Payee Rates" / 100));
        end;

        ExpenseBudget();
        Temp.GET(USERID);
        JTemplate := Temp."Claim Template";
        JBatch := Temp."Claim  Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the Claims template is set up in Cash Office Setup');
        END;
        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the Claims batch is set up in the Cash Office Setup')
        END;

        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;
        GenJnlLine.DELETEALL;
        GenJnlLine.RESET;

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;

        //Expense Account
        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";

        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := "Expense AC";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");

        GenJnlLine.Description := COPYSTR('Pay To:' + Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        CALCFIELDS("Payment Amount");
        GenJnlLine.Amount := "Payment Amount";
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

        //Bank Account
        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";

        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := "Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");

        GenJnlLine.Description := COPYSTR('Pay To:' + Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        CALCFIELDS("Payment Amount");
        GenJnlLine.Amount := -("Payment Amount" - payeeAmount);
        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

        //Payee Account
        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";

        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := "Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");

        GenJnlLine.Description := COPYSTR('Pay To:' + Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        CALCFIELDS("Payment Amount");
        GenJnlLine.Amount := -payeeAmount;
        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

        CODEUNIT.RUN(CODEUNIT::"Modified Gen. Jnl.-Post", GenJnlLine);
        Post := JournlPosted.PostedSuccessfully();
        Rec."Date Posted" := TODAY;
        Rec."Time Posted" := TIME;
        Rec."Posted By" := USERID;
        Post := true;
        "Payee Amount" := payeeAmount;
        Rec.Status := Rec.Status::Posted;
        Rec.MODIFY;

    end;

    procedure DeleteEntries()
    var
        header: Record "Parttime Claim Header";
        Approvals: Record "Approval Entry";
        lines: Record "Parttime Claim Lines";
    begin
        if Confirm('Delete this record ?', true) = false then Error('Cancelled');
        if UserId <> 'IKIOKO' then Error('Not Authorised');

        header.Reset();
        header.SetRange("No.", Rec."No.");
        if header.Find('-') then begin
            Approvals.Reset();
            Approvals.SetRange("Document No.", header."No.");
            if Approvals.Find('-') then
                Approvals.DeleteAll();

            lines.Reset();
            lines.SetRange("Document No.", header."No.");
            if lines.Find('-') then
                lines.DeleteAll();

            header.Delete();
        end;

    end;


}
