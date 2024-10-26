table 40009 MasterRotationPlanTest
{
    Caption = 'MasterRotationPlanTest';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No_; Text[400])
        {
            Caption = 'No_';
        }
        field(2; Block; Text[100])
        {
            Caption = 'Block';
        }
        field(3; HOD; Text[100])
        {
            Caption = 'HOD';
        }
        field(4; Department; Text[100])
        {
            Caption = 'Department';
        }
        field(5; Campus; Text[100])
        {
            Caption = 'Campus';
        }
        field(6; StartDate; Date)
        {
            Caption = 'StartDate';
        }
        field(7; EndDate; Date)
        {
            Caption = 'EndDate';
        }
        field(8; TheoryStart; Date)
        {
            Caption = 'TheoryStart';
        }
        field(9; TheoryEnd; Date)
        {
            Caption = 'TheoryEnd';
        }
        field(10; ClinicalsStart; Date)
        {
            Caption = 'ClinicalsStart';
        }
        field(11; ClinicalsEnd; Date)
        {
            Caption = 'ClinicalsEnd';
        }
        field(12; ExaminationsStart; Date)
        {
            Caption = 'ExaminationsStart';
        }
        field(13; ExaminationsEnd; Date)
        {
            Caption = 'ExaminationsEnd';
        }
    }
    keys
    {
        key(PK; No_, Block, Department)
        {
            Clustered = true;
        }
    }
}
