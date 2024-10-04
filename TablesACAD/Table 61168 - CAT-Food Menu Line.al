table 61168 "CAT-Food Menu Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Menu; Code[20])
        {
        }
        field(3; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(4; Description; Text[30])
        {
        }
        field(5; Units; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "Unit Cost"; Decimal)
        {
        }
        field(7; "Total Cost"; Decimal)
        {
        }
        field(8; Quantity; Decimal)
        {
        }
        field(9; Type; Option)
        {
            OptionMembers = " ",Student,Staff;
        }
        field(10; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; Menu, "Line No", Type)
        {
            SumIndexFields = "Total Cost";
        }
    }

    fieldgroups
    {
    }
}

