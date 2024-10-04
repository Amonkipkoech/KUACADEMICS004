table 77712 "ACA-Student Mandatory Units"
{

    fields
    {
        field(1; "Student No"; Code[20])
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
        field(4; "Student Sat Unit"; Boolean)
        {
            CalcFormula = Exist("ACA-Student Units" WHERE("Student No." = FIELD("Student No"),
                                                           Programme = FIELD(Programme),
                                                           Unit = FIELD("Unit Code"),
                                                           "Results Cancelled" = FILTER(false),
                                                           "Course Registration Cancelled" = FILTER(false)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Student No", Programme, "Unit Code")
        {
        }
    }

    fieldgroups
    {
    }
}

