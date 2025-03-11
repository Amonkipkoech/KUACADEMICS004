table 40014 "ACA-Exam Attendance"
{
    Caption = 'ACA-Exam Attendance';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Attendance ID"; Text[100])
        {
            Caption = 'Attendance ID';
        }
        field(2; StudentNo; Text[100])
        {
            Caption = 'StudentNo';
        }
        field(3; "Unit Code"; Text[20])
        {
            Caption = 'Unit Code';
        }
        field(4; Venue; Text[20])
        {
            Caption = 'Venue';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; Attended; Boolean)
        {
            Caption = 'Attended';
        }
        field(7; LecturerID; Text[20])
        {
            Caption = 'LecturerID';
        }
        field(8; "Lecturer Name"; Text[100])
        {
            Caption = 'Lecturer Name';
        }
    }
    keys
    {
        key(PK; "Attendance ID",StudentNo,"Unit Code")
        {
            Clustered = true;
        }
    }
}
