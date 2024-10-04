tableextension 86607 "Detailed Cust ledgers" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {

        field(5000; "Count 2"; Integer)
        {

            CalcFormula = count("Cust Ledger Test" where("customer No" = FIELD("Customer No.")));
            fieldclass = flowfield;

        }
    }

}
