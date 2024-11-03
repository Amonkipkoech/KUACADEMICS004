table 40017 "Refund Request"

{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Request Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Requested Refund Amount (KSHS)';
        }
        field(4; "Reason for Refund"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Relationship"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Refund Mode"; Option)
        {
            OptionMembers = "Bank","MPESA";
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Bank Branch"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Mobile Money No."; Code[15])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile Money Number (MPESA)';
        }
        field(12; "Signature Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Receipt Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Net Due for Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Staff Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Staff Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "HOD Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "HOD Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "HOD Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Checked By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Checked Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Reviewed By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Reviewed Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Authorized By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Authorized Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "ID No.")
        {
            Clustered = true;
        }
    }
}

