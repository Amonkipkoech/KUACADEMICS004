table 61784 "CAT-Waiters"
{
    DrillDownPageID = 68736;
    LookupPageID = 68736;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(3; "Employee Name"; Text[100])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."First Name" WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(4; Position; Code[20])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ' ,Cook,Waiter/Waitress,Cleaner,Laundry';
            OptionMembers = " ",Cook,"Waiter/Waitress",Cleaner,Laundry;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

