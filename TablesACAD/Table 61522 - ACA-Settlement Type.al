table 61522 "ACA-Settlement Type"
{
    DrillDownPageID = 68747;
    LookupPageID = 68747;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; Remarks; Text[150])
        {
        }
        field(4; Installments; Boolean)
        {
        }
        field(5; "Tuition G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Reg. No Prefix"; Code[20])
        {
        }
        field(7; ModeofStudy; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnModify()
    begin
        if UserId <> 'frankie' then Error('You are mot Allowed to Modify!!');
    end;
}

