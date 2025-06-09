codeunit 40010 "KU Payment Processor"

{
    procedure ProcessPayment(
    BankRef: Code[50];
    CustomerID: Code[20];
    Amount: Decimal;
    DebitCustomerName: Text[100];
    BankAccountCode: Code[20]
)
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJournalTemplateName: Code[10];
        GenJournalBatchName: Code[10];
        NextLineNo: Integer;
    begin
        GenJournalTemplateName := 'GENERAL';
        GenJournalBatchName := 'PAYMENTS';

        // Get next available Line No.
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", GenJournalTemplateName);
        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatchName);
        if GenJournalLine.FindLast() then
            NextLineNo := GenJournalLine."Line No." + 10000
        else
            NextLineNo := 10000;

        // Setup general journal line
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := GenJournalTemplateName;
        GenJournalLine."Journal Batch Name" := GenJournalBatchName;
        GenJournalLine."Line No." := NextLineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := CustomerID;
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Document No." := BankRef;
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Description := 'M-PESA Payment from ' + DebitCustomerName;

        // Setup Bank Account
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"Bank Account";
        GenJournalLine."Bal. Account No." := BankAccountCode;

        GenJournalLine.Insert();

        // Post the journal
        GenJnlPostLine.RunWithCheck(GenJournalLine);

        Message('Payment of %1 for %2 posted to bank %3.', Format(Amount), CustomerID, BankAccountCode);
    end;

}
