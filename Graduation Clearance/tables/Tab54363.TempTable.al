table 86001 "Temp Table"
{
    Caption = 'Temp Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Clearance No"; Code[20])
        {
            Caption = 'Clearance No';
        }
        field(2; "Student No"; Code[20])
        {
            Caption = 'Student No';
            TableRelation = Customer;
        }
        field(3; "Student Name "; Text[200])
        {
            Caption = 'Student Name ';
        }
        field(4; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('DEPARTMENT'));
        }
        field(5; School; Code[20])
        {
            Caption = 'School';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('FACULTY'));
        }
        field(6; "Mobile No"; Text[13])
        {
            Caption = 'Mobile No';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,Pending,Approved,Cancelled,Posted;
        }
        field(8; "Graduation Fee Paid"; Boolean)
        {

        }
        field(9; "Department Cleared"; Boolean)
        {

        }
        field(10; "Department Cleared Name"; Text[200])
        {

        }
        field(11; "School Cleared"; Boolean)
        {

        }
        field(12; "School Cleared Name"; Text[200])
        {

        }
        field(13; "Library"; Boolean)
        {

        }
        field(14; "Library Cleared Name"; Text[200])
        {

        }
        field(15; "Accomodation Cleared"; Boolean)
        {

        }
        field(16; "Accomodation Cleared Name"; Text[200])
        {

        }
        field(17; "Sports and games"; Boolean)
        {

        }
        field(18; "Sports and Games Cleared Name"; Text[200])
        {

        }
        field(19; "Dean of Students"; Boolean)
        {

        }
        field(20; "Dean of Students Name"; text[200])
        {

        }
        field(21; "UESA Cleared"; Boolean)
        {

        }
        field(22; "UESA Cleared Name"; Text[200])
        {

        }
    }
    keys
    {
        key(PK; "Student No")
        {
            Clustered = true;
        }
    }
}
