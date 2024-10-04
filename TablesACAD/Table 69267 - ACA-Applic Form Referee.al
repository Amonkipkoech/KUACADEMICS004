table 69267 "ACA-Applic Form Referee"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; ApplicationNo; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Title; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Phone No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Fax; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Email; Text[150])
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

