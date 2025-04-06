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
        field(2; "Area cODE"; Code[50])
        {
            Caption = 'Area Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Lab Name"; Text[100])
        {
            Caption = 'Area Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Capacity"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Lab ID", "Area cODE")
        {
            Clustered = true;
        }
    }
}

