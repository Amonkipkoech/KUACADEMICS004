table 61574 "ACA-Exam Complaint Students"
{

    fields
    {
        field(1; Compalint; Code[30])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Student No."; Code[50])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = CONST(Student));

            trigger OnValidate()
            begin
                Students.RESET;
                Students.SETFILTER(Students."No.", "Student No.");
                IF Students.FIND('-') THEN
                    Names := Students.Name;
            end;
        }
        field(4; Names; Text[150])
        {
        }
        field(5; Remark; Text[150])
        {
        }
        field(6; "Exam Code"; Code[30])
        {
            TableRelation = "ACA-Exams".Code;
        }
        field(7; Unit; Code[30])
        {
            TableRelation = "ACA-Exams".Unit;
        }
        field(8; Period; Code[30])
        {
            TableRelation = "ACA-Exams"."Exam Period";
        }
    }

    keys
    {
        key(Key1; Date)
        {
        }
        key(Key2; "Student No.")
        {
        }
        key(Key3; "Exam Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Students: Record "Customer";
}

