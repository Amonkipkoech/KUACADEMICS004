table 61351 "ACA-Enquiry Medical History"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Description = 'Stores the reference of the enquiry in the database';
        }
        field(2; "Medical Condition Code"; Code[20])
        {
            Description = 'Stores the reference of the enquiry in the database';
            TableRelation = "ACA-Medical Condition Setup"."Medical Condition Code";
        }
        field(3; "Medical Condition Name"; Text[100])
        {
            CalcFormula = Lookup("ACA-Medical Condition Setup"."Medical Condition Name" WHERE("Medical Condition Code" = FIELD("Medical Condition Code")));
            Description = 'Stores the name of the medical condition in the database';
            FieldClass = FlowField;
        }
        field(4; Remarks; Text[100])
        {
            Description = 'Stores the remarks that the user might make in relation to the same in the database';
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", "Medical Condition Code")
        {
        }
    }

    fieldgroups
    {
    }
}

