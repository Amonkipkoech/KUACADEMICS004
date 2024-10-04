table 61350 "ACA-Enquiry Attachment"
{

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Description = 'Stores the reference to the enquiry in the database';
        }
        field(2; Programmes; Code[20])
        {
            Description = 'Stores the reference for the programme in the database';
            TableRelation = "ACA-Enquiry Header".Programmes;
        }
        field(3; "Programme Stage"; Code[20])
        {
            Description = 'Stores the reference of the programme stage in the database';
            TableRelation = "ACA-Enquiry Header"."Programme Stage" WHERE(Programmes = FIELD(Programmes));
        }
        field(4; "Attachment Code"; Code[20])
        {
            Description = 'Stores the reference code of the attachment in the database';
            TableRelation = "ACA-Programme Attach Setup"."Attachment Code" WHERE(Programmes = FIELD(Programmes),
                                                                                  "Programme Stage" = FIELD("Programme Stage"));
        }
        field(5; "Attachment Provided ?"; Boolean)
        {
            Description = 'Stores the state of the attachment whether provided or not';
        }
        field(6; Remarks; Text[100])
        {
            Description = 'Stores any remarks that the user might make in relation to the same';
        }
        field(7; Mandatory; Boolean)
        {
            CalcFormula = Exist("ACA-Programme Attach Setup" WHERE(Mandatory = CONST(true)));
            Description = 'Stores the state of the attachment whether it is mandatory or not';
            FieldClass = FlowField;
        }
        field(8; Description; Text[100])
        {
            CalcFormula = Lookup("ACA-Attachments Setup"."Attachment Name" WHERE("Attachment Code" = FIELD("Attachment Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Enquiry No.", Programmes, "Programme Stage", "Attachment Code")
        {
        }
    }

    fieldgroups
    {
    }
}

