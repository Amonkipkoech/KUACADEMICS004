table 61164 "ACA-Room Inventory"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Type No"; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) Item."No."
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                IF Type = Type::Item THEN BEGIN
                    IF Itm.GET("Type No") THEN
                        Description := Itm.Description;
                END ELSE BEGIN
                    IF FA.GET("Type No") THEN
                        Description := FA.Description;
                END;
            end;
        }
        field(3; Description; Text[60])
        {
        }
        field(4; Units; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(5; Quantity; Decimal)
        {
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; "Total Cost"; Decimal)
        {
        }
        field(8; Remarks; Text[60])
        {
        }
        field(9; "Space No"; Code[20])
        {
        }
        field(10; "Item Charges"; Decimal)
        {
        }
        field(11; Type; Option)
        {
            OptionCaption = 'Item,Fixed Asset';
            OptionMembers = Item,"Fixed Asset";
        }
    }

    keys
    {
        key(Key1; "Line No", "Space No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record "Fixed Asset";
        Itm: Record "Item";
}

