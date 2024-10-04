table 66632 "ACA-Classification Units"
{
    // DrillDownPageID = 66652;
    // LookupPageID = 66652;

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
        field(5; "Credit Hourse"; Decimal)
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
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
        }
        field(19; "Graduation Academic Year"; Code[20])
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
        field(57; "Exists Required Units"; Boolean)
        {
            CalcFormula = Exist("ACA-Classification Course Reg." WHERE("Student Number" = FIELD("Student No."),
                                                                        Programme = FIELD(Programme),
                                                                        "Graduation Academic Year" = FIELD("Graduation Academic Year"),
                                                                        "Year of Study" = FIELD("Year of Study"),
                                                                        "Required Stage Units" = FILTER(> 0)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Unit Code", Programme, "Graduation Academic Year")
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

