table 61787 "CAT-Cafe Meal Journal Line"
{

    fields
    {
        field(1; Template; Code[20])
        {
        }
        field(2; Batch; Code[20])
        {
        }
        field(3; "Meal Code"; Code[20])
        {
            TableRelation = "CAT-Meals Setup".Code;

            trigger OnValidate()
            begin
                mealsSetup.RESET;
                mealsSetup.SETRANGE(mealsSetup.Code, "Meal Code");
                IF mealsSetup.FIND('-') THEN BEGIN
                    "Unit Price" := mealsSetup.Price;
                END;
            end;
        }
        field(4; "Meal Description"; Text[250])
        {
            CalcFormula = Lookup("CAT-Meals Setup".Discription WHERE(Code = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
        field(5; "Posting Date"; Date)
        {
        }
        field(6; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ","Positive Adjustment","Negative Adjustment";
        }
        field(7; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;
        }
        field(8; "User Id"; Code[150])
        {
        }
        field(9; "Line No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(13; "Cafeteria Section"; Option)
        {
            OptionCaption = ' ,Students,Staff';
            OptionMembers = " ",Students,Staff;
        }
        field(14; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;
        }
        field(15; "Line Amount"; Decimal)
        {
        }
        field(16; Category; Option)
        {
            OptionCaption = 'Main Dishes,Snacks,Breakfast,Function,Non-food';
            OptionMembers = "Main Dishes",Snacks,Breakfast,"Function","Non-food";
        }
    }

    keys
    {
        key(Key1; Template, Batch, "Meal Code", "Posting Date", "Line No.", "Cafeteria Section")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*cafeJournal.RESET;
        cafeJournal.SETFILTER(cafeJournal."Meal Code",'<>%1','');
        IF cafeJournal.GETRANGEMAX(cafeJournal."Line No.")>0 THEN
        "Line No.":=cafeJournal.GETRANGEMAX(cafeJournal."Line No.")+100
        ELSE "Line No.":=100;
        */
        "User Id" := USERID;

    end;

    var
        cafeJournal: Record 61787;
        mealsSetup: Record 61768;
}

