table 61630 "ACA-Hostel Inventory"
{
    DrillDownPageID = 68935;
    LookupPageID = 68935;

    fields
    {
        field(1; Item; Code[30])
        {
            TableRelation = Item."No.";
        }
        field(2; Description; Text[150])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD(Item)));
            FieldClass = FlowField;
        }
        field(3; "Quantity Per Room"; Integer)
        {

            trigger OnValidate()
            begin
                "Bill Total" := "Fine Amount" * "Quantity Per Room";
            end;
        }
        field(4; "Applies To"; Option)
        {
            OptionCaption = 'Individual,Room';
            OptionMembers = Individual,Room;
        }
        field(5; "Hostel Gender"; Option)
        {
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(6; "Fine Amount"; Decimal)
        {
        }
        field(7; "Bill Total"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bill Total" := "Fine Amount" * "Quantity Per Room";
                MODIFY;
            end;
        }
        field(8; "All Rooms"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Item)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Quantity Per Room" := 1;
    end;

    trigger OnModify()
    begin
        VALIDATE("Fine Amount");
    end;
}

