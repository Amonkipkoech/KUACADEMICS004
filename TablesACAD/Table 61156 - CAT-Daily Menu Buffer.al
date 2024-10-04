table 61156 "CAT-Daily Menu Buffer"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Item No"; Code[20])
        {
            TableRelation = Item;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Units; Code[20])
        {
        }
        field(5; Quantity; Decimal)
        {
        }
        field(6; "Total Qty"; Decimal)
        {
        }
        field(7; "Unit Cost"; Decimal)
        {
        }
        field(8; "Total Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Item No")
        {
        }
        key(Key2; "Item No")
        {
        }
    }

    fieldgroups
    {
    }
}

