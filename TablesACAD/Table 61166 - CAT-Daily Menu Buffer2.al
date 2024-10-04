table 61166 "CAT-Daily Menu Buffer2"
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
        field(4; Quantity; Decimal)
        {
        }
        field(5; Units; Code[20])
        {
        }
        field(6; "Unit Cost"; Decimal)
        {
        }
        field(7; "Total Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

