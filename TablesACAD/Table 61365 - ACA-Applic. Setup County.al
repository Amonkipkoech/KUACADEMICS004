table 61365 "ACA-Applic. Setup County"
{
    LookupPageID = 68477;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the district in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the district''s description in the database';
        }
        field(50000; "No. of Students"; Integer)
        {
            CalcFormula = Count(Customer WHERE(District = FIELD(Code)));
            FieldClass = FlowField;
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

