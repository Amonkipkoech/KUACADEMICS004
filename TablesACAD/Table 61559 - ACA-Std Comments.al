table 61559 "ACA-Std Comments"
{
    // LookupPageID = 68209;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; Date; Date)
        {
            NotBlank = true;
        }
        field(6; Remarks; Text[200])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Student No.", Date)
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

