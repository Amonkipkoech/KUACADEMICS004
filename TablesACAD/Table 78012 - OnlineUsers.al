table 40002 OnlineUsers
{

    fields
    {
        field(1; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "ID No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Male,Female;
        }
        field(4; "Phone No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Password; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; SessionID; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Confirmed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; DoB; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; County; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Single,Married';
            OptionMembers = Single,Married;
        }
        field(14; Nationality; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Postal Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Email Address")
        {
        }
    }

    fieldgroups
    {
    }
}

