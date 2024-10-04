table 61526 "ACA-Exams"
{
    //LookupPageID = 68115;

    fields
    {
        field(1; "Programme Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme".Code;
        }
        field(2; "Stage Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(3; Semester; Code[20])
        {
            NotBlank = false;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(4; "Code"; Code[50])
        {
            NotBlank = false;
            TableRelation = "ACA-Exam Codes"."Exam Code";
        }
        field(5; Desription; Text[200])
        {
            NotBlank = false;
            TableRelation = "ACA-Exam Codes"."Exam Code";
        }
        field(9; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(11; Remarks; Text[150])
        {
        }
        field(12; Type; Option)
        {
            NotBlank = true;
            OptionMembers = ,CATS,"Final Exam",Supplementary,Special,Project,Assignments,Attachment;
        }
        field(13; "Exam Code"; Code[50])
        {
            NotBlank = false;
        }
        field(14; Date; Date)
        {
        }
        field(15; "Exam Body"; Code[50])
        {
            TableRelation = "ACA-Exam Bodies".Code;
        }
        field(16; Designation; Code[50])
        {
            TableRelation = "ACA-Exam Bodies".Code;
        }
        field(17; Unit; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"),
                                                           "Stage Code" = FIELD("Stage Code"));
        }
        field(24; "Campus Code"; Code[50])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(27; "UNISA No."; Code[50])
        {
        }
        field(28; "JKUAT No."; Code[50])
        {
        }
        field(29; "KNEC No."; Code[50])
        {
        }
        field(30; "Campus Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(31; "Programme Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(32; "Stage Filter"; Code[60])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(33; "Semester Filter"; Code[80])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(34; "Unit Filter"; Code[80])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(35; "Exam Filter"; Code[150])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams".Code;
        }
        field(36; "Max.Score"; Integer)
        {
            TableRelation = "ACA-Exams"."Max.Score";
        }
        field(37; "Contribution %"; Decimal)
        {
            TableRelation = "ACA-Exams"."Contribution %";
        }
        field(38; Amount; Decimal)
        {
        }
        field(39; Faculty; Code[10])
        {
            TableRelation = "ACA-Exam Faculty".Code;
        }
        field(40; "Exam Period"; Code[20])
        {
            Caption = 'Exam Series';
            TableRelation = "ACA-Exam Periods".Code;
        }
        field(41; "Grading System"; Option)
        {
            OptionMembers = Default,Custom;
        }
        field(42; DuplicateExams; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Codes"."Exam Code";
        }
        field(43; DuplicateSem; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Code"));
        }
        field(44; DuplicateType; Option)
        {
            FieldClass = Normal;
            OptionMembers = ,CATS,"Final Exam",Supplementary,Special;
        }
        field(45; DuplicatePeriod; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Periods".Code;
        }
        field(46; DuplicateUnit; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Code"),
                                                           "Stage Code" = FIELD("Stage Code"));
        }
        field(47; "Exam Series Filter"; Code[150])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Periods".Code;
        }
    }

    keys
    {
        key(Key1; "Programme Code", "Stage Code", Unit, Semester, "Code", "Exam Period")
        {
        }
    }

    fieldgroups
    {
    }
}

