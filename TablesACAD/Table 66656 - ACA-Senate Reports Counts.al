table 66656 "ACA-Senate Reports Counts"
{

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Counts; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student Number")
        {
        }
    }

    fieldgroups
    {
    }
}

