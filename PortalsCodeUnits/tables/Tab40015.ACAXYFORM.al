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
        field(2; StudentNo; Code[20])
        {
            Caption = 'StudentNo';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                rec."Student Name" := cust.Name;
            end;
        }
        field(3; UnitCode; Text[20])
        {
            Caption = 'UnitCode';
            TableRelation = "ACA-Units/Subjects".Code;
            trigger OnValidate()
            var
                unit: Record "ACA-Units/Subjects";
            begin
                rec."Unit Description" := unit.Desription;
            end;
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
            TableRelation = "ACA-Academic Year".Code;
        }
        field(15; Program; Text[10])
        {
            Caption = 'Programme';
        }
        field(16; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; StudentName; Code[20])
        {
            Caption = 'StudentName';

        }
        field(18; UnitName; Code[20])
        {
            Caption = 'Unit Name';

        }
        field(19; Group; Code[20])
        {
            Caption = 'Group Number';
            TableRelation = GroupAssignments.GroupId;
            trigger OnValidate()
            var
                GpA: Record GroupAssignments;
            begin
                rec.LecturerNo := GpA.LecturerNo;
            end;
        }
        field(20; "Group Name"; Code[20])
        {
            Caption = 'Group Name';
            TableRelation = GroupAssignments.GroupId;
        }
        field(21; "Rotation Arears"; Code[20])
        {
            Caption = 'Rotation Arears';
            TableRelation = Lab."Area cODE";
        }
        field(22; "Status"; Option)
        {
            OptionMembers = " ",Open,Pending,Approved,Rejected;
        }
        field(23; "Block"; Code[20])
        {

            Caption = 'Semester';
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
