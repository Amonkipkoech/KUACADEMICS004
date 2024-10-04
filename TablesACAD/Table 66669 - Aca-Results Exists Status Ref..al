table 66669 "Aca-Results Exists Status Ref."
{

    fields
    {
        field(1; "CAT Exists"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Exam Exists"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Results Exists Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
    }

    keys
    {
        key(Key1; "CAT Exists", "Exam Exists")
        {
        }
    }

    fieldgroups
    {
    }
}

