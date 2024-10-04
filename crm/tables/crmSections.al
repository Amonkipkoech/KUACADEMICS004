table 86637 "ACA-crmSections"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; lineNo; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "Section"; code[20])
        {

        }
        field(3; Department; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
       
    }

    keys
    {
        key(Key1; lineNo, Section)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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