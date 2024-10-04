table 66651 "ACA-Exam. Course Registration"
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
            TableRelation = "ACA-Programme".Code;
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
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       //"Year of Study." = FIELD("Year of Study"),
                                                                       "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(14; "Total Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    //"Year of Study" = FIELD("Year of Study"),
                                                                                    "Academic Year" = FIELD("Academic Year")));
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
        field(17; "Final Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                           Programme = FIELD(Programme),
                                                                                           "Year of Study" = FIELD("Year of Study"),
                                                                                           "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"),
                                                                                            Programme = FIELD(Programme),
                                                                                            "Year of Study" = FIELD("Year of Study"),
                                                                                            "Academic Year" = FIELD("Academic Year")));
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
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Pass = FILTER('No'),
                                                                       Programme = FIELD(Programme),
                                                                       "Academic Year" = FIELD("Academic Year")));
            //  "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(23; "Total Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Pass = FILTER(false),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Academic Year" = FIELD("Academic Year"),
                                                                                    "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(24; "Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Pass = FILTER(false),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(25; "Failed Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Pass = FILTER(false),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Academic Year" = FIELD("Academic Year"),
                                                                                    "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(26; "Failed Cores"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Pass = FILTER(false),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Academic Year" = FIELD("Academic Year"),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(27; "Failed Required"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Pass = FILTER(false),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Academic Year" = FIELD("Academic Year"),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(28; "Failed Electives"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Pass = FILTER(false),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Academic Year" = FIELD("Academic Year"),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Unit Type" = FILTER('ELECTIVES')));
            FieldClass = FlowField;
        }
        field(29; "Total Cores Done"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Unit Type" = FILTER('CORE'),
                                                                                    "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(30; "Total Cores Passed"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       Pass = FILTER(true),
                                                                       "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(31; "Total Required Done"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(32; "Total Electives Done"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(33; "Tota Electives Passed"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       Pass = FILTER(true),
                                                                       "Unit Type" = FILTER('ELECTIVE')));
            FieldClass = FlowField;
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('ELECTIVE'),
                                                                       "Allow In Graduate" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(35; "Classified Electives Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Unit Type" = FILTER('ELECTIVE'),
                                                                                    "Allow In Graduate" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(36; "Total Classified C. Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(true),
                                                                       Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(37; "Total Classified Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                     Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Allow In Graduate" = FILTER(true),
                                                                                    Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(38; "Classified Total Marks"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"),
                                                                                           Programme = FIELD(Programme),
                                                                                          "Year of Study" = FIELD("Year of Study"),
                                                                                           "Allow In Graduate" = FILTER(true),
                                                                                           Pass = FILTER(true)));
            FieldClass = FlowField;
        }
        field(39; "Classified W. Total"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"),
                                                                                            Programme = FIELD(Programme),
                                                                                            "Year of Study" = FIELD("Year of Study"),
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
        field(47; "Average"; Decimal)
        {
            Caption = 'Average';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = average("ACA-Exam Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Academic Year" = FIELD("Academic Year")));
        }
        field(48; "Total Required Passed"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
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
            DataClassification = ToBeClassified;
        }
        field(51; "Attained Stage Units"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(52; "Units Deficit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Multiple Programe Reg. Exists"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Cohort; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Programme Option"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme Options".Code WHERE("Programme Code" = FIELD(Programme));
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
        field(60; "% Total Failed Courses"; Decimal)
        {
        }
        field(61; "% Total Failed Units"; Decimal)
        {
        }
        field(62; "% Failed Courses"; Decimal)
        {
        }
        field(63; "% Failed Units"; Decimal)
        {
        }
        field(64; "% Failed Cores"; Decimal)
        {
        }
        field(65; "% Failed Required"; Decimal)
        {
        }
        field(66; "% Failed Electives"; Decimal)
        {
        }
        field(67; Finalist; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Provisional Transcript Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Transcript Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Record Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Rubric Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Total Failed Core Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    Pass = FILTER(false),
                                                                                    "Unit Type" = FILTER('CORE'),
                                                                                    "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(73; "Reporting Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Category Order"; Integer)
        {
        }
        field(75; "Prog. Category"; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD(Programme)));
            FieldClass = FlowField;
            OptionCaption = ',Certificate,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
        field(76; "Prog. Option Name"; Text[150])
        {
            CalcFormula = Lookup("ACA-Programme Options".Desription WHERE("Programme Code" = FIELD(Programme),
                                                                           Code = FIELD("Programme Option")));
            FieldClass = FlowField;
        }
        field(77; "Resit Exists"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Processed Marks" = FILTER(true),
                                                           Passed = FILTER(false),
                                                           "Reg. Reversed" = FILTER(false),
                                                           "Student No." = FIELD("Student Number")));
            FieldClass = FlowField;
        }
        field(78; "Cumm. Resit Serial"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Programme Name"; Text[250])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(80; "Required Core Courses"; Integer)
        {
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          "Year of Study" = FIELD("Year of Study"),
                                                          "Unit Type" = FILTER('Core')));
            FieldClass = FlowField;
        }
        field(81; "Required Core Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('Core')));
            FieldClass = FlowField;
        }
        field(82; "Attained Core Courses"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(false),
                                                                       "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(83; "Attained Core Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(true),
                                                                       "Unit Type" = FILTER('CORE')));
            FieldClass = FlowField;
        }
        field(84; "Deficit Core Courses"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Deficit Core Units"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Required Required Courses"; Integer)
        {
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          "Year of Study" = FIELD("Year of Study"),
                                                          "Unit Type" = FILTER('Required')));
            FieldClass = FlowField;
        }
        field(87; "Required Required Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('Required')));
            FieldClass = FlowField;
        }
        field(88; "Attained Required Courses"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(true),
                                                                       "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(89; "Attained Required Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Allow In Graduate" = FILTER(true),
                                                                                    "Unit Type" = FILTER('REQUIRED')));
            FieldClass = FlowField;
        }
        field(90; "Deficit Required Courses"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Deficit Required Units"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Required Electives Courses"; Integer)
        {
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          "Year of Study" = FIELD("Year of Study"),
                                                          "Unit Type" = FILTER('Elective')));
            FieldClass = FlowField;
        }
        field(93; "Required Electives Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Unit Type" = FILTER('Elective')));
            FieldClass = FlowField;
        }
        field(94; "Attained Electives Courses"; Integer)
        {
            CalcFormula = Count("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Programme = FIELD(Programme),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Allow In Graduate" = FILTER(true),
                                                                       "Unit Type" = FILTER('ELECTIVE|ELECTIVES')));
            FieldClass = FlowField;
        }
        field(95; "Attained Electives Units"; Decimal)
        {
            CalcFormula = Sum("ACA-Exam Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"),
                                                                                    Programme = FIELD(Programme),
                                                                                    "Year of Study" = FIELD("Year of Study"),
                                                                                    "Allow In Graduate" = FILTER(true),
                                                                                    "Unit Type" = FILTER('ELECTIVE|ELECTIVES')));
            FieldClass = FlowField;
        }
        field(96; "Deficit Electives Courses"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Deficit Electives Units"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Cummulative Fails"; Integer)
        {
        }
        field(99; "Cumm. Required Stage Units"; Integer)
        {
        }
        field(100; "Cumm Attained Units"; Integer)
        {
        }
        field(101; "Failed Some Units"; Boolean)
        {
            CalcFormula = Exist("ACA-Exam Classification Units" WHERE("Student No." = FIELD("Student Number"),
                                                                       Pass = FILTER(false)));
            FieldClass = FlowField;
        }
        field(102; "Global Dimension 1 Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD("Student Number")));
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('BUSINESS'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Category Order", "Student Number", Programme, "Year of Study", "Academic Year", "School Code", "Reporting Academic Year")
        {
        }
        key(Key2; Programme, "Programme Option", "Student Number", "Category Order")
        {
        }
        key(Key3; "Student Number")
        {
        }
        key(Key4; "Academic Year", "Year of Study", "Student Number")
        {
        }
    }

    fieldgroups
    {
    }
}

