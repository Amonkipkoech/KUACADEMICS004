table 40035 "Consolidated Exam TimeTable"
{
    Caption = 'Consolidated Exam TimeTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year".Code;
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
        field(4; "Campus"; Code[50])
        {
            Caption = 'Campus';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Status"; Option)
        {
            OptionMembers = Approved;
        }
        field(7; "Status2"; Option)
        {
            OptionMembers = Approved;
        }
        field(6; "HoI Comment"; text[250])
        {

        }
    }
    keys
    {
        key(PK; "Academic Year", "Session Year", "Department ", Status)
        {
            Clustered = true;
        }
    }
}
