table 61373 "ACA-Adm. Form Next of Kin"
{

    fields
    {
        field(1; "Line no."; Integer)
        {
            AutoIncrement = true;
            Description = 'Stores the unique identifier of the line in the database';
        }
        field(2; "Admission No."; Code[20])
        {
            Description = 'Stores the admisison number in the database';
            TableRelation = "ACA-Adm. Form Header"."Admission No.";
        }
        field(3; Relationship; Code[20])
        {
            Description = 'Stores the relationship in the database';
            TableRelation = Relative.Code;
        }
        field(4; "Full Name"; Text[30])
        {
            Description = 'Stores the full name of the relative in the database';
        }
        field(5; "Address 1"; Text[30])
        {
            Description = 'Stores the first address line in the database';
        }
        field(6; "Address 2"; Text[30])
        {
            Description = 'Stores the second address line in  the database';
        }
        field(7; "Address 3"; Text[30])
        {
            Description = 'Stores the third address line in the database';
        }
        field(8; "Telephone No. 1"; Text[30])
        {
            Description = 'Stores the first telephone no. in the database';
        }
        field(9; "Telephone No. 2"; Text[30])
        {
            Description = 'Stores the second telephone number in the database';
        }
    }

    keys
    {
        key(Key1; "Line no.", "Admission No.")
        {
        }
    }

    fieldgroups
    {
    }
}

