table 61501 "ACA-Item Charges"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Deduction Code"; Code[20])
        {
            TableRelation = Employee;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Transfer to Payroll"; Boolean)
        {
        }
        field(7; "Leave Entry No"; Integer)
        {
        }
        field(8; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Leave Entry No", "Entry No")
        {
        }
        key(Key2; "Transfer to Payroll")
        {
        }
    }

    fieldgroups
    {
    }
}

