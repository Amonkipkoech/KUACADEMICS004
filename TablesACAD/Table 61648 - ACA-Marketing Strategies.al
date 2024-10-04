table 61648 "ACA-Marketing Strategies"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Students Registered"; Integer)
        {
            CalcFormula = Count("ACA-Applic. Form Header" WHERE("Knew College Thru" = FIELD(Code),
                                                                 "Academic Year" = FIELD("Academic Year filter"),
                                                                 "Intake Code" = FIELD("Intake Code filter"),
                                                                 "Settlement Type" = FIELD("Settlement Type filter")));
            FieldClass = FlowField;
        }
        field(4; "Academic Year filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(5; "Intake Code filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(6; "Settlement Type filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

