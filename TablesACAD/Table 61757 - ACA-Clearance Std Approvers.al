table 61757 "ACA-Clearance Std Approvers"
{

    fields
    {
        field(1; "Clearance Level Code"; Code[50])
        {
            TableRelation = "ACA-Clearance Level Codes"."Clearance Level Code";
        }
        field(3; "Clear By Id"; Code[30])
        {
            TableRelation = "User Setup";
        }
        field(4; Active; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code", "Clear By Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Active := TRUE;
    end;
}

