table 61555 "ACA-Master Fee Structure"
{
    DrillDownPageID = 68748;
    LookupPageID = 68748;

    fields
    {
        field(2; "Stage Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code;
        }
        field(3; "Settlemet Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(4; "Seq."; Integer)
        {
            InitValue = 1;
            NotBlank = true;
        }
        field(5; "Break Down"; Decimal)
        {
        }
        field(6; Remarks; Text[150])
        {
        }
        field(7; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Semesters".Code;
        }
        field(8; "Amount Not Distributed"; Decimal)
        {
        }
        field(9; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
    }

    keys
    {
        key(Key1; "Stage Code", Semester, "Student Type", "Settlemet Type", "Seq.")
        {
        }
    }

    fieldgroups
    {
    }
}

