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
            TableRelation = GroupAssignments.GroupId;
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
            TableRelation = Lab."Area cODE";
        }

        field(9; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the number series in the database';
        }
        field(10; Block; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Block Name';
        }
        field(11; "Assessment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Start Date';
        }
        field(12; "Assessment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment End Date';
        }
        field(13; "Assessment Score"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Score';
        }
        field(14; "Pass Mark"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Assessment Score';
        }
        field(15; Passed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Is Assessment Passed';
        }
        field(16; "Master Plan No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Master Plan Number';
        }
        field(17; "Lecturer No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Number';
        }
        field(18; "Lecturer Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Lecturer Name';
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
