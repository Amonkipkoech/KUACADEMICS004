table 86010 "Student Clerance"
{
    Caption = 'Student Clerance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Clearance No"; Code[20])
        {
            Caption = 'Clearance No';
        }
        field(2; "Student No"; Code[20])
        {
            Caption = 'Student No';
            TableRelation = Customer;
        }
        field(3; "Student Name "; Text[200])
        {
            Caption = 'Student Name ';
        }
        field(4; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('DEPARTMENT'));
        }
        field(5; School; Code[20])
        {
            Caption = 'School';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = const('FACULTY'));
        }
        field(6; "Mobile No"; Text[13])
        {
            Caption = 'Mobile No';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,Pending,Approved,Cancelled,Posted;
        }
        field(8; "Graduation Fee Paid"; Boolean)
        {
        }
        field(9; "Department Cleared"; Boolean)
        {
            trigger OnValidate()
            var

            begin
                "HoD Name" := UserId;
            end;
        }
        field(10; "  Department Clearance Remarks"; Text[200])
        {
        }
        field(29; "HoD Name"; Code[30])
        {
        }
        field(41; "Library Name"; Code[30])
        {
        }
        field(42; "Library Cleared&"; Boolean)
        {
            trigger OnValidate()
            var

            begin
                "Library Name" := UserId;
            end;
        }
        field(43; "library Clearance Remarks"; Text[200])
        {
        }
        field(44; "Finance Name"; Code[30])
        {
        }
        field(45; "Finance Cleared&"; Boolean)
        {
            trigger OnValidate()
            var

            begin
                "Finance Name" := UserId;
            end;
        }

        field(47; "Ict Name"; Code[30])
        {
        }
        field(48; "ICT Cleared"; Boolean)
        {
            trigger OnValidate()
            var

            begin
                "Ict Name" := UserId;
            end;
        }
        field(49; "Ict  Clearance Remarks"; Text[200])
        {
        }
        field(50; "Head of Institute Name"; Code[30])
        {
        }
        field(51; "Head of InstituteCleared"; Boolean)
        {
            trigger OnValidate()
            var

            begin
                "Head of Institute Name" := UserId;
            end;
        }
        field(46; "Head of Institute remarks"; Text[200])
        {

        }



        field(11; "School Cleared"; Boolean)
        {

        }
        field(12; "School Cleared Name"; Text[200])
        {

        }
        field(13; "Library"; Boolean)
        {

        }
        field(14; "Library Cleared Name"; Text[200])
        {

        }
        field(15; "Library Cleared"; Boolean)
        {

        }
        field(16; "Accomodation Cleared Name"; Text[200])
        {

        }
        field(17; "Sports and games"; Boolean)
        {

        }
        field(18; "Sports and Games Cleared Name"; Text[200])
        {

        }
        field(19; "Dean of Students"; Boolean)
        {

        }
        field(20; "Dean of Students Name"; text[200])
        {

        }
        field(21; "UESA Cleared"; Boolean)
        {

        }
        field(22; "UESA Cleared Name"; Text[200])
        {

        }
        field(23; "Student ID Card Returned"; Boolean)
        {
            trigger OnValidate()
            begin
                "Staff Collecting ID" := UserId;
                "ID Return Date" := Today;
            end;
        }
        field(24; "Staff Collecting ID"; Code[20])
        {

        }
        field(25; "ID Return Date"; Date)
        {
        }
        field(26; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Clearance No", "Student No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Clearance No" = '' THEN BEGIN
            GeneralSetup.Get();

            GeneralSetup.TESTFIELD(GeneralSetup."Clearance Nos");
            NoSerMng.InitSeries(GeneralSetup."Clearance Nos", xRec."No. Series", 0D, "Clearance No", "No. Series");
        END;
    end;

}
