table 69266 "ACA-Consolidated Mks Units Reg"
{

    fields
    {
        field(1; Serial; Integer)
        {
        }
        field(2; "Year of Study"; Code[20])
        {
        }
        field(3; Programme; Code[20])
        {
        }
        field(4; Option; Code[20])
        {
        }
        field(5; "Academic Year"; Code[20])
        {
        }
        field(6; "Unit Code 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit Description 1"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Description 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit Code 3"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Unit Description 3"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Serial, "Year of Study", Programme, Option, "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

