table 61165 "ACA-Students Rooms"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Student No"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('STUDENT'));
        }
        field(3; Current; Boolean)
        {
        }
        field(4; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Ledger"."Room No";
        }
        field(5; "Starting Date"; Date)
        {
        }
        field(6; "End Date"; Date)
        {
        }
        field(7; Cost; Decimal)
        {
        }
        field(8; "Receipt No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
        key(Key2; "Student No")
        {
        }
        key(Key3; "Room No")
        {
        }
    }

    fieldgroups
    {
    }
}

