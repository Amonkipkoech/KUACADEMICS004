table 61756 "ACA-Clearance Dept. Approvers"
{

    fields
    {
        field(1; "Clearance Level Code"; Code[50])
        {
            TableRelation = "ACA-Clearance Level Codes"."Clearance Level Code";
        }
        field(2; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'DEPARTMENT'));
        }
        field(3; "Clear By Id"; Code[30])
        {
            TableRelation = "User Setup";
        }
        field(4; Active; Boolean)
        {
        }
        field(5; "Priority Level"; Option)
        {
            OptionCaption = 'Normal,1st Level,Final level';
            OptionMembers = Normal,"1st Level","Final level";
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code", Department, "Clear By Id")
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

