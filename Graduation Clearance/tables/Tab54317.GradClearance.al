table 86006 GradClearance
{
    Caption = 'GradClearance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "Student No."; code[20])
        {

        }
        field(3; "Student Name"; Text[200])
        {

        }
        field(4; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Pending,Approved,Closed,Cancelled,Rejected,Completed,Scheduled;
        }
        field(5; "Gown Issued"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
