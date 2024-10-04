table 61580 "ACA-Exam Preq Checklist"
{
    //LookupPageID = 69132;

    fields
    {
        field(1; Prerequisite; Code[150])
        {
            Editable = true;
        }
        field(2; Description; Text[150])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1; Prerequisite)
        {
        }
    }

    fieldgroups
    {
    }
}

