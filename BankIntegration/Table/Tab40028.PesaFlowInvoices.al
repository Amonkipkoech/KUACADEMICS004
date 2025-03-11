table 40028 "PesaFlow Invoices"
{
    Caption = 'PesaFlow Invoices';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BillRefNo"; Code[50])
        {
            Caption = 'Bill Ref No';
        }
        field(2; "InvoiceNo"; Code[50])
        {
            Caption = 'Invoice No';
        }
        field(3; "CustomerRefNo"; Code[50])
        {
            Caption = 'Customer Ref No';
        }
        field(4; "CustomerName"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; "InvoiceAmount"; Decimal)
        {
            Caption = 'Invoice Amount';
        }
        field(6; "ServiceID"; Code[50])
        {
            Caption = 'Service ID';
        }
        field(7; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "TokenHash"; Text[100])
        {
            Caption = 'Token Hash';
        }
        field(9; "InvoiceLink"; Text[150])
        {
            Caption = 'Invoice Link';
        }
    }
    keys
    {
        key(PK; "BillRefNo")
        {
            Clustered = true;
        }
    }
}

