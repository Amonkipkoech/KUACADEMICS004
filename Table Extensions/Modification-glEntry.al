tableextension 86609 "gl Enry Ext" extends "G/L Entry"
{
    fields
    {

        // field(5000; "Count 2"; Integer)
        // {

        //     CalcFormula = count("Cust Ledger Test" where("customer No" = FIELD("Bal. Account No.")));
        //     fieldclass = flowfield;

        // }
        // field(5001; "Count 4"; Integer)
        // {
        //     CalcFormula = count("G/L Entry" where("Document No." = FIELD("Document No.")));
        //     fieldclass = flowfield;
        // }
        // field(5002; "Count Doc No"; Integer)
        // {
        //     CalcFormula = count("G/L Entry" where("Document No." = field("Document No.")));
        //     FieldClass = flowfield;
        // }
        // field(5003; "Count Date"; Integer)
        // {
        //     CalcFormula = count("G/L Entry" where("Posting Date" = field("Posting Date")));
        //     FieldClass = flowfield;
        // }
        // field(5000; "New Code"; Code[20])
        // {
        //     CalcFormula = lookup("G/L Account"."New Code" where("No." = field("G/L Account No.")));
        //     FieldClass = FlowField;
        // }
        field(5001; todelete; Boolean)
        {

        }
        field(5002; exists; Boolean)
        {
            CalcFormula = exist("G/L Account" where("No." = field("G/L Account No."), "Account Type" = const(Posting)));
            FieldClass = FlowField;
        }
        field(5003; "Bank Acc"; code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("Document No." = field("Document No."), "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(5004; "Exist in Buffer"; Boolean)
        {
            CalcFormula = exist(finBuffer where("Posting Date" = field("Posting Date"), "Document No" = field("Document No."), "gl account" = field("G/L Account No.")));
            FieldClass = FlowField;
        }
        field(5005; "Payment Narration"; text[200])
        {
           
        }
    }

}
