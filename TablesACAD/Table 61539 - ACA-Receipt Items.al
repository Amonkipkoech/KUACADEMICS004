table 61539 "ACA-Receipt Items"
{
    // DrillDownPageID = 67065;
    // LookupPageID = 67065;

    fields
    {
        field(1; "Receipt No"; Code[20])
        {
            TableRelation = "ACA-Receipt"."Student No.";
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Description; Text[120])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; Date; Date)
        {
        }
        field(7; Programme; Code[20])
        {
        }
        field(8; Stage; Code[20])
        {
        }
        field(9; Unit; Code[20])
        {
        }
        field(10; Semester; Code[20])
        {
        }
        field(11; "Settlement Type"; Code[30])
        {
        }
        field(12; "Transaction ID"; Code[20])
        {
        }
        field(13; "Student No."; Code[20])
        {
        }
        field(14; "Amount P"; Decimal)
        {
        }
        field(15; "Uniq No."; Integer)
        {
        }
        field(16; "Uniq No 2"; Integer)
        {
        }
        field(17; Campus; Code[20])
        {
        }
        field(18; Course; Code[20])
        {
        }
        field(19; Posted; Boolean)
        {
        }
        field(20; Upposted; Boolean)
        {
        }
        field(21; "Reg. No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Receipt No", "Uniq No 2", "Transaction ID", Description)
        {
            SumIndexFields = Amount;
        }
        key(Key2; Description)
        {
        }
        key(Key3; Programme, Date)
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Transaction ID", "Student No.", Date, Upposted)
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Reg. No", "Student No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

