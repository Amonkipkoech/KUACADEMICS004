table 74518 "TT-Lecturers"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Lecturer Code"; Code[20])
        {

            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                IF HRMEmployeeC.GET(Rec."Lecturer Code") THEN BEGIN
                    Rec."Lecturer Name" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                END;
            end;
        }
        field(4; "Lecturer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Lecturer Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRMEmployeeC: Record 61188;
}

