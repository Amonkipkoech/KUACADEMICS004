table 78001 "ACA-Special Exam Header"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration"."Academic Year" WHERE("Student No." = FIELD("Student No."),
                                                                             Stage = FIELD(Stage),
                                                                             Programmes = FIELD(Programme),
                                                                             Semester = FIELD(Semester));
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration".Semester WHERE("Student No." = FIELD("Student No."),
                                                                      Stage = FIELD(Stage),
                                                                      Programmes = FIELD(Programme));
        }
        field(3; "Exam Session"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Exam Sessions Management"."Exam Session" WHERE(Category = FILTER("Special Exams"));
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(5; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration".Stage WHERE("Student No." = FIELD("Student No."));
        }
        field(6; Programme; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Registration".Programmes WHERE("Student No." = FIELD("Student No."),
                                                                       Stage = FIELD(Stage));
        }
        field(7; "Unit Count"; Integer)
        {
            CalcFormula = Count("Aca-Special Exams Details" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                   Semester = FIELD(Semester),
                                                                   "Exam Session" = FIELD("Exam Session"),
                                                                   "Student No." = FIELD("Student No."),
                                                                   Stage = FIELD(Stage),
                                                                   Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(8; "Total Charge"; Decimal)
        {
            CalcFormula = Sum("Aca-Special Exams Details"."Cost Per Exam" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester),
                                                                                 "Exam Session" = FIELD("Exam Session"),
                                                                                 "Student No." = FIELD("Student No."),
                                                                                 Stage = FIELD(Stage),
                                                                                 Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(9; "Unit Charge"; Decimal)
        {
            CalcFormula = Max("Aca-Special Exams Details"."Cost Per Exam" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester),
                                                                                 "Exam Session" = FIELD("Exam Session"),
                                                                                 "Student No." = FIELD("Student No."),
                                                                                 Stage = FIELD(Stage),
                                                                                 Programme = FIELD(Programme)));
            FieldClass = FlowField;
        }
        field(10; "Units Count (Approved)"; Integer)
        {
            CalcFormula = Count("Aca-Special Exams Details" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                   Semester = FIELD(Semester),
                                                                   "Exam Session" = FIELD("Exam Session"),
                                                                   "Student No." = FIELD("Student No."),
                                                                   Stage = FIELD(Stage),
                                                                   Programme = FIELD(Programme),
                                                                   Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(11; "Total Charge (Approved)"; Decimal)
        {
            CalcFormula = Sum("Aca-Special Exams Details"."Cost Per Exam" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester),
                                                                                 "Exam Session" = FIELD("Exam Session"),
                                                                                 "Student No." = FIELD("Student No."),
                                                                                 Stage = FIELD(Stage),
                                                                                 Programme = FIELD(Programme),
                                                                                 Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(12; "Unit Charge (Approved)"; Decimal)
        {
            CalcFormula = Max("Aca-Special Exams Details"."Cost Per Exam" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                 Semester = FIELD(Semester),
                                                                                 "Exam Session" = FIELD("Exam Session"),
                                                                                 "Student No." = FIELD("Student No."),
                                                                                 Stage = FIELD(Stage),
                                                                                 Programme = FIELD(Programme),
                                                                                 Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(13; Catogory; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Special,Supplementary';
            OptionMembers = " ",Special,Supplementary;
        }
    }

    keys
    {
        key(Key1; "Student No.", Stage, Programme, Semester, "Academic Year", Catogory)
        {
        }
    }

    fieldgroups
    {
    }
}

