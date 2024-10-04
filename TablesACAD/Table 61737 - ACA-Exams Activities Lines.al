table 61737 "ACA-Exams Activities Lines"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Activity; Code[50])
        {
        }
        field(4; "Max duration"; Text[100])
        {
        }
        field(5; "Time Line"; Text[100])
        {
        }
        field(6; "Action Office"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

