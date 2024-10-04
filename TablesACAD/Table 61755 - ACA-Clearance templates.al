table 61755 "ACA-Clearance templates"
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
        field(3; Active; Boolean)
        {
        }
        field(4; "Approvers Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Clearance Dept. Approvers" WHERE("Clearance Level Code" = FIELD("Clearance Level Code"),
                                                                       Department = FIELD(Department)));
            FieldClass = FlowField;
        }
        field(5; "Priority Level"; Option)
        {
            OptionCaption = 'Normal,1st Level,Final level';
            OptionMembers = Normal,"1st Level","Final level";
        }
        field(6; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Department)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Clearance Level Code", Department)
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

