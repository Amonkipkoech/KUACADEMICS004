table 40017 "XY form Lines"
{
    Caption = 'XY form Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; XyId; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(4; "Rotation Area"; Code[20])
        {
            Caption = 'Rotation Area';
            TableRelation = Lab."Area cODE";
        }
        field(5; "Unit   Coverage"; Code[50])
        {
            Caption = 'Unit Description Covered';
        }
        field(6; "Form Id"; Code[50])
        {
            Caption = 'Unit Description Covered';
            TableRelation = "ACA-XY-FORM"."Form Id";
        }
        field(7; "Duration Hours"; Code[50])
        {
            Caption = 'Duration Hours';

        }

    }
    keys
    {
        key(PK; XyId, "Form Id")
        {
            Clustered = true;
        }
    }
}
