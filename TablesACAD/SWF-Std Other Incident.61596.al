/// <summary>
/// Table SWF-Std Other Incident SF (ID 61596).
/// </summary>
table 61596 "SWF-Std Other Incident SF"
{

    fields
    {
        field(1; "Student No"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; "Incident Date"; Date)
        {
        }
        field(4; "Incident Case"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Student No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

