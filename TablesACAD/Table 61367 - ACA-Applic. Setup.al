table 61367 "ACA-Applic. Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Description = 'Stores the constant key of the table';
        }
        field(2; "Application Form Nos."; Code[20])
        {
            Description = 'Stores the reference to the numbering system of the application form numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(3; "Summary Application Nos."; Code[20])
        {
            Description = 'Stores the reference to the numbering system of the batch numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(4; "Minimum Age"; Integer)
        {
        }
        field(5; "Maximum Age"; Integer)
        {
        }
        field(6; "Admission Letter Signatory Nam"; Text[200])
        {
        }
        field(7; "Admission Letter Sign. Title"; Code[120])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

