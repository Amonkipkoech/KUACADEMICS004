table 66610 "ACA-Graduation Report Picker"
{

    fields
    {
        field(1; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reports to view"; Option)
        {
            OptionCaption = ' ,Classification List,Graduation List,Classification Marksheet,All Reports';
            OptionMembers = " ","Classification List","Graduation List","Classification Marksheet","All Reports";
        }
        field(7; "Graduation Academic Year"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(8; Faculty; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Department; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Programme; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme".Code;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

