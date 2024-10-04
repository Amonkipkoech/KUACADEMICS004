table 77726 "ACA-Senate Report Percentages"
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
        field(7; "Transition Value"; Integer)
        {
            CalcFormula = Count("ACA-Senate Report Counts" WHERE("Prog. Code" = FIELD("Prog. Code"),
                                                                  YoS = FIELD(YoS),
                                                                  "Academic Year" = FIELD("Academic Year"),
                                                                  "IS Pass Status" = FILTER(true),
                                                                  "User ID" = FIELD("User ID")));
            FieldClass = FlowField;

        }
        field(8; "Transition Percentage"; Decimal)
        {
        }
        field(9; "Transition Code"; Code[20])
        {
        }
        field(10; "Status Percentage"; Decimal)
        {
        }
        field(11; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total Students"; Integer)
        {
            CalcFormula = Count("ACA-Senate Report Counts" WHERE("Prog. Code" = FIELD("Prog. Code"),
                                                                  YoS = FIELD(YoS),
                                                                  "Academic Year" = FIELD("Academic Year"),
                                                                  "User ID" = FIELD("User ID")));
            FieldClass = FlowField;
        }
        field(13; "Status Counted"; Integer)
        {
            CalcFormula = Count("ACA-Senate Report Counts" WHERE("Prog. Code" = FIELD("Prog. Code"),
                                                                  YoS = FIELD(YoS),
                                                                  "Academic Year" = FIELD("Academic Year"),
                                                                  StatusCode = FIELD(StatusCode),
                                                                  "User ID" = FIELD("User ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Prog. Code", StatusCode, YoS, "Academic Year", "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

