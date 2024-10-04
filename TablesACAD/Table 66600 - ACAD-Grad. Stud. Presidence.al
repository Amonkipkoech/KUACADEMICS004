table 66600 "ACAD-Grad. Stud. Presidence"
{
    DrillDownPageID = 66610;
    LookupPageID = 66610;

    fields
    {
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Comments; Code[150])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ((Comments = 'INCOMPLETE') OR (Comments = '') OR (Comments = ' ')) THEN BEGIN
                    "Pass Status" := 'INCOMPLETE'
                END ELSE BEGIN
                    "Pass Status" := 'PASS'
                END;
            end;
        }
        field(4; Presidence; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Exists in Course Registration"; Boolean)
        {
            CalcFormula = Exist("ACA-Course Registration" WHERE("Final Clasification" = FIELD(Comments),
                                                                 "Student No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(6; "Graduation Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Pass Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
        key(Key2; Presidence)
        {
        }
    }

    fieldgroups
    {
    }
}

