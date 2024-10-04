table 61385 "ACA-Programme Subject Grade"
{

    fields
    {
        field(1; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Subject Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Applic. Setup Subjects".Code;
        }
        field(3; "Subject Name"; Text[100])
        {
            CalcFormula = Lookup("ACA-Applic. Setup Subjects".Description WHERE(Code = FIELD("Subject Code")));
            Editable = false;
            FieldClass = FlowField;
            NotBlank = true;
        }
        field(4; "Mean Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Applic. Setup Grade".Code;
        }
    }

    keys
    {
        key(Key1; Programme, "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }
}

