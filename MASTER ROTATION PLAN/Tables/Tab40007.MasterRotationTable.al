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
    }

    keys
    {
        key(PK; "Plan ID")
        {
            Clustered = true;
        }
    }
}

