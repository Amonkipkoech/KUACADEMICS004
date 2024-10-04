table 66654 "ACA-Senate Reports Header"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2; "School Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(3; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Classification Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "School Classification Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(6; "School Total Passed"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(7; "School Total Failed"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(8; "School % Passed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "School % Failed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Calss Caption"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme".Code;
        }
        field(12; "Programme Classification Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(13; "Programme Total Passed"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                      "Final Classification Pass" = FILTER(true),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(14; "Programme Total Failed"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(false),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(15; "Programme % Passed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Programme % Failed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Prog. Class % Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sch. Class % Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "School Total Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code")));
            FieldClass = FlowField;
        }
        field(20; "Prog. Total Count"; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(50005; "Status Msg6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Status Msg1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Status Msg2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Status Msg3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Status Msg4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Status Msg5"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63021; "Summary Page Caption"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63028; "Include Academic Year Caption"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63029; "Academic Year Text"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63030; "Rubric Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63031; "Year of Study"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63032; School_AcadYear_Count; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(63033; School_AcadYear_Status_Count; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(63051; "1st Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63052; "2nd Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63053; "3rd Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63054; "4th Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63055; "5th Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63056; "6th Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63057; "7th Year Grad. Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63058; "Finalists Graduation Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63059; "Grad. Status Msg 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63060; "Grad. Status Msg 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63061; "Grad. Status Msg 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63062; "Grad. Status Msg 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63063; "Grad. Status Msg 5"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63064; "Grad. Status Msg 6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63065; School_AcadYearTrans_Count; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(63066; "Reporting Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63067; SchCat_AcadYear_BarcCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER("Undergraduate")));
            FieldClass = FlowField;
        }
        field(63068; SchCat_AcadYear_Status_BarcCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Undergraduate')));
            FieldClass = FlowField;
        }
        field(63069; SchCat_AcadYearTrans_BarcCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Undergraduate')));
            FieldClass = FlowField;
        }
        field(63070; SchCat_AcadYear_MasCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63071; SchCat_AcadYear_Status_MasCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63072; SchCat_AcadYearTrans_MascCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63073; SchCat_AcadYear_DipCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63074; SchCat_AcadYear_Status_DipCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63075; SchCat_AcadYearTrans_DipCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63076; SchCat_AcadYear_CertCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|Course List')));
            FieldClass = FlowField;
        }
        field(63077; SchCat_AcadYear_Status_CertCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|Course List')));
            FieldClass = FlowField;
        }
        field(63078; SchCat_AcadYearTrans_CertCo; Integer)
        {
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|Course List')));
            FieldClass = FlowField;
        }
        field(63079; Category; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD("Programme Code")));
            FieldClass = FlowField;
            OptionCaption = ',Certificate,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
    }

    keys
    {
        key(Key1; "Academic Year", "School Code", "Classification Code", "Programme Code", "Year of Study", "Reporting Academic Year")
        {
        }
        key(Key2; "Programme Code", "Academic Year", "Year of Study")
        {
        }
    }

    fieldgroups
    {
    }
}

