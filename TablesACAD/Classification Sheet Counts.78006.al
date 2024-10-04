/// <summary>
/// Table Classification Sheet Counts (ID 78006).
/// </summary>
table 78006 "Classification Sheet Counts"
{

    fields
    {
        field(1; "Grad. Academic Year"; Code[20])
        {
        }
        field(2; "Graduation Group"; Code[20])
        {
        }
        field(4; "Programme Code"; Code[20])
        {
        }
        field(5; "Programme Option"; Code[20])
        {
        }
        field(6; "Prog. Option Name"; Text[150])
        {
            CalcFormula = Lookup("ACA-Programme Options".Desription WHERE("Programme Code" = FIELD("Programme Code"),
                                                                           Code = FIELD("Programme Option")));
            FieldClass = FlowField;
        }
        field(7; "Student No."; Code[20])
        {
        }
        field(8; Counts; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Grad. Academic Year", "Graduation Group", "Programme Code", "Programme Option", "Student No.")
        {
            Clustered = true;
        }
        key(Key2; "Graduation Group")
        {
        }
        key(Key3; "Programme Code")
        {
        }
        key(Key4; "Programme Option")
        {
        }
        key(Key5; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

