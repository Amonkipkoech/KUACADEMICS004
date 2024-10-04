table 61176 "CAT-Catering Prepayment Ledger"
{
    // DrillDownPageID = 68397;
    // LookupPageID = 68397;

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Customer No"; Code[20])
        {
        }
        field(3; "Entry Type"; Option)
        {
            OptionCaption = ' ,Debit Transfer,Credit Transfer,Consumption';
            OptionMembers = " ","Debit Transfer","Credit Transfer",Consumption;
        }
        field(4; Date; Date)
        {
        }
        field(5; Description; Text[80])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; Reversed; Boolean)
        {
        }
        field(9; "Reversed On"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

