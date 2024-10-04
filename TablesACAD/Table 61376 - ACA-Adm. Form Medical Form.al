table 61376 "ACA-Adm. Form Medical Form"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Admission No."; Code[20])
        {
            Description = 'Stores the admission number of the record in the database';
            TableRelation = "ACA-Adm. Form Header"."Admission No.";
        }
        field(3; "Medical Condition Code"; Code[20])
        {
            Description = 'Stores the code of the medical condition in the database';
            TableRelation = "ACA-Medical Condition".Code;
        }
        field(4; "Medical Condition Name"; Text[30])
        {
            CalcFormula = Lookup("ACA-Medical Condition".Description WHERE(Code = FIELD("Medical Condition Code")));
            Description = 'Stores the name of the medical condition';
            FieldClass = FlowField;
        }
        field(5; Yes; Boolean)
        {
            Description = 'Enables the user to select a medical condition as yes';
        }
        field(6; "Date From"; Date)
        {
            Description = 'Stores when the user was diagnosed';
        }
        field(7; "Date To"; Date)
        {
            Description = 'Stores the end date';
        }
        field(8; Details; Text[200])
        {
            Description = 'Stores any details associated with the same';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Admission No.", "Medical Condition Code")
        {
        }
    }

    fieldgroups
    {
    }
}

