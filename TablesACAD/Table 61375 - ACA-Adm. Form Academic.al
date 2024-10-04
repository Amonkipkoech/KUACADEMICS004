table 61375 "ACA-Adm. Form Academic"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Description = 'Stores the line no in the database';
        }
        field(2; "Admission No."; Code[20])
        {
            Description = 'Stores the admission number in the database';
            TableRelation = "ACA-Adm. Form Header"."Admission No.";
        }
        field(3; "Subject Code"; Code[20])
        {
            Description = 'Stores the code of the subject in the database';
            TableRelation = "ACA-Applic. Setup Subjects".Code;
        }
        field(4; Subject; Text[30])
        {
            CalcFormula = Lookup("ACA-Applic. Setup Subjects".Description WHERE(Code = FIELD("Subject Code")));
            Description = 'Stores the name of the subject in the database';
            FieldClass = FlowField;
        }
        field(5; Grade; Code[20])
        {
            Description = 'Stores the code of the grade in the database';
            TableRelation = "ACA-Applic. Setup Grade".Code;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Admission No.")
        {
        }
    }

    fieldgroups
    {
    }
}

