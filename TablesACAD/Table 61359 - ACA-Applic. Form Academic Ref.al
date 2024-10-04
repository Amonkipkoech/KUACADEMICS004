table 61359 "ACA-Applic. Form Academic Ref"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Description = 'Stores the running number of the records in the database';
        }
        field(2; "Application No."; Code[20])
        {
            Description = 'Stores the reference of the application in the database';
        }
        field(3; Name; Text[50])
        {
            Description = 'Stores the name of the academic referees in the database';
        }
        field(4; Title; Text[30])
        {
            Description = 'Stores the title of the academic referee in the database';
        }
        field(5; Address; Text[100])
        {
            Description = 'Stores the address of the academic referee in the database';
        }
        field(6; "Telephone No."; Text[30])
        {
            Description = 'Stores the telephone number of the academic referee in the database';
        }
        field(7; "Fax No."; Text[30])
        {
            Description = 'Stores the fax number of the academic referee in the database';
        }
        field(8; Email; Text[30])
        {
            Description = 'Stores the email address of the referee in the database';
        }
        field(9; "Next Of Kin Relationship"; code[20])
        {
            Description = 'Stores the nature of relationship to next of kin';
            NotBlank = true;
            TableRelation = Relative.Code;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application No.")
        {
        }
    }

    fieldgroups
    {
    }
}

