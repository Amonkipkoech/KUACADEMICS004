table 61362 "ACA-Applic. Form Academic"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Application No."; Code[20])
        {
        }
        field(3; "Subject Code"; Code[20])
        {
            TableRelation = "ACA-Applic. Setup Subjects".Code;
        }
        field(4; Subject; Text[30])
        {
        }
        field(5; "Min Grade"; Code[20])
        {
        }
        field(6; Grade; Code[20])
        {
            TableRelation = "ACA-Applic. Setup Grade".Code;
        }
        field(7; Points; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application No.")
        {
        }
    }

    fieldgroups
    {
    }
}

