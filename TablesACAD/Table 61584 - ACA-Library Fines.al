table 61584 "ACA-Library Fines"
{

    fields
    {
        field(1; "Patron Number"; Integer)
        {
        }
        field(2; "Account Number"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; FineID; Integer)
        {
        }
        field(6; description; Text[250])
        {
        }
        field(7; No; Code[20])
        {
        }
        field(8; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Patron Number")
        {
        }
    }

    fieldgroups
    {
    }
}

