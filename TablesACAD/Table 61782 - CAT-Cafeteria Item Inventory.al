table 61782 "CAT-Cafeteria Item Inventory"
{
    // DrillDownPageID = 69094;
    // LookupPageID = 69094;

    fields
    {
        field(2; "Item No"; Code[20])
        {
            TableRelation = "CAT-Meals Setup".Code;
        }
        field(3; "Item Description"; Text[250])
        {
            CalcFormula = Lookup("CAT-Meals Setup".Discription WHERE(Code = FIELD("Item No")));
            FieldClass = FlowField;
        }
        field(4; Category; Option)
        {
            OptionCaption = 'Main Dishes,Snacks,Breakfast,Function,Non-food';
            OptionMembers = "Main Dishes",Snacks,Breakfast,"Function","Non-food";
        }
        field(5; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "For Sale"; Boolean)
        {
        }
        field(7; "Quantity Per Unit"; Decimal)
        {
        }
        field(8; "Price Per Item"; Decimal)
        {
        }
        field(9; "Quantity in Store"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafe_Meal Ledger Entries".Quantity WHERE("Meal Code" = FIELD("Item No"),
                                                                             "Posting Date" = FIELD("Menu Date"),
                                                                             "Cafeteria Section" = FIELD("Cafeteria Section")));
            FieldClass = FlowField;
        }
        field(10; "Re-Order Quantity"; Decimal)
        {
        }
        field(11; "Delay Cost on Return"; Decimal)
        {
        }
        field(12; "Menu Date"; Date)
        {
        }
        field(13; "Cafeteria Section"; Option)
        {
            OptionCaption = ' ,Students,Staff';
            OptionMembers = " ",Students,Staff;
        }
        field(14; "Cash Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafe_Meal Ledger Entries"."Line Amount" WHERE("Meal Code" = FIELD("Item No"),
                                                                                  "Posting Date" = FIELD("Menu Date"),
                                                                                  "Cafeteria Section" = FIELD("Cafeteria Section"),
                                                                                  "Sale Tyle" = FILTER("Cash Sale")));
            FieldClass = FlowField;
        }
        field(15; "Credit Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafe_Meal Ledger Entries"."Line Amount" WHERE("Meal Code" = FIELD("Item No"),
                                                                                  "Posting Date" = FIELD("Menu Date"),
                                                                                  "Cafeteria Section" = FIELD("Cafeteria Section"),
                                                                                  "Sale Tyle" = FILTER("Credit Sale")));
            FieldClass = FlowField;
        }
        field(16; "Advance Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafe_Meal Ledger Entries"."Line Amount" WHERE("Meal Code" = FIELD("Item No"),
                                                                                  "Posting Date" = FIELD("Menu Date"),
                                                                                  "Cafeteria Section" = FIELD("Cafeteria Section"),
                                                                                  "Sale Tyle" = FILTER("Advance Payment")));
            FieldClass = FlowField;
        }
        field(17; "Quantity Sold"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafe_Meal Ledger Entries".Quantity WHERE("Meal Code" = FIELD("Item No"),
                                                                             "Posting Date" = FIELD("Menu Date"),
                                                                             "Cafeteria Section" = FIELD("Cafeteria Section")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No", "Cafeteria Section", "Menu Date")
        {
        }
    }

    fieldgroups
    {
    }
}

