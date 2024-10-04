table 61170 "CAT-Menu Sale Header"
{

    fields
    {
        field(1; "Receipt No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Cashier No"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('IMPREST'));
        }
        field(4; "Customer Type"; Option)
        {
            OptionMembers = ," ",Staff,Department;
        }
        field(5; "Customer No"; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(6; "Customer Name"; Text[30])
        {
        }
        field(7; "Receiving Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(8; Amount; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sales Line".Amount WHERE("Receipt No" = FIELD("Receipt No")));
            FieldClass = FlowField;
        }
        field(9; Department; Code[20])
        {
            TableRelation = "Dimension Value"."Dimension Code" WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(10; "Contact Staff"; Text[30])
        {
        }
        field(11; "Sales Point"; Code[20])
        {
            TableRelation = "CAT-Catering Sale Points".Code;
        }
        field(12; "Paid Amount"; Decimal)
        {
            NotBlank = false;
        }
        field(13; Balance; Decimal)
        {
        }
        field(14; Posted; Boolean)
        {
            InitValue = false;
        }
        field(15; "Cashier Name"; Text[30])
        {
        }
        field(16; "Sales Type"; Option)
        {
            OptionCaption = ' ,Cash,Credit,Prepayment';
            OptionMembers = " ",Cash,Credit,Prepayment;
        }
        field(17; "Prepayment Balance"; Decimal)
        {
            CalcFormula = Sum("CAT-Catering Prepayment Ledger".Amount WHERE("Customer No" = FIELD("Customer No")));
            FieldClass = FlowField;
        }
        field(18; "Last Sc"; Text[100])
        {
        }
        field(19; "Line Amount"; Decimal)
        {
        }
        field(20; "Daily Total Prepayment"; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sale Header"."Line Amount" WHERE("Cashier Name" = FIELD("Cashier Name"),
                                                                          Date = FIELD(Date),
                                                                          "Sales Type" = CONST(Prepayment)));
            FieldClass = FlowField;
        }
        field(21; "Daily Total Cash"; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sale Header"."Line Amount" WHERE("Cashier Name" = FIELD("Cashier Name"),
                                                                          Date = FIELD(Date),
                                                                          "Sales Type" = CONST(Cash)));
            FieldClass = FlowField;
        }
        field(22; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(23; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sale Header"."Line Amount" WHERE("Cashier Name" = FIELD("Cashier Name"),
                                                                          Date = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(24; "Total Prepayment"; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sale Header"."Line Amount" WHERE("Cashier Name" = FIELD("Cashier Name"),
                                                                          Date = FIELD("Date Filter"),
                                                                          "Sales Type" = CONST(Prepayment)));
            FieldClass = FlowField;
        }
        field(25; "Total Cash"; Decimal)
        {
            CalcFormula = Sum("CAT-Menu Sale Header"."Line Amount" WHERE("Cashier Name" = FIELD("Cashier Name"),
                                                                          Date = FIELD("Date Filter"),
                                                                          "Sales Type" = CONST(Cash)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Receipt No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN
            ERROR('You cannot delete a posted transaction');
    end;

    trigger OnInsert()
    begin
        "Last No" := '';
        "No Series".RESET;
        SalesSetUp.FINDLAST();
        "No Series".SETRANGE("No Series"."Series Code", SalesSetUp."Receipt No");
        IF "No Series".FIND('-') THEN BEGIN
            "Last No" := "No Series"."Last No. Used";
            "No Series"."Last No. Used" := INCSTR("No Series"."Last No. Used");
            "No Series".MODIFY;
        END;

        "Receipt No" := "Last No";//INCSTR("Last No");
        Date := TODAY;
        "Cashier No" := xRec."Cashier No";
        "Receiving Bank" := xRec."Receiving Bank";
        "Sales Type" := "Sales Type"::Cash;
        "Sales Point" := xRec."Sales Point";
    end;

    trigger OnModify()
    begin
        IF Posted = TRUE THEN
            ERROR('You cannot modify a posted transaction');
    end;

    trigger OnRename()
    begin
        IF Posted = TRUE THEN
            ERROR('You cannot modify a posted transaction');
    end;

    var
        "No Series": Record 309;
        "Last No": Code[20];
        SalesSetUp: Record 61171;
}

