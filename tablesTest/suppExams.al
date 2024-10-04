table 86605 "suppExams"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; regno; code[20])
        {


        }
        field(2; campus; code[20])
        {

        }
        field(3; unitCode; code[20])
        {

        }
        field(4; examtype; code[20])
        {

        }
        field(5; "Stage FiLTER"; Code[20])
        {
            CalcFormula = lookup("ACA-Course Registration".Stage where("Student No." = field(regno)));
            FieldClass = FlowField;
        }
        field(6; programCode; Code[20])
        {
            CalcFormula = lookup("ACA-Course Registration".Programmes where("Student No." = field(regno)));
            FieldClass = FlowField;
        }
        field(8; regID; code[50])
        {
            CalcFormula = lookup("ACA-Course Registration"."Reg. Transacton ID" where("Student No." = field(regno)));
            FieldClass = FlowField;
        }
        field(9; unitDesc; Text[200])
        {
            CalcFormula = lookup("ACA-Units Master Table"."Unit Name" where("Unit Code"= field(unitCode)));
            FieldClass = FlowField;
        }
        field(7; entryNo; Integer)
        {

        }
        
    }

    keys
    {
        key(Key1; entryNo)
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