table 40039 "Institute Master"
{
    Caption = 'institutions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Institute Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Institute Code';
        }

        field(2; "Institute Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Institute Name';
        }

        field(3; "Contact Email"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Email';
        }

        field(4; "Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Number';
        }
    }

    keys
    {
        key(PK; "Institute Code")
        {
            Clustered = true;
        }
    }
}
