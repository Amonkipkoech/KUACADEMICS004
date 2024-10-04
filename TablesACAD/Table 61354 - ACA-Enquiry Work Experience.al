table 61354 "ACA-Enquiry Work Experience"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Description = 'Stores the reference code of the enquiry in the database';
        }
        field(2; Employer; Text[100])
        {
            Description = 'Stores the name of the employer in the database';
        }
        field(3; Position; Text[100])
        {
            Description = 'Stores the position of the employee in the database';
        }
        field(4; Duration; Text[100])
        {
            Description = 'Stores the duration of the employee in the database';
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", Employer, Position)
        {
        }
    }

    fieldgroups
    {
    }
}

