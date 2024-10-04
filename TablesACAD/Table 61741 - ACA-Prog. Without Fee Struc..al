table 61741 "ACA-Prog. Without Fee Struc."
{

    fields
    {
        field(1; "Prog. Code"; Code[20])
        {
        }
        field(2; Stage; Code[20])
        {
        }
        field(3; "Settlement Type"; Code[20])
        {
        }
        field(4; Semester; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Prog. Code", Stage, "Settlement Type")
        {
        }
    }

    fieldgroups
    {
    }
}

