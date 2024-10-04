table 78030 "ACA-Scholarships"
{

    DrillDownPageId = "ACA-Scholarships";
    LookupPageId = "ACA-Scholarships";

    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Scholarship Code';
            DataClassification = ToBeClassified;

        }
        field(2; "Scholarship Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Scholarship Category"; Option)
        {
            OptionMembers = " ","Internal","External";
        }
        field(4; Status; Option)
        {
            OptionMembers = " ",Active,Inactive;
        }
        field(5; "Sponsor Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "G/L Account"; Text[50])
        {
            TableRelation = "G/L Account";
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