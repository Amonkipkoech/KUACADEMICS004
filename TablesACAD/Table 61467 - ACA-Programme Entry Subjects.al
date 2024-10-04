table 61467 "ACA-Programme Entry Subjects"
{
    DrillDownPageID = 68708;
    LookupPageID = 68708;

    fields
    {
        field(1; Programme; Code[20])
        {
            TableRelation = "ACA-Programme".Code;
        }
        field(2; Subject; Code[20])
        {
            TableRelation = "ACA-Applic. Setup Subjects".Code;
        }
        field(3; "Minimum Grade"; Code[20])
        {
            TableRelation = "ACA-Applic. Setup Grade".Code;

            trigger OnValidate()
            begin
                IF GradeSetUp.GET("Minimum Grade") THEN BEGIN
                    "Minimum Points" := GradeSetUp.Points
                END;
            end;
        }
        field(4; "Minimum Points"; Decimal)
        {
        }
        field(5; "Subject Name"; Code[50])
        {
            CalcFormula = Lookup("ACA-Applic. Setup Subjects".Description WHERE(Code = FIELD(Subject)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Programme, Subject)
        {
        }
    }

    fieldgroups
    {
    }

    var
        GradeSetUp: Record "ACA-Applic. Setup Grade";
}

