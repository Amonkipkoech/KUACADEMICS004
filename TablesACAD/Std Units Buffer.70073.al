table 70073 "Std Units Buffer"
{

    fields
    {
        field(1; Prog; Code[20])
        {
        }
        field(2; Stage; Code[20])
        {
        }
        field(3; Unit; Code[20])
        {
        }
        field(4; Semester; Code[20])
        {
        }
        field(5; "Reg. Trans. Id"; Code[20])
        {
        }
        field(6; "Stud. No"; Code[20])
        {
        }
        field(7; ENO; Integer)
        {
        }
        field(8; "Academic Year"; Code[20])
        {
        }
        field(9; Remarks; Text[100])
        {
        }
        field(10; Status; Integer)
        {
        }
        field(11; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Prog, Stage, Unit, Semester, "Reg. Trans. Id", "Stud. No", ENO, "Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

