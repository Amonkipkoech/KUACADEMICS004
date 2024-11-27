table 65801 "Class Attendance Details"
{

    fields
    {
        field(1; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(21; Block; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(2; "Attendance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Lecturer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
        }
        field(13; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Student Name"; Text[150])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(15; Present; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Counting; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Present Counting"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Class Attendance Details" where("Student No." = field("Student No."), "Unit Code" = field("Unit Code"), Semester = field(Semester), Present = filter(true)));
        }
        field(19; "Absent Counting"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Class Attendance Details" where("Student No." = field("Student No."), "Unit Code" = field("Unit Code"),
             Semester = field(Semester), Present = filter(false)));
        }

        field(20; "Total Classes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Class Attendance Details" where("Student No." = field("Student No."), "Unit Code" = field("Unit Code"), Semester = field(Semester)));
        }
        field(28; "Remarks"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Semester, "Attendance Date", "Unit Code", "Student No.", "Lecturer Code", Counting)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ACASemester: Record "ACA-Semester";
        Customer: Record Customer;
}

