table 40000  "ACA-Special Exams Charge Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Constant Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Department Name"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Level Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Level; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Faculty Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(8; Faculty; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(9; Campus; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Mode of Study"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Remarks"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; Code)
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