table 86530 "Final Exam Result2"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; ExamEntry; code[20])
        {

        }
        field(3; AcademicYr; code[30])
        {

        }
        field(4; Session; code[250])
        {

        }
        field(2; ProgrammeID; Code[30])
        {
            //TableRelation = "ACA-Programme";
        }
        field(5; StudentID; code[50])
        {
            //TableRelation = Customer."No.";
        }
        field(6; UnitCode; code[20])
        {

        }
        field(7; UnitDesc; Code[250])
        {

        }
        field(50007; Cat; Decimal)
        {

        }
        field(50008; ExamMark; Decimal)
        {

        }
        field(8; MeanScore; Code[10])
        {
            Caption = 'Total Score';
        }
        field(9; MeanGrade; code[10])
        {
            Caption = 'Grade';
        }
        field(10; CreditUnit; code[10])
        {

        }
        field(11; Weight; Decimal)
        {

        }
        field(50004; Creditunits; Decimal)
        {

        }
        field(50005; StudentName; Text[250])
        {
            CalcFormula = lookup(Customer.Name where("No." = field(StudentID)));
            FieldClass = FlowField;
        }
        field(50006; programName; Text[250])
        {
            CalcFormula = lookup("ACA-Programme".Description where(Code = field(ProgrammeID)));
            FieldClass = FlowField;
        }




        // field(50000; Cohort; Code[30])
        // {

        // }
        // field(50001; "Campus Code"; Code[30])
        // {

        // }
        // field(50002; "Entry Sem"; code[10])
        // {

        // }
        // field(50003; "Mode Of Study"; Code[30])
        // {

        // }


    }

    keys
    {
        key(Key1; ExamEntry)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}