table 61384 "ACA-Programme Grades"
{

    fields
    {
        field(1; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Programme Name"; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD(Programme)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Mean Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Applic. Setup Grade".Code;
        }
        field(4; "Min Points"; Integer)
        {
            FieldClass = Normal;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; Programme)
        {
        }
    }

    fieldgroups
    {
    }
}

