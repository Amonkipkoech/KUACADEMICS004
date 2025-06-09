table 40043 "Student Rota Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[20]) { DataClassification = SystemMetadata; }
        field(2; "Semester"; Text[30]) { }
        field(3; "Academic Year"; Text[20]) { }
        field(4; "Status"; Option)
        {
            OptionMembers = Open,Released;
        }
        field(5; "Current"; Boolean) { }
        field(6; "Created Date"; Date) { }
    }

    keys
    {
        key(PK; "ID") { Clustered = true; }
    }
}

