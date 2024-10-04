table 86662 "Cust Ledger Test"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "customer No"; Code[10])
        {

        }
        field(2; "Document No"; Code[20])
        {

        }
        field(3; "Date"; Date)

        {

        }
        field(4; Amount; Decimal)
        {

        }
        field(5; "Acc No"; code[20])
        {

        }
        field(6; Description; Text[200])
        {

        }
        field(7; "Enry No"; integer)
        {

        }
        field(8; "Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("customer No")));
            FieldClass = FlowField;
        }
        field(9; "Count 2"; Integer)
        {
            CalcFormula = count("Detailed Cust. Ledg. Entry" where("Customer No." = field("customer No")));
            FieldClass = FlowField;
        }
        field(10; "Count 3"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Bal. Account No." = field("customer No")));
            FieldClass = FlowField;
        }
        field(11; "Count 4"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("Bal. Account No." = field("customer No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Enry No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}