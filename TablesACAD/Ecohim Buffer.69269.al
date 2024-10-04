table 69269 "Ecohim Buffer"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

