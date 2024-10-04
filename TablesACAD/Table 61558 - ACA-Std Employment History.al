table 61558 "ACA-Std Employment History"
{
    //LookupPageID = 68209;

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
        field(4; "Job Title"; Text[150])
        {
            NotBlank = true;
        }
        field(5; "Company/Organization"; Text[150])
        {
        }
        field(6; Remarks; Text[200])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Student No.", From, "To", "Job Title")
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

