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
}

