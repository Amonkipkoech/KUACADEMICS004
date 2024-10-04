table 61514 "ACA-Day Of Week"
{
    DrillDownPageID = "ACA-Days Of Week";
    LookupPageID = "ACA-Days Of Week";

    fields
    {
        field(1; Day; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Start Time"; Time)
        {
        }
        field(3; "End Time"; Time)
        {
        }
        field(4; Remarks; Text[200])
        {
        }
        field(5; Hours; Decimal)
        {
        }
        field(6; "No."; Integer)
        {
        }
        field(7; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(8; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Stages"."Programme Code" WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(9; "Unit Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                           "Stage Code" = FIELD("Stage Filter"));
        }
        field(10; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Programme Filter"));
        }
        field(11; "Lecture Room Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Lecture Rooms".Code;
        }
        field(12; "Class Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Course Classes".Code WHERE(Programmes = FIELD("Programme Filter"),
                                                             Stage = FIELD("Stage Filter"));
        }
        field(13; "Student Type"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Full Time,Part Time,Distance Learning';
            OptionMembers = " ","Full Time","Part Time","Distance Learning";
        }
        field(14; "Lecturer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = CONST(true));
        }
        field(15; "Unit Class Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Units Classes".Code WHERE(Programmes = FIELD("Programme Filter"),
                                                            Stage = FIELD("Stage Filter"),
                                                            Unit = FIELD("Unit Class Filter"));
        }
        field(16; "Exam Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exams".Code WHERE("Programme Code" = FIELD("Programme Filter"),
                                                  "Stage Code" = FIELD("Stage Filter"),
                                                  Semester = FIELD("Semester Filter"));
        }
        field(17; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = GEN-Departments.Code;
        }
        field(18; Exams; Boolean)
        {
        }
        field(19; "Exam No."; Integer)
        {
        }
        field(20; "Campus Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
    }

    keys
    {
        key(Key1; "No.", Day)
        {
        }
    }

    fieldgroups
    {
    }
}

