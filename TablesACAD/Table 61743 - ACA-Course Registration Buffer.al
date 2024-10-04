table 61743 "ACA-Course Registration Buffer"
{

    fields
    {
        field(1; Programme; Code[50])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Student No."; Code[20])
        {
        }
        field(3; "Student Name"; Text[250])
        {
        }
        field(4; "Academic Year"; Code[10])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(5; "Settlement Type"; Code[10])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(6; "Student Type"; Code[20])
        {
        }
        field(7; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(8; Stage; Code[10])
        {
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(9; Session; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; Rejected; Boolean)
        {
        }
        field(12; "Reject Reason"; Text[250])
        {
        }
        field(13; "Reg. Trans. No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Reg. Trans. No.")
        {
        }
    }

    fieldgroups
    {
    }
}

