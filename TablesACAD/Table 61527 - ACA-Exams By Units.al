table 61527 "ACA-Exams By Units"
{
    // DrillDownPageID = 67032;
    // LookupPageID = 67032;

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
        }
        field(3; "Unit Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"),
                                                           "Stage Code" = FIELD("Stage Code"));
        }
        field(4; Semester; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(5; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(6; Desription; Text[200])
        {
        }
        field(7; "Max. Score"; Decimal)
        {
        }
        field(8; "% Contrib. Final Score"; Decimal)
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(12; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", "Unit Code", Semester, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

