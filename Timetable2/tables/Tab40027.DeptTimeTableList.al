table 40027 "Dept TimeTable List "
{
    Caption = 'Dept TimeTable List ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
        }
        field(2; "Session Year"; Code[50])
        {
            Caption = 'Session';
        }
        field(3; "Department "; Code[50])
        {
            Caption = 'Academic Year';
        }
    }
    keys
    {
        key(PK; "Academic Year")
        {
            Clustered = true;
        }
    }
}
