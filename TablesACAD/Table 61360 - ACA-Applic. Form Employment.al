table 61360 "ACA-Applic. Form Employment"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Application No."; Code[20])
        {
        }
        field(3; Organisation; Text[30])
        {
        }
        field(4; "Job Title"; Text[30])
        {
        }
        field(5; From; Date)
        {
        }
        field(6; "To date"; Date)
        {
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

