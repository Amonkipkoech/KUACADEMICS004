table 66655 "ACA-My Academic Years"
{

    fields
    {
        field(1; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User ID", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

