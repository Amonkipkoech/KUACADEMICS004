table 40036 "Rotation Area Wards"
{
    Caption = 'Rotation Area Wards';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Ward Code"; Code[20])
        {
            Caption = 'Ward Code';
        }
        field(2; "Ward Name"; Code[46])
        {
            Caption = 'Ward Name';
        }
        field(3; Capacity; Integer)
        {
            Caption = 'Capacity';
        }
        field(4; "Rotation Area "; Code[20])
        {
            Caption = 'Rotation Area ';
            TableRelation = Lab."Area cODE";
        }
    }
    keys
    {
        key(PK; "Ward Code")
        {
            Clustered = true;
        }
    }
}
