table 86003 "Gown Issuance Ledger"
{
    Caption = 'Gown Issuance Ledger';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Entry Type"; Option)
        {
            OptionMembers = "Positive Adjmt.","Negative Adjmt.";
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; Quantity; Integer)
        {
            Caption = 'Quantity';
            //DecimalPlaces = 0 : 5;
        }
        field(15; "Amount"; Decimal)
        {

        }
        field(16; "User ID"; code[20])
        {

        }
        field(17; studentNo; code[20])
        {

        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;
}
