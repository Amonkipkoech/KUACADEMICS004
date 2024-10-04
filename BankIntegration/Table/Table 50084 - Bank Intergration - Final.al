table 54419 "Bank Intergration - Final"
{

    fields
    {
        field(1; bankreference; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; debitaccount; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; transactionDate; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; billAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; paymentMode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; phonenumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; customerRefNumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; debitcustname; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "New Student"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; bankreference, debitaccount, customerRefNumber)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Access denied');
    end;
}

