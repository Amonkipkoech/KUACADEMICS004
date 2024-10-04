table 84534 getStage
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entry; code[10])
        {


        }
        field(2; stdentNo; text[100])
        {

        }
        field(3; stage; text[20])
        {
            CalcFormula = lookup("ACA-Course Registration".Stage where("Student No." = field(stdentNo), Semester = const('JAN-APR23')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; entry)
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