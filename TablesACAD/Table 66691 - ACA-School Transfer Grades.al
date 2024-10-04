table 66691 "ACA-School Transfer Grades"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Student No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Subject; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Student No")
        {
        }
    }

    fieldgroups
    {
    }
}

