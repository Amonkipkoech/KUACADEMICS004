table 61349 "ACA-Programme Attach Setup"
{

    fields
    {
        field(1; Programmes; Code[20])
        {
            Description = 'Stores the reference code of the programme in the database';
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Programme Stage"; Code[20])
        {
            Description = 'Stores the reference code of the programme stage in the database';
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD(Programmes));
        }
        field(3; "Attachment Code"; Code[20])
        {
            Description = 'Stores the attachment code in the database';
            TableRelation = "ACA-Attachments Setup"."Attachment Code";
        }
        field(4; Mandatory; Boolean)
        {
            Description = 'Stores the state of teh attachment in relation to the programme and the programme stage whether it is mandatory or not';
        }
    }

    keys
    {
        key(Key1; Programmes, "Programme Stage", "Attachment Code")
        {
        }
    }

    fieldgroups
    {
    }
}

