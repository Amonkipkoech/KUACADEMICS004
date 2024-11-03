table 40015 "ACA-XY-FORM"
{
    Caption = 'ACA-XY-FORM';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Form Id"; Code[20])
        {
            Caption = 'Form Id';
        }
        field(2; StudentNo; Text[20])
        {
            Caption = 'StudentNo';
        }
        field(3; UnitCode; Text[20])
        {
            Caption = 'UnitCode';
        }
        field(4; "Unit Description"; Text[30])
        {
            Caption = 'Unit Description';
        }
        field(5; LecturerNo; Text[10])
        {
            Caption = 'LecturerNo';
        }
        field(6; "Lecturer Name"; Text[100])
        {
            Caption = 'Lecturer Name';
        }
        field(7; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(8; "Duration"; Text[10])
        {
            Caption = 'Duration';
        }
        field(9; ClassRep; Text[50])
        {
            Caption = 'ClassRep';
        }
        field(10; HoD; Text[50])
        {
            Caption = 'HoD';
        }
        field(11; "Hod Name"; Text[50])
        {
            Caption = 'Hod Name';
        }
        field(12; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
        }
        field(13; Coverage; Text[500])
        {
            Caption = 'Coverage';
        }
        field(14; AcademicYr; Text[10])
        {
            Caption = 'Academic year';
        }
        field(15; Program; Text[10])
        {
            Caption = 'Programme';
        }
        field(16; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Form Id", StudentNo, UnitCode)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Form Id" = '' THEN BEGIN
            GeneralSetup.Get();
            GeneralSetup.TESTFIELD(GeneralSetup."Attachment Nos");
            NoSerMng.InitSeries(GeneralSetup."Attachment Nos", xRec."No. Series", 0D, "Form Id", "No. Series");
        END;
    end;
}
