table 54282 "License Applications"
{
    Caption = 'License Applications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
        }
        field(2; "Applicant Name"; Text[100])
        {
            Caption = 'Applicant Name';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
    }
    keys
    {
        key(PK; "Application ID")
        {
            Clustered = true;
        }
    }
}
