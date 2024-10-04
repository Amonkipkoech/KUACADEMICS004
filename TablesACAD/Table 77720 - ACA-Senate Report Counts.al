table 77720 "ACA-Senate Report Counts"
{

    fields
    {
        field(1; "Prog. Code"; Code[20])
        {
        }
        field(2; StatusCode; Code[100])
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
        field(9; "Transition Code"; Code[50])
        {
            CalcFormula = Lookup("ACA-Results Status".Code WHERE(Pass = FILTER(true),
                                                                  "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(11; "IS Pass Status"; Boolean)
        {
            CalcFormula = Lookup("ACA-Results Status".Pass WHERE(Code = FIELD("Prog. Code"),
                                                                  "Academic Year" = FIELD("Academic Year")));
            FieldClass = FlowField;
        }
        field(12; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Counted Recs"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Prog. Code", StatusCode, YoS, "Academic Year", "Student No.", "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

