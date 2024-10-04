table 61369 "ACA-Applic Form PostGraduate"
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
        field(3; "Other Degrees/Diploma"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Resarch Experience"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Languages; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Other Research Institution"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Source of finance"; Text[150])
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

