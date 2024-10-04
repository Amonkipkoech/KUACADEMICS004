table 66650 "ACA-Exam Classification Units"
{
    DrillDownPageID = 66651;
    LookupPageID = 66651;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Credit Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "CAT Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Exam Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Score"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Pass; Boolean)
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Pass WHERE("Academic Year" = FIELD("Academic Year"),
                                                                       "Exam Catregory" = FIELD("Exam Category"),
                                                                       "Total Score" = FIELD("Total Score Decimal"),
                                                                       "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Grade; Code[20])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Grade WHERE("Academic Year" = FIELD("Academic Year"),
                                                                        "Exam Catregory" = FIELD("Exam Category"),
                                                                        "Total Score" = FIELD("Total Score Decimal"),
                                                                        "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(19; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";
        }
        field(54; Cohort; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Use In Classification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Unit Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(57; "Results Exists Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both Exists,CAT Only,Exam Only,None Exists';
            OptionMembers = " ","Both Exists","CAT Only","Exam Only","None Exists";
        }
        field(58; "No. of Resits"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "No. of Repeats"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Department Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Grade Comment"; Text[250])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source".Remarks WHERE("Academic Year" = FIELD("Academic Year"),
                                                                          "Exam Catregory" = FIELD("Exam Category"),
                                                                          "Total Score" = FIELD("Total Score Decimal"),
                                                                          "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
            CalcFormula = Lookup("ACA-Exam Grading Source"."Consolidated Prefix" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                        "Exam Catregory" = FIELD("Exam Category"),
                                                                                        "Total Score" = FIELD("Total Score Decimal"),
                                                                                        "Results Exists Status" = FIELD("Results Exists Status")));
            FieldClass = FlowField;
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Exam Category"; Code[20])
        {
            CalcFormula = Lookup("ACA-Units/Subjects"."Exam Category" WHERE("Programme Code" = FIELD(Programme),
                                                                           Code = FIELD("Unit Code")));
            FieldClass = FlowField;
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; Lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Exists Pass"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student No."),
                                                                       Programme = FIELD(Programme),
                                                                       "Unit Code" = FIELD("Unit Code"),
                                                                       Pass = FILTER(true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Unit Code", Programme, "Academic Year")
        {
        }
        key(Key2; "Total Score")
        {
        }
        key(Key3; "Course Cat. Presidence")
        {
        }
    }

    fieldgroups
    {
    }
}

