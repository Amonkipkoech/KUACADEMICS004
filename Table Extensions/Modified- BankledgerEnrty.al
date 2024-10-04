tableextension 86608 "Bank entry" extends "Bank Account Ledger Entry"
{
    fields
    {

        field(5000; exist; Boolean)
        {

            CalcFormula = exist(finBuffer1 where("Posting Date" = field("Posting Date"), "Document No" = field("Document No.")));
            fieldclass = flowfield;

        }
        field(5001; accountNo; code[20])
        {

            CalcFormula = lookup("G/L Entry"."G/L Account No." where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."), Amount = field(Amount)));
            fieldclass = flowfield;

        }

    }

}
