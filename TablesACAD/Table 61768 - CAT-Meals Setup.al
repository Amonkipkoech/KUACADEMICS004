table 61768 "CAT-Meals Setup"
{
    DataCaptionFields = "Code", Discription;
    // DrillDownPageID = 69080;
    // LookupPageID = 69080;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Discription; Text[250])
        {
        }
        field(3; Category; Option)
        {
            OptionCaption = 'Main Dishes,Snacks,Breakfast,Function,Non-food';
            OptionMembers = "Main Dishes",Snacks,Breakfast,"Function","Non-food";
        }
        field(4; "Food Value"; Option)
        {
            OptionMembers = Vitamin,Proteins,Cabohydrates;
        }
        field(5; Price; Decimal)
        {
        }
        field(6; Type; Option)
        {
            OptionCaption = 'Cafeteria,Meal Booking,Sales';
            OptionMembers = Cafeteria,"Meal Booking",Sales;
        }
        field(7; "Line No"; Integer)
        {
            AutoIncrement = false;
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; "Total Quantity"; Integer)
        {
            CalcFormula = Count("CAT-Cafeteria Receipts Line" WHERE("Meal Code" = FIELD(Code),
                                                                     Date = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(12; "Total Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafeteria Receipts Line"."Total Amount" WHERE("Meal Code" = FIELD(Code),
                                                                                  Date = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(13; Active; Boolean)
        {
        }
        field(15; "Total Credits"; Decimal)
        {
        }
        field(16; "Total Debits"; Decimal)
        {
        }
        field(17; "Exclude in Summary"; Boolean)
        {
        }
        field(18; "Cash Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafeteria Receipts Line"."Total Amount" WHERE("Meal Code" = FIELD(Code),
                                                                                  Date = FIELD("Date Filter"),
                                                                                  "Transaction Type" = FILTER(<> 'ADVANCE PAYMENT')));
            FieldClass = FlowField;
        }
        field(19; "Advance Sales"; Decimal)
        {
            CalcFormula = Sum("CAT-Cafeteria Receipts Line"."Total Amount" WHERE("Meal Code" = FIELD(Code),
                                                                                  Date = FIELD("Date Filter"),
                                                                                  "Transaction Type" = FILTER(= 'ADVANCE PAYMENT')));
            FieldClass = FlowField;
        }
        field(20; "Recipe Cost"; Decimal)
        {
            // CalcFormula = Sum("Meals Recipe"."Final Cost" WHERE ("Meal Code"=FIELD(Code)));
            // FieldClass = FlowField;
        }
        field(21; "Recipe Price"; Decimal)
        {
            // CalcFormula = Sum("Meals Recipe"."Final Price" WHERE ("Meal Code"=FIELD(Code)));
            // FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        mealJournEntries.RESET;
        mealJournEntries.SETRANGE(mealJournEntries."Meal Code", Code);
        IF mealJournEntries.FIND('-') THEN BEGIN
            IF Code <> xRec.Code THEN
                ERROR('The Meal Cannot be Renamed since it contains entries');
        END;
    end;

    trigger OnInsert()
    begin
        Active := TRUE;
    end;

    trigger OnModify()
    begin
        mealJournEntries.RESET;
        mealJournEntries.SETRANGE(mealJournEntries."Meal Code", Code);
        IF mealJournEntries.FIND('-') THEN BEGIN
            IF Code <> xRec.Code THEN
                ERROR('The Meal Cannot be Renamed since it contains entries');
        END;
    end;

    trigger OnRename()
    begin
        mealJournEntries.RESET;
        mealJournEntries.SETRANGE(mealJournEntries."Meal Code", Code);
        IF mealJournEntries.FIND('-') THEN BEGIN
            IF Code <> xRec.Code THEN
                ERROR('The Meal Cannot be Renamed since it contains entries');
        END;
    end;

    var
        mealsdet: Record 61775;
        mealJournEntries: Record 61787;
}

