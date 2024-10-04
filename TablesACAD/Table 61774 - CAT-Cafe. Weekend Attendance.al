table 61774 "CAT-Cafe. Weekend Attendance"
{

    fields
    {
        field(1; "Seq. No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Stud. No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Stud. No.")));
            FieldClass = FlowField;
        }
        field(4; Date; Date)
        {
        }
        field(5; Day; Code[10])
        {
        }
        field(6; Lunch; Boolean)
        {
        }
        field(7; Supper; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Seq. No")
        {
        }
    }

    fieldgroups
    {
    }
}

