table 61627 "ACA-Hostel Reservation Lines"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
        }
        field(4; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Ledger"."Room No" WHERE("Hostel No" = FIELD("Hostel No"));
        }
        field(5; "Space No"; Code[20])
        {
            TableRelation = "ACA-Hostel Ledger"."Space No" WHERE("Hostel No" = FIELD("Hostel No"),
                                                                  "Room No" = FIELD("Room No"));
        }
    }

    keys
    {
        key(Key1; "Code", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

