table 69265 "ACA-Consolidated Mks Counts2"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
        }
        field(2; Serials; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
        key(Key2; Serials)
        {
        }
    }

    fieldgroups
    {
    }
}

