table 61775 "CAT-Cafeteria Receipts Line"
{
    // DrillDownPageID = 69089;
    // LinkedObject = false;
    // LookupPageID = 69089;

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Receipt No."; Code[20])
        {
            TableRelation = "CAT-Cafeteria Receipts"."Receipt No.";
        }
        field(3; "Meal Code"; Code[20])
        {
            TableRelation = "CAT-Food Menu".Code;

            trigger OnValidate()
            begin

                Quantity := 1;
            end;
        }
        field(4; "Meal Descption"; Text[250])
        {
            CalcFormula = Lookup("CAT-Meals Setup".Discription WHERE(Code = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
        field(5; Quantity; Integer)
        {

            trigger OnValidate()
            begin

                "Total Amount" := Quantity * "Unit Price";
                CALCFIELDS(Price);
                rects.RESET;
                rects.SETRANGE(rects."Doc. No.", "Receipt No.");
                IF rects.FIND('-') THEN BEGIN
                    "Cafeteria Section" := rects."Cafeteria Section";
                END;
                CALCFIELDS(Price);
                MealInvent.RESET;
                MealInvent.SETRANGE(MealInvent."Item No", "Meal Code");
                MealInvent.SETRANGE(MealInvent."Cafeteria Section", "Cafeteria Section");
                MealInvent.SETFILTER(MealInvent."Menu Date", '=%1', Rec.Date);
                IF MealInvent.FIND('-') THEN BEGIN
                    MealInvent.CALCFIELDS(MealInvent."Quantity in Store");
                    IF Quantity > MealInvent."Quantity in Store" THEN
                        ERROR('ERROR: Less quantity on store! ' + FORMAT(MealInvent."Quantity in Store"));
                    "Unit Price" := MealInvent."Price Per Item";
                    "Total Amount" := Quantity * "Unit Price";
                    VALIDATE("Unit Price");
                    MODIFY;
                END ELSE BEGIN
                    ERROR('Item is misssing on Todays menu!');
                    "Unit Price" := 0;
                    "Total Amount" := 0;
                    VALIDATE("Unit Price");
                    MODIFY;
                END;
            end;
        }
        field(6; "Unit Price"; Decimal)
        {
        }
        field(7; "Total Amount"; Decimal)
        {
        }
        field(8; User; Code[20])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; Template; Code[20])
        {
        }
        field(11; Batch; Code[20])
        {
        }
        field(50000; "Transaction Type"; Option)
        {
            OptionMembers = CASH,CREDIT,"ADVANCE PAYMENT";

            trigger OnValidate()
            begin
                // /  "Transaction Types":="Transaction Type";
                //    MODIFY;
            end;
        }
        field(50001; Status; Option)
        {
            CalcFormula = Lookup("CAT-Cafeteria Receipts".Status WHERE("Receipt No." = FIELD("Receipt No.")));
            FieldClass = FlowField;
            OptionCaption = 'New,Printed,Posted,Canceled';
            OptionMembers = New,Printed,Posted,Canceled;
        }
        field(50002; Price; Decimal)
        {
            CalcFormula = Lookup("CAT-Cafeteria Item Inventory"."Price Per Item" WHERE("Item No" = FIELD("Meal Code"),
                                                                                        // "Cafeteria Section"=FIELD("Cafeteria Section"),
                                                                                        "Menu Date" = FIELD(Date)));
            FieldClass = FlowField;
        }
        field(50003; "Customer Type"; Option)
        {
            OptionCaption = ' ,Staff,Student';
            OptionMembers = " ",Staff,Student;
        }
        field(50005; "Cafeteria Section"; Option)
        {
            OptionCaption = ' ,Students,Staff';
            OptionMembers = " ",Students,Staff;
        }
    }

    keys
    {
        key(Key1; "Receipt No.", "Line No.")
        {
            SumIndexFields = "Total Amount";
        }
        key(Key2; "Meal Code", Date, "Transaction Type")
        {
            SumIndexFields = "Total Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        User := USERID;
        Date := TODAY;
        VALIDATE(Date);

        rects.RESET;
        rects.SETRANGE(rects."Receipt No.", "Receipt No.");
        IF rects.FIND('-') THEN BEGIN
            //"Transaction Type":=rects."Transaction Type";
        END;
        // Quantity:=0;
        //  VALIDATE("Transaction Type");
    end;

    trigger OnModify()
    begin
        //  VALIDATE("Transaction Type");
        rects.RESET;
        rects.SETRANGE(rects."Receipt No.", "Receipt No.");
        IF rects.FIND('-') THEN BEGIN
            //"Transaction Type":=rects."Transaction Type";
        END;
    end;

    var
        rects: Record 61783;
        det: Record 61775;
        MealInvent: Record 61782;
}

