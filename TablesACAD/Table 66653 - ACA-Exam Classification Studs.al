table 66653 "ACA-Exam Classification Studs"
{

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Student Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(6; "Department Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "School Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Final Stage"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Final Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year";
        }
        field(11; Graduating; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Classification; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Courses"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(14; "Total Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Credit Hourse" WHERE("Student No." = FIELD("Student Number"),
                                                                                Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(15; "Admission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Admission Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Final Academic Year"; Code[21])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                      Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"),
                                                                                       Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(20; "Normal Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Weighted Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Total Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(23; "Total Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                      Programme = FIELD(Programme),
                                                                                      Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(24; "Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(25; "Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Credit Hourse" WHERE("Student No." = FIELD("Student Number"),
                                                                                Programme = FIELD(Programme),
                                                                                Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(26; "Failed Cores"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(27; "Failed Required"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(28; "Failed Electives"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(29; "Total Cores Done"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(30; "Total Cores Passed"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(true),
                                                                  "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(31; "Total Required Done"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(32; "Total Electives Done"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(33; "Tota Electives Passed"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(true),
                                                                  "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Unit Type" = FILTER('ELECTIVE'),
                                                                  "Allow In Graduate" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(35; "Classified Electives Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Credit Hourse" WHERE("Student No." = FIELD("Student Number"),
                                                                                Programme = FIELD(Programme),
                                                                                "Unit Type" = FILTER('ELECTIVE'),
                                                                                "Allow In Graduate" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(36; "Total Classified C. Count"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Allow In Graduate" = FILTER(true),
                                                                  Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(37; "Total Classified Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Credit Hourse" WHERE("Student No." = FIELD("Student Number"),
                                                                                Programme = FIELD(Programme),
                                                                                "Allow In Graduate" = FILTER(true),
                                                                                Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(38; "Classified Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                      Programme = FIELD(Programme),
                                                                                      "Allow In Graduate" = FILTER(true),
                                                                                      Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(39; "Classified W. Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"),
                                                                                       Programme = FIELD(Programme),
                                                                                       "Allow In Graduate" = FILTER(true),
                                                                                       Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(40; "Classified Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Classified W. Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Final Classification"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Final Classification Pass"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Final Classification Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Graduation Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Final Classification Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Total Required Passed"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  Pass = FILTER(true),
                                                                  "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(49; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Required Stage Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Course Reg."."Required Stage Units" WHERE("Student Number" = FIELD("Student Number"),
                                                                                             Programme = FIELD(Programme),
                                                                                            "Graduation Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(51; "Attained Stage Units"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Allow In Graduate" = FILTER(true),
                                                                  Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(52; "Units Deficit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Cohort; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Status Students Count"; Integer)
        {
        }
        field(56; "Programme Option"; Code[20])
        {
            DataClassification = ToBeClassified;
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
        field(60; "% Total Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Year of Study" = FIELD("Year of Study"),
                                                                  Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(61; "% Total Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                      Programme = FIELD(Programme),
                                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                                      Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(62; "% Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Year of Study" = FIELD("Year of Study"),
                                                                  Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(63; "% Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Classification Units"."Credit Hourse" WHERE("Student No." = FIELD("Student Number"),
                                                                                Programme = FIELD(Programme),
                                                                                "Year of Study" = FIELD("Year of Study"),
                                                                                Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(64; "% Failed Cores"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Year of Study" = FIELD("Year of Study"),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(65; "% Failed Required"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Year of Study" = FIELD("Year of Study"),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(66; "% Failed Electives"; Integer)
        {
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                  Programme = FIELD(Programme),
                                                                  "Year of Study" = FIELD("Year of Study"),
                                                                  Pass = FILTER(false),
                                                                  "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(67; Finalist; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Reporting Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student Number", Programme, "Academic Year", "Reporting Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

