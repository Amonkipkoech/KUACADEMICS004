/// <summary>
/// Table Lect Load Permissions (ID 65207).
/// </summary>
table 65207 "Lect Load Permissions"
{

    fields
    {
        field(1; "User Id"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Create Batch"; Boolean)
        {
        }
        field(3; "Edit Batch"; Boolean)
        {
        }
        field(4; "Create Load List"; Boolean)
        {
        }
        field(5; "Edit Load List"; Boolean)
        {
        }
        field(6; "Create Load Details"; Boolean)
        {
        }
        field(7; "Edit Load Details"; Boolean)
        {
        }
        field(8; "Approve Loads"; Boolean)
        {
        }
        field(9; "Return Finance Approver"; Boolean)
        {
        }
        field(10; "Return Quality Approver"; Boolean)
        {
        }
        field(11; "Modify After Approval"; Boolean)
        {
        }
        field(12; "Delete After Approval"; Boolean)
        {
        }
        field(13; "Insert After Approval"; Boolean)
        {
        }
        field(14; "Can Reverse a Posted Load"; Boolean)
        {
        }
        field(15; "Can Create a Swap"; Boolean)
        {
        }
        field(16; "Can Modify Swap"; Boolean)
        {
        }
        field(17; "Can Approve Swap"; Boolean)
        {
        }
        field(18; "Can Reverse Swap"; Boolean)
        {
        }
        field(19; "Can Approve Claim"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Claims Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENTS' | 'DEPARTMENT'));
        }
        field(21; "Claims Department Name"; Text[220])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FILTER('DEPARTMENTS' | 'DEPARTMENT'),
                                                               Code = FIELD("Claims Department")));
            FieldClass = FlowField;
        }
        field(22; "Claim Campus"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));
        }
        field(23; "Can Approve Units"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Input Rate"; Boolean)
        {
        }
        field(25; "Input Hours"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

