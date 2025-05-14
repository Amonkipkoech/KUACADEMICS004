table 40038 "Ward Rotation Management"
{
    Caption = 'Ward Rotation Management';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Plan ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        // HoD Information
        field(2; "HoD Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


        field(3; "Department"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(4; "School"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Phone Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(6; "Email"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // You can add validation to ensure it matches Employee list
        }

        // Program Information
        field(7; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme".Code;
            trigger OnValidate()
            var
                pg: Record "ACA-Programme";
            begin
                IF PG.Get("Program Code") then begin
                    "Program Name" := pg.Description;
                    "HoD Name" := pg."Hod Full Name";
                    Email := pg."HoD Email";
                    "Phone Number" := pg."HoD Phone Number";
                    Department := pg."Department Name";
                end;
            end;
        }

        field(8; "Program Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // Theoretical Classes

        field(9; "Block"; enum "Block Category Enum")
        {
            DataClassification = ToBeClassified;


        }

        field(10; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Start Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(12; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "End Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(14; "Number of Weeks"; Integer)
        {
            DataClassification = ToBeClassified;
            // Calculation for weeks between start and end dates can be done in a flow field
        }

        field(15; "Category"; Enum "Block Category Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Year; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(89; Session; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
            trigger OnValidate()
            var
                SEM: Record "ACA-Semesters";
            begin
                IF SEM.Get(Session) then begin
                    Year := SEM."Academic Year";
                end else begin
                    Year := '';
                end;
            end;
        }

        field(19; "HOD"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(21; "Block1 Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Block1 End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Clinical1 Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Clinical1 End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Block2 Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Block2 End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Clinical2 Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Clinical2 End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Exhausted; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(300; Cohort; Code[20]) { }


        field(30; "B2 Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(31; "B2 Start Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(32; " B2 End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "B2 End Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(34; "B2 Number of Weeks"; Integer)
        {
            DataClassification = ToBeClassified;
            // Calculation for weeks between start and end dates can be done in a flow field
        }
        field(35; "Leave Start Date  "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Leave end Date  "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "leave Category"; enum "Block Category Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Leave Period  "; Code[50])
        {
            DataClassification = ToBeClassified;
        }






    }

    keys
    {
        key(PK; "Plan ID")
        {
            Clustered = true;
        }

        key(Key2; HOD)
        {

        }
        key(Key3; Year)
        {

        }
        key(Key4; "Program Code")
        {

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


