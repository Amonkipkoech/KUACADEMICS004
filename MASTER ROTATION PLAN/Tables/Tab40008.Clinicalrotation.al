table 40010 "Clinical rotation"

{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan ID';
            Editable = false; // Set to false as it will be auto-generated
        }

        field(2; "Week No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; Group; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Rotation Group"."Group ID";
        }

        field(4; "Month"; Option)
        {
            OptionMembers = "January","February","March","April","May","June","July","August","September","October","November","December";
        }

        field(5; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Department; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; Areas; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Lab."Lab ID";
        }

        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the number series in the database';
        }

        // Add additional fields as needed
    }

    keys
    {
        key(PK; "Plan ID")
        {
            Clustered = true;
        }
    }





    var
        FixedAsset: Record "Fixed Asset";
}
