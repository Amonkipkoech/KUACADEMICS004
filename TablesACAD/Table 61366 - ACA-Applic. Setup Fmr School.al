table 61366 "ACA-Applic. Setup Fmr School"
{
    LookupPageID = 68479;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Stores the code of the former school in the database';
        }
        field(2; Description; Text[90])
        {
            Description = 'Stores the description of the school in the database';
        }
        field(3; "Contact person"; Text[30])
        {
            Description = 'Stores the name of the contact person of the institution';
        }
        field(4; "Address 1"; Text[30])
        {
        }
        field(5; "Address 2"; Text[30])
        {
        }
        field(6; "Address 3"; Text[30])
        {
        }
        field(7; "Telephone No."; Text[30])
        {
        }
        field(8; "Fax Number"; Text[30])
        {
        }
        field(9; "Email Address"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

