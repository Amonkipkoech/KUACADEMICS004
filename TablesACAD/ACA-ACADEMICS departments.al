table 70201 "ACA-Academic Departments"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));


        }
        field(2; "Department Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Department Code")));
        }
        field(3; "Faculty Code"; Code[20])
        {
            TableRelation = "ACA-Schools/Faculties";
        }
        field(4; "HOD Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)";
        }

    }

    keys
    {
        key(Key1; "Department Code")
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