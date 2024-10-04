table 61171 "CAT-Catering SetUp"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
            MaxValue = 1;
        }
        field(2; "Receipt No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Receiving Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(4; "Sales Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(5; "Sales Batch"; Code[20])
        {
        }
        field(6; "Menu No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Catering Income Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Catering Control Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EXIT;
    end;

    trigger OnInsert()
    begin
        EXIT;
    end;
}

