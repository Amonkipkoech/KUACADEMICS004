table 40019 "ACA-XYForm Lines"
{
    Caption = 'ACA-XYForm Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "XY-FormID"; Text[10])
        {
            Caption = 'XY-FormID';
        }
        field(2; "Student No_"; Text[100])
        {
            Caption = 'Student No_';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Area"; Text[100])
        {
            Caption = 'Area';
        }
        field(5; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(6; "Duration"; Text[20])
        {
            Caption = 'Duration';
        }
        field(7; "Instructor Id"; Text[100])
        {
            Caption = 'Instructor Id';
        }
        field(8; "Instructor name"; Text[50])
        {
            Caption = 'Instructor name';
        }
        field(9; "Instructor Date"; Date)
        {
            Caption = 'Instructor Date';
        }
        field(10; Block; Text[20])
        {
            Caption = 'Block';
        }
    }
    keys
    {
        key(PK; "XY-FormID", "Student No_", "Instructor Id")
        {
            Clustered = true;
        }
    }
}
