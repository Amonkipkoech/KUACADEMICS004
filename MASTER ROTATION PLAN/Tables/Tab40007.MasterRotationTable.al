table 40007 "Master Rotation Table"

{
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
        }


        field(3; "Department"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "School"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Phone Number"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Email"; Text[50])
        {
            DataClassification = ToBeClassified;
            // You can add validation to ensure it matches Employee list
        }

        // Program Information
        field(7; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Program Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // Theoretical Classes

        field(9; "Block Name"; Text[50])
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

        field(15; "Category"; Option)
        {
            OptionMembers = "Block One","Block Two";
        }
        field(16; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Theory StartDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Theory EndDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Clinical StartDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Clinical EndDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Exams StartDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Exams EndDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "HOD"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Status"; Option)
        {
            OptionMembers = " ",Open,"Pending Approval",Approved,"Rejected";
        }

        field(25; Yr1sem1Block1StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Yr1sem1block1EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Yr1sem1clinicStart; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Yr1sem1clinicEnd; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(29; Yr1sem1Block2StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Yr1sem1block2EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Yr1sem1clinic2Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Yr1sem1clinic2End; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(33; Yr1sem2Block1StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; Yr1sem2block1EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Yr1sem2clinic1Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; Yr1sem2clinic1End; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(37; Yr1sem2Block2StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Yr1sem2block2EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; Yr1sem2clinic2Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Yr1sem2clinic2End; Date)
        {
            DataClassification = ToBeClassified;

        }


        field(41; Yr2sem1Block1StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; Yr2sem1block1EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; Yr2sem1clinic1Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; Yr2sem1clinic1End; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; Yr2sem1Block2StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; Yr2sem1block2EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(47; Yr2sem1clinic2Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(48; Yr2sem1clinic2End; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(49; Yr2sem2Block1StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Yr2sem2block1EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51; Yr2sem2clinic1Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(52; Yr2sem2clinic1End; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(53; Yr2sem2Block2StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Yr2sem2block2EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55; Yr2sem2clinic2Start; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56; Yr2sem2clinic2End; Date)
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

