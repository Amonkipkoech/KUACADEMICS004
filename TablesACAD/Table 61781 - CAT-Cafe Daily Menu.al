table 61781 "CAT-Cafe Daily Menu"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Day; Option)
        {
            OptionMembers = MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY;
        }
        field(3; "Meal Code"; Code[10])
        {
            TableRelation = "CAT-Meals Setup".Code;
        }
        field(4; Price; Decimal)
        {
            CalcFormula = Lookup("CAT-Meals Setup".Price WHERE(Code = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

