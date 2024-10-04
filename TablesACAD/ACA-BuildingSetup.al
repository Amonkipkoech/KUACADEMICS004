table 85527 "ACA-Buidings Setups"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Building Code"; Code[20])
        {


        }
        field(2; "Building Name"; Text[100])
        {

        }
        field(3; "Campus Code"; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
       
    }

    keys
    {
        key(Key1; "Building Code")
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