table 61378 "ACA-Adm. Form Immunization"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Description = 'Stores the number of the record in the database';
        }
        field(2; "Admission No."; Code[20])
        {
            Description = 'Stores the admission number in the database';
            TableRelation = "ACA-Adm. Form Header"."Admission No.";
        }
        field(3; "Immunization Code"; Code[20])
        {
            Description = 'Stores the reference code of the immunization in the database';
            TableRelation = "ACA-Immunization".Code;
        }
        field(4; "Immunization Name"; Text[30])
        {
            CalcFormula = Lookup("ACA-Immunization".Description WHERE(Code = FIELD("Immunization Code")));
            Description = 'Stores the name of the immunization in the database';
            FieldClass = FlowField;
        }
        field(5; Yes; Boolean)
        {
            Description = 'Stores the state of the immunization in the database';
        }
        field(6; Date; Date)
        {
            Description = 'Stores the date when the immunization was done';
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

