table 77700 "ACA-Sttudent ID Print Tracker"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Original Printed Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Printed Date/time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Original Printed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Last Printed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Serial; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

