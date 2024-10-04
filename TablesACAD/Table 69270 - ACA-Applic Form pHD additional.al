table 69270 "ACA-Applic Form pHD additional"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Application No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; MastersType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Coursework and Thesis,Coursework and Project,Coursework Only';
            OptionMembers = ,"Coursework and Thesis","Coursework and Project","Coursework Only";
        }
        field(4; "Masters thesis Title"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Masters Project Title"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Concept Paper"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

