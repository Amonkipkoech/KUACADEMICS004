table 40029 "PesaFlow Integration"
{
    Caption = 'PesaFlow Integration';
    DrillDownPageId = "PesaFlow Integration";
    LookupPageId = "PesaFlow Integration";


    fields
    {
        field(1; "PaymentRefID"; Code[50])
        {
            Caption = 'Payment Ref ID';
        }
        field(2; "CustomerRefNo"; Code[20])
        {
            Caption = 'Customer Ref No';
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(4; "InvoiceNo"; Code[20])
        {
            Caption = 'Invoice No';
        }
        field(5; "InvoiceAmount"; Decimal)
        {
            Caption = 'Invoice Amount';
        }
        field(6; "PaidAmount"; Decimal)
        {
            Caption = 'Paid Amount';
        }
        field(7; "ServiceID"; Code[20])
        {
            Caption = 'Service ID';
        }
        field(8; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "PaymentChannel"; Text[50])
        {
            Caption = 'Payment Channel';
        }
        field(10; "PaymentDate"; Text[50])
        {
            Caption = 'Payment Date';
        }
        field(11; "Status"; Text[50])
        {
            Caption = 'Status';
        }
        field(12; "Posted"; Boolean)
        {
            Caption = 'Posted';
        }
        field(13; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
    }
    keys
    {
        key(PK; "PaymentRefID")
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // var
    //     PaymentProcessor: Codeunit "KU Payment Processor";
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     Recipients: List of [Text];
    //     StudentRec: Record Customer; // Replace with 'Student' if you use a custom student table
    //     GenJournalLine: Record "Gen. Journal Line";
    //     GenJnlTemplateName: Code[10];
    //     GenJnlBatchName: Code[10];
    //     NextLineNo: Integer;
    // begin
    //     PaymentProcessor.ProcessPayment(
    //                      Rec.PaymentRefID,
    //                      Rec.CustomerRefNo,
    //                      Rec.PaidAmount,
    //                      Rec."Customer Name",
    //                      'BNK002' // ← Bank Account No.
    //                  );
    //     // Get student email using CustomerRefNo (assumed as Customer No.)
    //     if StudentRec.Get(Rec.CustomerRefNo) then begin
    //         if StudentRec."E-Mail" <> '' then begin
    //             Recipients.Add(StudentRec."E-Mail");
    //             EmailMessage.Create(
    //                 Recipients,
    //                 'Payment Received',
    //                 StrSubstNo('Dear %1, we have received your payment of %2. Kindly check your clearance status.', StudentRec.Name, Format(Rec.PaidAmount)),
    //                 true
    //             );
    //             if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
    //                 Message('Failed to send email to %1', StudentRec."E-Mail");
    //         end;
    //     end;

    //     // Mark as posted
    //     Rec.Posted := true;
    // end;



}

