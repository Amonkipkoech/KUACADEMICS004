<<<<<<< HEAD:MASTER ROTATION PLAN/Tables/Tab40045.StudentRotarheader.al
table 40045 "Student Rotar header"
{
    Caption = 'Student Rotar header';
=======
table 40043 "Student Rota Header"
{
>>>>>>> 53ad504bfff112e4801953aeff7cee623da2fa7a:MASTER ROTATION PLAN/Tables/Tab40043.DutyRoterHeader.al
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

