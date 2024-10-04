table 61762 "CAT-Std List With Class Codes"
{

    fields
    {
        field(1; "Course Name"; Code[150])
        {
        }
        field(2; "Course Access Code"; Code[30])
        {
        }
        field(3; "Prog. Code"; Code[30])
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; Department; Code[30])
        {
        }
        field(7; "Student Name"; Text[150])
        {
        }
        field(8; "Reg. No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Reg. No", "Course Access Code")
        {
        }
    }

    fieldgroups
    {
    }
}

