table 40007 "Master Rotation Table"

{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan ID"; Code[20]) // Foreign key to "Master Rotation Table"
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Semester"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Block Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Block Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Block End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Clinical Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Clinical End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Block1,Block2;
        }
        field(11; "HoD Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Department"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Email"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Phone Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Program Code"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Program Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(18; "Block"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Block One","Block Two";
        }
        field(19; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Start Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }
        field(22; "End Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }
        field(23; "Number of Weeks"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Plan ID", "Year", "Semester", "Block Number")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Plan ID" = '' THEN BEGIN
            GeneralSetup.Get();

            GeneralSetup.TESTFIELD(GeneralSetup."Clearance Nos");
            NoSerMng.InitSeries(GeneralSetup."Clearance Nos", xRec."No. Series", 0D, "Plan ID", "No. Series");
        END;
    end;
}