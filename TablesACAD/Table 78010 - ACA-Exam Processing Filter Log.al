table 78010 "ACA-Exam Processing Filter Log"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Programme Code"; Code[250])
        {
        }
        field(3; "Semester Code"; Code[250])
        {
        }
        field(4; "Graduation Year"; Code[250])
        {
        }
        field(5; "School Filters"; Code[250])
        {
            DataClassification = ToBeClassified;
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

