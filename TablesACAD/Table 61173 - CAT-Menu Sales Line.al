table 61173 "CAT-Menu Sales Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Receipt No"; Code[20])
        {
        }
        field(3; Menu; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                MenuRec.RESET;
                MenuRec.SETRANGE(MenuRec.Menu, Menu);
                IF MenuRec.FIND('-') THEN BEGIN
                    Description := MenuRec.Description;
                    Quantity := 1;
                    "Unit Cost" := MenuRec."Unit Cost";
                    Amount := MenuRec."Unit Cost";
                    // IF MenuRec."Remaining Qty"<1 THEN ERROR('Please note that '+MenuRec.Description+' is out of stock in today menu');
                END;
            end;
        }
        field(4; "Unit Cost"; Decimal)
        {
        }
        field(5; Quantity; Integer)
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Receipt No")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        MenuRec: Record 61169;
}

