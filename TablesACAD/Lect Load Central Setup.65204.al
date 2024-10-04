table 65204 "Lect Load Central Setup"
{
    DrillDownPageID = 65204;
    LookupPageID = 65204;

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Customer Group,Sub-Group';
            OptionMembers = "Customer Group","Sub-Group";
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Part-Time Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Part-Time Expenses Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Payment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "FIN-Receipts and Payment Types".Code WHERE (Type=FILTER(Payment));
        }
        field(87; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
    }

    keys
    {
        key(Key1; Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

