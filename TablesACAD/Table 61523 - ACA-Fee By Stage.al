table 61523 "ACA-Fee By Stage"
{
    DrillDownPageID = 68748;
    LookupPageID = 68748;

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
        field(3; "Settlemet Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(4; "Seq."; Integer)
        {
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
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(8; "Amount Not Distributed"; Decimal)
        {
        }
        field(9; "Student Type"; Option)
        {
            //OptionCaption = ' Full Time,Part Time,Distance Learning';
            OptionMembers = " ",GSS,SSS;
        }
        field(10; "No Of Units"; Integer)
        {
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD("Programme Code"),
                                                          "Stage Code" = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(12; "Copy From Semester"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(13; "Copy To Semester"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(14; "Copy From Programme"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(15; "Copy To Programme"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(16; "Campus"; Code[20])
        {
             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));
        }
        field(50000; "Programme Description"; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(50001; "Stage Description"; Text[150])
        {
            CalcFormula = Lookup("ACA-Programme Stages".Description WHERE(Code = FIELD("Stage Code")));
            FieldClass = FlowField;
        }
        field(50002; "Stage Charges"; Decimal)
        {
            CalcFormula = Sum("ACA-Stage Charges".Amount WHERE("Programme Code" = FIELD("Programme Code"),
                                                                "Stage Code" = FIELD("Stage Code"),
                                                                "Settlement Type" = FIELD("Settlemet Type")));
            FieldClass = FlowField;
        }
        field(50003; "programme Name"; Text[250])
        {
        }
        
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", Semester, "Student Type", "Settlemet Type", "Seq.", Campus,"Break Down")
        {
        }
    }

    fieldgroups
    {
    }

    // trigger OnDelete()
    // begin
    //     ERROR('Deletion not allowed contact system administrator');
    // end;
}

