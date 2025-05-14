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
            OptionMembers = Internal,External;
        }
        field(12; "Student Name"; Text[30])
        {
            Caption = 'Student Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD(StudentNo)));
        }
        field(13; "Student Program "; Text[30])
        {
            Caption = 'Student Program';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Course Registration".ProgramName WHERE("Student No." = FIELD(StudentNo)));// 
        }
        field(14; "Student Phone Number"; Text[30])
        {
            Caption = 'Student Phone Number';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Mobile Phone No." WHERE("No." = FIELD(StudentNo)));//ACA-Course Registration 
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
