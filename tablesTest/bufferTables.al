table 85222 "finBuffer1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entryNo; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Posting Date"; date)
        {

        }
        field(3; "Document No"; Code[20])
        {

        }
        field(4; "gl account"; code[20])
        {

        }
        field(5; "Description"; text[100])
        {

        }
        field(6; Campus; code[20])
        {

        }
        field(7; department; code[20])
        {

        }
        field(8; Amount; Decimal)
        {

        }
        field(9; "Bal Account Type"; code[20])
        {

        }
        field(10; "New Gl"; Code[20])
        {

        }
        field(11; "Balancing Acc"; Code[20])
        {

        }
    }

    keys
    {
        key(Key1; entryNo)
        {
            Clustered = true;
        }
    }

    var
        buffTable: Record finBuffer;
        glEntry: Record "G/L Entry";
        custLedger: Record "Cust. Ledger Entry";
        detCustledger: Record "Detailed Cust. Ledg. Entry";




}