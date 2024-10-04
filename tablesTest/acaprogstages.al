table 86604 "Find Stages"
{
    DataClassification = ToBeClassified;

    fields
    {
        // field(1; Lecturer; Code[20])
        // {
        //     //TableRelation = "HRM-Employee (D)";

        // }
        field(2; "Program"; code[20])
        {

        }
        field(3; Unit; code[20])
        {

        }
        // field(4; Campus; code[20])
        // {

        // }

        // field(5; Session; text[100])
        // {

        // }
        // field(6; "fulltime/parttime"; text[100])
        // {

        // }
        field(7; entry; code[10])
        {

        }
        field(8; "Stage FiLTER"; Code[20])
        {
            CalcFormula = lookup("ACA-Units/Subjects"."Stage Code" where("Programme Code" = field("Program"),Code = field(Unit)));
            FieldClass = FlowField;
        }
        // field(9; regNo; code[20])
        // {

        // }

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