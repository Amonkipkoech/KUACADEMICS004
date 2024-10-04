table 61779 "CAT-Meal Booking Lines"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Booking Id"; Code[10])
        {
        }
        field(3; "Meal Code"; Code[20])
        {
            TableRelation = Item."No." WHERE("Item Category Code" = FILTER('FOOD'));

            trigger OnValidate()
            begin
                mealHeader.GET("Booking Id");
                Quantity := mealHeader.Pax;
                VALIDATE(Quantity);
                Department := mealHeader.Department;
                // CALCFIELDS(Price,"Meal Name");
                IF items.GET(Rec."Meal Code") THEN
                    "Unit Price" := items."Unit Price";
                VALIDATE(Quantity);
            end;
        }
        field(4; "Meal Name"; Text[250])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
        field(5; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                // CALCFIELDS("Unit Price");
                Cost := Quantity * "Unit Price";
            end;
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; Cost; Decimal)
        {
        }
        field(8; Remarks; Text[50])
        {
        }
        field(9; Price; Decimal)
        {
            CalcFormula = Lookup("CAT-Meals Setup".Price WHERE(Code = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
        field(10; Commited; Boolean)
        {
        }
        field(11; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
    }

    keys
    {
        key(Key1; "Line No.", "Booking Id")
        {
        }
        key(Key2; "Booking Id")
        {
            SumIndexFields = Cost;
        }
    }

    fieldgroups
    {
    }

    var
        mealHeader: Record 61778;
        items: Record 27;
}

