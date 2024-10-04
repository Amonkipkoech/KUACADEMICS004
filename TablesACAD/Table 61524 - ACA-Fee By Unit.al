table 61524 "ACA-Fee By Unit"
{
    DrillDownPageID = 68749;
    LookupPageID = 68749;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
             NotBlank = true;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
            // CalcFormula = lookup("ACA-Programme Stages".Code where("Programme Code" = field("Programme Code")));
            // FieldClass = FlowField;
        }
        field(3; "Unit Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(4; "Settlemet Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(5; "Seq."; Integer)
        {
            NotBlank = true;
        }
        field(6; "Break Down"; Decimal)
        {
        }
        field(7; Remarks; Text[150])
        {
        }
        field(9; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(10; "Student Type"; Option)
        {
            OptionCaption = 'Full Time,Part Time,Distance Learning';
            OptionMembers = "Full Time","Part Time","Distance Learning";
        }
        field(11; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", "Unit Code", Semester, "Student Type", "Settlemet Type", "Seq.")
        {
        }
    }

    fieldgroups
    {
    }
}

