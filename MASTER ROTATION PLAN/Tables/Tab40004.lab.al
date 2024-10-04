table 40004 "Lab"
{
    Caption = 'Lab';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Lab ID"; Integer)
        {
            Caption = 'Lab ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Lab Name"; Text[100])
        {
            Caption = 'Lab Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Lab ID")
        {
            Clustered = true;
        }
    }
}

