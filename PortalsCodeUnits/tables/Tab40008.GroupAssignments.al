table 40008 GroupAssignments
{
    Caption = 'GroupAssignments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; GroupId; Code[100])
        {
            Caption = 'GroupId';
        }
        field(2; Block; Text[100])
        {
            Caption = 'Block';
        }
        field(3; StudentNo; Text[100])
        {
            Caption = 'StudentNo_';
        }
        field(4; StartDate; Date)
        {
            Caption = 'StartDate';
        }
        field(5; EndDate; Date)
        {
            Caption = 'EndDate';
        }
        field(6; Department; Text[200])
        {
            Caption = 'Department';
        }

        field(7; MasterRotationNo; Text[400])
        {
            Caption = 'Master Rotation Number';
        }
        field(8; Viewed; Boolean)
        {
            Caption = 'Notification Viewed';
        }
        field(9; LecturerNo; Code[100])
        {
            Caption = 'Lecturer Number';
        }
        field(10; LecturerName; Code[100])
        {
            Caption = 'Lecturer Name';
        }
        field(11; Category; Option)
        {
            OptionMembers = " ",Internal,External;
        }
    }
    keys
    {
        key(PK; GroupId, Block, StudentNo)
        {
            Clustered = true;
        }
    }
}
