table 61569 "ACA-Grading System Setup1"
{
    // DrillDownPageID = 67010;
    // LookupPageID = 67010;

    fields
    {
        field(1; Category; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(2; Grade; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Up to"; Decimal)
        {
        }
        field(5; Remarks; Text[150])
        {
        }
        field(6; Failed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Category, "Up to")
        {
        }
    }

    fieldgroups
    {
    }
}

