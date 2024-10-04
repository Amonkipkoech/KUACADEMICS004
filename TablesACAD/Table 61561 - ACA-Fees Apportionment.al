table 61561 "ACA-Fees Apportionment"
{

    fields
    {
        field(1; Course; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FUCULTY-DEPT'));
        }
        field(2; "Start Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Appotionment (M)"; Decimal)
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; Course, "Start Date")
        {
        }
    }

    fieldgroups
    {
    }
}

