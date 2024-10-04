table 84518 getProgram
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entry; code[20])
        {

        }
        field(2; UnitCode; text[50])
        {

        }
        field(3; unitBase; code[20])
        {

        }
        field(4; unitTitle; text[200])
        {

        }
        field(5; Campus; Code[20])
        {

        }
        field(6; programCode; code[20])
        {
            CalcFormula = lookup("ACA-Units Master Table"."Programme Code" where("Unit Code" = field(UnitCode)));
            FieldClass = FlowField;
        }
        field(7; Stage; code[20])
        {
            CalcFormula = lookup("ACA-Units/Subjects"."Stage Code" where(Code = field(UnitCode)));
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



}