table 40027 "Dept TimeTable List "
{
    Caption = 'Dept TimeTable List ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Semesters".Code;
        }
        field(2; "Session Year"; Code[50])
        {
            Caption = 'Session';
            TableRelation = "ACA-Semesters".Code;
        }
        field(3; "Department "; Code[50])
        {
            Caption = 'Department';
            TableRelation = "Dimension Value".Code;
        }
    }
    keys
    {
        key(PK; "Academic Year", "Session Year", "Department ")
        {
            Clustered = true;
        }
    }
}
