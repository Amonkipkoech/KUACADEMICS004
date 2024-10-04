table 54418 "KCB-Integeration Validation"
{

    fields
    {
        field(1; "Validation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Validation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Response"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Test,Live';
            OptionMembers = " ",Test,Live;
        }
    }

    keys
    {
        key(Key1; "Validation Time", "Validation Date", "Student No.", "Transaction Response")
        {
        }
    }

    fieldgroups
    {
    }
}

