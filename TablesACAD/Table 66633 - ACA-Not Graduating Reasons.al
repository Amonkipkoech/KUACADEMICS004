table 66633 "ACA-Not Graduating Reasons"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Graduation Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Reason Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Graduation Academic Year", "Reason Code")
        {
        }
    }

    fieldgroups
    {
    }
}

