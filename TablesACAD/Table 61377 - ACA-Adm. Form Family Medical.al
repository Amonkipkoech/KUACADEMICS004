table 61377 "ACA-Adm. Form Family Medical"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Description = 'Stores the line number in the database';
        }
        field(2; "Medical Condition Code"; Code[20])
        {
            Description = 'Stores the medical condition code in the database';
            TableRelation = "ACA-Medical Condition".Code;
        }
        field(3; "Medical Condition Name"; Text[30])
        {
            CalcFormula = Lookup("ACA-Medical Condition".Description WHERE(Code = FIELD("Medical Condition Code")));
            Description = 'Stores the name of the medical condition in the database';
            FieldClass = FlowField;
        }
        field(4; Yes; Boolean)
        {
            Description = 'Stores the state of the medical condition';
        }
        field(5; Remarks; Text[200])
        {
            Description = 'Stores any remarks the user might make';
        }
        field(6; "Admission No."; Code[20])
        {
            Description = 'Stores the reference to the admission no n the database';
            TableRelation = "ACA-Adm. Form Header"."Admission No.";
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

