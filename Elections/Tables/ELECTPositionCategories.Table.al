table 60003 "ELECT-Position Categories"
{
    DrillDownPageID = 60019;
    LookupPageID = 60019;

    fields
    {
        field(1; "Election Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Category Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Election Code", "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

