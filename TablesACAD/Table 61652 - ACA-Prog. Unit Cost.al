table 61652 "ACA-Prog. Unit Cost"
{

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Settlement Type"; Code[20])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(3; "Amount Per Unit"; Decimal)
        {
        }
        field(4; "Programme Name"; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(5; "Settlement Desc."; Text[200])
        {
            CalcFormula = Lookup("ACA-Settlement Type".Description WHERE(Code = FIELD("Settlement Type")));
            FieldClass = FlowField;
        }
        field(6; Type; Option)
        {
            OptionCaption = ' ,lumpsum,Per Unit';
            OptionMembers = " ",lumpsum,"Per Unit";
        }
        field(7; "Student Type"; Code[20])
        {
            TableRelation = "ACA-Student Types".Code;
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Settlement Type", "Student Type")
        {
        }
    }

    fieldgroups
    {
    }
}

