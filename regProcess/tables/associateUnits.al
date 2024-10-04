table 86619 "acaAssosiateUnits"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entry; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; UnitBaseCode; Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code where("Programme Code" = field("Program"));
        }
        field(3; "Program"; code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(4; Department; Text[150])
        {
            CalcFormula = lookup("ACA-Programme"."Department Name" where(Code = field("Program")));
            FieldClass = FlowField;
        }
        field(5; "Associated Unit"; code[20])
        {
            TableRelation = "ACA-Units Master Table";
        }
        field(6; RegisteredStuddents; Integer)
        {
            CalcFormula = count("ACA-Student Units" where(Unit = field(UnitBaseCode), Unit = field("Associated Unit")));
            FieldClass = FlowField;
        }
        field(7; coStreams; code[20])
        {

        }
    }

    keys
    {
        key(Key1; entry, "Associated Unit", UnitBaseCode)
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