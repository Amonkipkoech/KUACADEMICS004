table 77718 "ACA-Senate Report Status Buff."
{

    fields
    {
        field(1; "Prog. Code"; Code[20])
        {
        }
        field(2; StatusCode; Code[100])
        {
        }
        field(3; Counts; Integer)
        {
        }
        field(4; YoS; Integer)
        {
        }
        field(5; "Academic Year"; Code[20])
        {
        }
        field(6; "Student No."; Code[20])
        {
        }
        field(7; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Exists in Counts"; Boolean)
        {
            CalcFormula = Exist("ACA-Senate Report Counts" WHERE("Prog. Code" = FIELD("Prog. Code"),
                                                                  "Academic Year" = FIELD("Academic Year"),
                                                                  "Student No." = FIELD("Student No."),
                                                                  "User ID" = FIELD("User ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Prog. Code", StatusCode, YoS, "Academic Year", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

