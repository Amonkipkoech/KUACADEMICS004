/// <summary>
/// Table ACA-Applicants Employ. History (ID 61341).
/// </summary>
table 61341 "ACA-Applicants Employ. History"
{
    //LookupPageID = 68209;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; From; Date)
        {
            NotBlank = true;
        }
        field(3; "To"; Date)
        {
            NotBlank = true;
        }
        field(4; "Company Name"; Text[150])
        {
            NotBlank = true;
        }
        field(5; "Postal Address"; Text[40])
        {
        }
        field(6; "Address 2"; Text[40])
        {
        }
        field(7; "Job Title"; Text[150])
        {
        }
        field(8; "Key Experience"; Text[150])
        {
        }
        field(9; "Salary On Leaving"; Decimal)
        {
        }
        field(10; "Reason For Leaving"; Text[150])
        {
        }
        field(16; Comment; Text[200])
        {
            Editable = false;
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "No.", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HRM-Employee (D)";
        OK: Boolean;
}

