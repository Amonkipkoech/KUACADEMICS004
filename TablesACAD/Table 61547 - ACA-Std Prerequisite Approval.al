table 61547 "ACA-Std Prerequisite Approval"
{

    fields
    {
        field(1; "Reg. Transaction ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Course Registration"."Reg. Transacton ID";
        }
        field(2; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; Programme; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(4; Stage; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(5; Prerequisite; Text[150])
        {
        }
        field(6; Mandatory; Boolean)
        {
        }
        field(7; Approved; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Reg. Transaction ID", Prerequisite)
        {
        }
    }

    fieldgroups
    {
    }
}

