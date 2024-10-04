table 61788 "CAT-Cafe_Meal Ledger Entries"
{
    // DrillDownPageID = 69081;
    // LookupPageID = 69081;

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
            OptionCaption = ' ,Positive Adjustment,Negative Adjustment,Staff Cafe Sales,Students Cafe Sales,Non-Food Stuff Sales,Clear Left Overs';
            OptionMembers = " ","Positive Adjustment","Negative Adjustment","Staff Cafe Sales","Students Cafe Sales","Non-Food Stuff Sales","Clear Left Overs";
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "User Id"; Code[150])
        {
        }
        field(9; "Line No."; Integer)
        {
        }
        field(13; "Cafeteria Section"; Option)
        {
            OptionCaption = ' ,Students,Staff';
            OptionMembers = " ",Students,Staff;
        }
        field(14; "Unit Price"; Decimal)
        {
        }
        field(15; "Line Amount"; Decimal)
        {
        }
        field(16; Source; Option)
        {
            OptionCaption = ' ,Sales,Cancellation';
            OptionMembers = " ",Sales,Cancellation;
        }
        field(17; "Sale Tyle"; Option)
        {
            OptionCaption = ' ,Cash Sale,Credit Sale,Advance Payment';
            OptionMembers = " ","Cash Sale","Credit Sale","Advance Payment";
        }
        field(18; "Receipt No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Template, Batch, "Meal Code", "Posting Date", "Line No.", "Cafeteria Section", "Receipt No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        cafeLedgerEntries.RESET;
        IF cafeLedgerEntries.FIND('-') THEN
            "Line No." := GETRANGEMAX("Line No.") + 100
        ELSE
            "Line No." := 100;
        "User Id" := USERID;
    end;

    var
        cafeLedgerEntries: Record 61788;
}

