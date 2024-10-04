table 61212 "ACA-Class Allocation"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Programme; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "ACA-Programme".Code;
        }
        field(3; Stage; Code[20])
        {
            TableRelation = "ACA-Programme Stages".Code;
        }
        field(4; Semester; Code[20])
        {
            TableRelation = "ACA-Programme Semesters".Semester;
        }
        field(5; Campus; Code[20])
        {
        }
        field(6; "Students Range"; Code[50])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));
        }
        field(7; "Student Count"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE(Programmes = FIELD(Programme),
                                                                 Stage = FIELD(Stage),
                                                                 Semester = FIELD(Semester),
                                                                 "Student No." = FIELD("Students Range")));
            FieldClass = FlowField;
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "Class Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //IF Code = '' THEN BEGIN

        GenSetup.GET;
        GenSetup.TESTFIELD(GenSetup."Class Allocation Nos.");
        NoSeriesLine.RESET;
        NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", GenSetup."Class Allocation Nos.");
        NoSeriesLine.FIND('-');
        Code := INCSTR(NoSeriesLine."Last No. Used");
        NoSeriesLine."Last No. Used" := INCSTR(NoSeriesLine."Last No. Used");
        NoSeriesLine.MODIFY;
    end;

    var
        GenSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesLine: Record "No. Series Line";
}

