table 86640 "Programme Setups"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme";
        }
        field(2; "Semester"; Code[20])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(3; "Modeofstudy"; code[20])
        {
            TableRelation = "ACA-Student Types";
        }
        field(4; Campus; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

        }
    }

    keys
    {
        key(Key1; Code, Semester, Campus)
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