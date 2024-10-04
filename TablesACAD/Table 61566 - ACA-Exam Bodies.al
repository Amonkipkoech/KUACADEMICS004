/// <summary>
/// Table ACA-Exam Bodies (ID 61566).
/// </summary>
table 61566 "ACA-Exam Bodies"
{
    //LookupPageID = 68107;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Remark; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

