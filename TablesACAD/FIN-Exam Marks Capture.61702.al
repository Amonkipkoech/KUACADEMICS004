/// <summary>
/// Table FIN-Exam Marks Capture (ID 61702).
/// </summary>
table 61702 "FIN-Exam Marks Capture"
{

    fields
    {
        field(1; "Student No."; Code[30])
        {
        }
        field(2; "Student Name"; Text[250])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Student No.")));
            FieldClass = FlowField;
        }
        field(3; "Academic Year"; Code[20])
        {
        }
        field(4; Semester; Code[20])
        {
        }
        field(5; "CAT 1"; Decimal)
        {

            trigger OnValidate()
            begin
                prog.RESET;
                prog.SETRANGE(prog.Code, "Programme Code");
                IF prog.FIND('-') THEN BEGIN
                END;

                ExamsSetup.RESET;
                ExamsSetup.SETRANGE(ExamsSetup.Category, prog."Exam Category");
                ExamsSetup.SETFILTER(ExamsSetup.Code, '=%1|%2', 'CAT 1', 'CAT1');
                IF ExamsSetup.FIND('-') THEN BEGIN
                    IF "CAT 1" > ExamsSetup."Max. Score" THEN
                        ERROR('You cant enter score above the maximum score.');
                END ELSE
                    ERROR('Exam setup for ' + FORMAT("Programme Code") + ', ' + FORMAT("Unit Code") + ', not done');
                "Total Score" := "CAT 1" + "CAT 2" + Exam;
            end;
        }
        field(6; "CAT 2"; Decimal)
        {

            trigger OnValidate()
            begin
                prog.RESET;
                prog.SETRANGE(prog.Code, "Programme Code");
                IF prog.FIND('-') THEN BEGIN
                END;

                ExamsSetup.RESET;
                ExamsSetup.SETRANGE(ExamsSetup.Category, prog."Exam Category");
                ExamsSetup.SETFILTER(ExamsSetup.Code, '=%1|%2', 'CAT 2', 'CAT2');
                IF ExamsSetup.FIND('-') THEN BEGIN
                    IF "CAT 2" > ExamsSetup."Max. Score" THEN
                        ERROR('You cant enter score above the maximum score.');
                END ELSE
                    ERROR('Exam setup for ' + FORMAT("Programme Code") + ', ' + FORMAT("Unit Code") + ', not done');
                "Total Score" := "CAT 1" + "CAT 2" + Exam;
            end;
        }
        field(7; Exam; Decimal)
        {

            trigger OnValidate()
            begin
                prog.RESET;
                prog.SETRANGE(prog.Code, "Programme Code");
                IF prog.FIND('-') THEN BEGIN
                END;

                ExamsSetup.RESET;
                ExamsSetup.SETRANGE(ExamsSetup.Category, prog."Exam Category");
                ExamsSetup.SETFILTER(ExamsSetup.Code, '=%1|%2|%3|%4|%5', 'EXAM', 'MAIN', 'MAIN EXAM', 'FINAL', 'FINAL EXAM');
                IF ExamsSetup.FIND('-') THEN BEGIN
                    IF Exam > ExamsSetup."Max. Score" THEN
                        ERROR('You cant enter score above the maximum score.');
                END ELSE
                    ERROR('Exam setup for ' + FORMAT("Programme Code") + ', ' + FORMAT("Unit Code") + ', not done');
                "Total Score" := "CAT 1" + "CAT 2" + Exam;
            end;
        }
        field(8; "Total Score"; Decimal)
        {
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; "Unit Code"; Code[30])
        {
        }
        field(11; "Programme Code"; Code[30])
        {
        }
        field(12; "Reg. Trans Id"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", Semester, "Unit Code", "Programme Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        prog: Record 61511;
        ExamsSetup: Record 61567;


    procedure validateScore(examtype: Code[10]; category: Code[20])
    begin
    end;
}

