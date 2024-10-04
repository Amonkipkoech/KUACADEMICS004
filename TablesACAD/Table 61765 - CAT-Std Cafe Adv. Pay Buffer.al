table 61765 "CAT-Std Cafe Adv. Pay Buffer"
{

    fields
    {
        field(1; "Student No."; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(2; "Receipt Date"; Date)
        {
            CalcFormula = Lookup("ACA-Receipt".Date WHERE("Student No." = FIELD("Student No."),
                                                         "Receipt No." = FIELD("Receipt Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Receipt Amount"; Decimal)
        {
            CalcFormula = Lookup("ACA-Receipt".Amount WHERE("Student No." = FIELD("Student No."),
                                                           "Receipt No." = FIELD("Receipt Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Cafe Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Cafe Amount" > "Receipt Amount" THEN
                    ERROR('The Cafe amount cannot be greater than the receipt amount.');

                IF "Cafe Amount" = "Receipt Amount" THEN
                    IF CONFIRM('Transfer all receipt amount to cafeteria?', FALSE) = FALSE THEN
                        ERROR('Transaction Cancelled by user...');
            end;
        }
        field(5; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Receipt Number"; Code[20])
        {
            Editable = true;
            TableRelation = "ACA-Receipt"."Receipt No." WHERE("Student No." = FIELD("Student No."));
        }
        field(7; "Receipt By"; Code[20])
        {
            CalcFormula = Lookup("ACA-Receipt"."User ID" WHERE("Student No." = FIELD("Student No."),
                                                              "Receipt No." = FIELD("Receipt Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(9; "Captured By"; Code[20])
        {
            Editable = false;
        }
        field(10; "Posted By"; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Receipt Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN ERROR('You cannot delete a posted receipt.');
    end;

    trigger OnInsert()
    begin
        "Captured By" := USERID;
    end;

    trigger OnModify()
    begin
        IF Posted = TRUE THEN ERROR('You cannot modify a posted receipt.');
    end;
}

