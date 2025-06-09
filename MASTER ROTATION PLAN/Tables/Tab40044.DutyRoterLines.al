table 40044 "Student Rota Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(2; "Header ID"; Code[20]) { TableRelation = "Student Rota Header".ID; }
        field(3; "Student Name"; Text[100]) { }
        field(4; "Institution"; Code[10]) { }
        field(5; "Program"; Code[10]) { }
        field(6; "Ward"; Text[30]) { }
        field(7; "Date"; Date) { }
        field(8; "Shift Code"; Option)
        {
            OptionMembers = D,N,OFF,WC;
        }
        field(9; "Viewable"; Boolean) { Editable = false; }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(HeaderDateStudent; "Header ID", "Date", "Student Name") { }
    }
}
