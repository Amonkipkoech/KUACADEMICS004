table 61613 "ACA-Class Setups"
{

    fields
    {
        field(1; "Class Code"; Code[50])
        {
        }
        field(2; "Unit Code"; Code[20])
        {
        }
        field(3; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "Used Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Unit = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(5; "Class Size"; Integer)
        {
        }
        field(6; Lecturer; Code[20])
        {
        }
        field(7; "Day Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Unit = FIELD("Unit Code"),
                                                        "Day of Week" = FIELD("Day Filter")));
            FieldClass = FlowField;
        }
        field(8; "Lesson Count"; Integer)
        {
            CalcFormula = Count("ACA-Time Table" WHERE(Unit = FIELD("Unit Code"),
                                                        "Day of Week" = FIELD("Day Filter"),
                                                        Period = FIELD("Lesson Filter")));
            FieldClass = FlowField;
        }
        field(9; "Day Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(10; "Lesson Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(11; "Unit Programme"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Programme Code" WHERE(Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(12; "Unit Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Stage Code" WHERE(Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Class Code")
        {
        }
    }

    fieldgroups
    {
    }
}

