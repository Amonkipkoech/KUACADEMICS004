table 61567 "ACA-Exams Setup"
{
    LookupPageID = 68800;

    fields
    {
        field(1; Category; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Exam Category".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Desription; Text[200])
        {
        }
        field(4; "Max. Score"; Decimal)
        {
        }
        field(5; "% Contrib. Final Score"; Decimal)
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(9; Remarks; Text[150])
        {
        }
        field(10; Type; Option)
        {
            OptionCaption = 'Assignment,CAT,Final Exam,Supplementary,Special';
            OptionMembers = Assignment,CAT,"Final Exam",Supplementary,Special;
        }
    }

    keys
    {
        key(Key1; Category, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

