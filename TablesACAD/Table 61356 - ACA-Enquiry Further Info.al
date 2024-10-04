table 61356 "ACA-Enquiry Further Info"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Description = 'Stores the reference to the enquiry in the database in relation to the enquiry in the database';
        }
        field(2; "Further info Code"; Code[20])
        {
            Description = 'Stores the code of the further information in the database';
            TableRelation = "ACA-Futher Info Setup"."Further Info Code";
        }
        field(3; "Further Info Description"; Text[50])
        {
            CalcFormula = Lookup("ACA-Futher Info Setup"."Further Info Name" WHERE("Further Info Code" = FIELD("Further info Code")));
            Description = 'Stores the description of the further info in the databae';
            FieldClass = FlowField;
        }
        field(4; Select; Boolean)
        {
            Description = 'Stores the state of the further in the database';
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", "Further info Code")
        {
        }
    }

    fieldgroups
    {
    }
}

