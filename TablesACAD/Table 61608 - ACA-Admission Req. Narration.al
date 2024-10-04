table 61608 "ACA-Admission Req. Narration"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Programme Code"; Code[20])
        {
        }
        field(3; "Admission Req. Narration"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Programme Code")
        {
        }
    }

    fieldgroups
    {
    }
}

