table 61529 "ACA-Student Education History"
{
    DrillDownPageID = 68753;
    LookupPageID = 68753;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; From; Date)
        {
            NotBlank = true;
        }
        field(3; "To"; Date)
        {
            NotBlank = true;
        }
        field(4; Qualifications; Text[150])
        {
            NotBlank = true;
        }
        field(5; Instituition; Text[150])
        {
        }
        field(6; Remarks; Text[200])
        {
            Editable = true;
        }
        field(7; "Aggregate Result/Award"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", From, "To", Qualifications)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HRM-Employee (D)";
        OK: Boolean;
}

