/// <summary>
/// Table ELECT-Elections Setup (ID 60013).
/// </summary>
table 60013 "ELECT-Elections Setup"
{

    fields
    {
        field(1; "Current Election"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ELECT-Elections Header"."Election Code";
        }
    }

    keys
    {
        key(Key1; "Current Election")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

